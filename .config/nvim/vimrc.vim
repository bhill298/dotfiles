" ~/.config/nvim/init.vim OR :exe 'edit '.stdpath('config').'/init.vim'
" see :help nvim-from-vim
" then put packages in ~/.config/nvim/pack/plugins/start
" :scriptnames to see what's loaded

" Function/cmd definitions not in plugins

" see https://vim.fandom.com/wiki/Move_current_window_between_tabs
function MoveToPrevTab()
  " there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  " preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
	winc b
	" vert topleft split
    sp
  else
    close!
    exe "0tabnew"
  endif
  " opening current buffer in new window
  exe "b".l:cur_buf
endfunc
function MoveToNextTab()
  " there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  " preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
	winc b
	" vert topleft split
    sp
  else
    close!
    tabnew
  endif
  " opening current buffer in new window
  exe "b".l:cur_buf
endfunc

" custom vimgrep-like functionality with full grep; use like :Grep ...
" From https://web.archive.org/web/20150319053934/http://amix.dk/blog/post/175
function! Grep(...)
  if a:0 == 0 || a:0 > 3
    echo "Usage: Grep [<options>] <pattern> [<dir>]"
    echo 'Example: Grep -r "cow" ~/Desktop/*'
    return
  endif
  if a:0 == 1
    let options = '-rsFnwI ' . g:grep_extra
    let pattern = a:1
    let dir = ''
  else
    let options = a:1 . 'snI ' . g:grep_extra
    let pattern = a:2
	if a:0 == 3
		let dir = a:3
	else
		let dir = ''
	endif
  endif
  let exclude = 'grep -v "/.svn"'
  let cmd = 'grep '.options.' '.pattern.' '.dir. '| '.exclude
  let cmd_output = system(cmd)
  if cmd_output == ""
    echomsg "Pattern " . pattern . " not found"
    return
  endif

  let tmpfile = tempname()
  exe "redir! > " . tmpfile
  "silent echon '[grep search for "'.pattern.'" with options "'.options.'"]'."\n"
  silent echon cmd_output
  redir END

  let old_efm = &efm
  set efm=%f:%\\s%#%l:%m

  execute "silent! cgetfile " . tmpfile
  let &efm = old_efm
  botright copen

  call delete(tmpfile)
endfunction
command! -nargs=* -complete=file Grep call Grep(<f-args>)

" :tabdo except it returns to the start tab after it's done, rather than
" ending up on the final tab
function! TabDo(cmd)
    let current_tab = tabpagenr()
    execute 'tabdo' a:cmd
    execute 'tabnext' current_tab
endfunction
command! -nargs=1 TabDo call TabDo(<f-args>)

function! ExcludeFiles(fs)
    if !exists("g:rg_extra")
        let g:rg_extra=""
    endif
    if !exists("g:grep_extra")
        let g:grep_extra=""
    endif
    " dirs end in a /
    for _f in a:fs
        let g:rg_extra .= " -g '!'" . _f
        if _f[len(_f) - 1] == '/'
            let g:grep_extra .= " --exclude-dir=" . _f[0:len(_f)-2]
        else
            let g:grep_extra .= " --exclude=" . _f
        endif
    endfor
endfunction

" Custom autocmds for various directories
" autocmd BufRead */dir/path* cmd1 | cmd2 ...

" Settings
" in terminal mode, esc returns to normal mode (enter in current pane with :term)
:tnoremap <Esc> <C-\><C-n>
call ExcludeFiles(["tags", ".git/"])
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set tabpagemax=100
set timeoutlen=1000 ttimeoutlen=10
" line numbers
set number
" toggle with F4
nnoremap <F4> :set number!<CR>
" stop auto unindent w/ # comments (thinks everything is a preproc directive)
filetype plugin indent on
runtime macros/matchit.vim
" save the clipboard when vim exits
autocmd VimLeave * call system("xsel -ib", getreg('+'))
" on space in a quickfix window, close all quickfix windows in all tabs
autocmd FileType qf nnoremap <silent><buffer> <Space> <CR>:TabDo cclose<CR>
" disable quickfix highlight (can also use ctermbg=black to be less obnoxious)
hi QuickFixLine guibg=NONE ctermbg=none
" search recursively for a tags file; generate in a dir with `ctags -R *` (exuberant-ctags)
set tags=./tags;/
nnoremap Q <Nop>
set noswapfile
let mapleader = "-"
let maplocalleader = "\\"
" No longer necessary in neovim
"set pastetoggle=<F2>
" control + L hides current search highlight
nnoremap <nowait><silent> <C-L> :noh<CR>
" Fix color theme for newer nvim (too dark by default)
set notermguicolors
" silent! here to ignore on error since this scheme doesn't exist in older versions
silent! colorscheme vim
" open a new tab page before loading the buffer to switch to (newtab)
" also use an existing tab if it already exists (usetab)
"set switchbuf+=usetab
" grep in current directory under cursor (opens a quickfix window)
" this replaces the default gs sleep for 1s keybinding, which is useuless
"nnoremap gs :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
nnoremap <silent> gs :execute "Grep " . '"' . expand("<cword>") . '"'<CR>
nnoremap <silent> gS :execute "Grep " . '"' . expand("<cWORD>") . '"'<CR>
nnoremap <silent> gl :<C-u>ls<CR>
" go to next, previous buffer (also consiter C-^ for alternate file)
nnoremap <silent> gb :<C-u>bn<CR>
nnoremap <silent> gB :<C-u>bp<CR>
" merges the current pane (vertically) to next tab, then merges to previous tab
" Moving to prev tab is a bit wonky in that it merges to the right at first
nnoremap mt :call MoveToNextTab()<CR><C-w>H
nnoremap mT :call MoveToPrevTab()<CR><C-w>H
" open all buffers in a split
nnoremap <silent> <C-W>a :<C-u>ball<CR>
nnoremap <silent> <C-W>A :<C-u>vertical ball<CR>
" enable mouse support
set mouse=a
" set registers to share with system clipboard (works nicely with set mouse=a)
" requires vim-gui-common package in ubuntu or +xterm_clipboard feature
set clipboard=unnamedplus
" unmess up tmux colors (next 3 lines)
set background=dark
set backspace=indent,eol,start
set t_Co=256
" Remap 'c', 'C', 'd', 'D', 'x' and 'X' to save text in a custom register
" This prevents these commands from overwriting the system clipboard with unnamedplus
" However, this hard sets the registers these commands save to, it cannot be changed on the fly
nnoremap c "cc
vnoremap c "cc
nnoremap C "cC
vnoremap C "cC
nnoremap d "dd
vnoremap d "dd
nnoremap D "dD
vnoremap D "dD
nnoremap x "xx
vnoremap x "xx
nnoremap X "xX
vnoremap X "xX
vnoremap X "xX
" don't overwrite clipboard when visual pasting
vnoremap p "0p
vnoremap P "0P

let asmsyntax="nasm"

" Fix syntax highlighting breaking while scrolling sometimes (may be slow)
" can also try: syntax sync minlines=200
"autocmd BufEnter * syntax sync fromstart

" Plugins
" do `git clone <repo> ~/.vim/pack/vendor/start/<plugin>` then run :helptags ALL in vim (ignore errors)

" fugitive - git support for vim (required by fzf and maybe some others for git support)
" https://github.com/tpope/vim-fugitive.git
" Install:
" git clone https://github.com/tpope/vim-fugitive.git ~/.vim/pack/vendor/start/vim-fugitive.git

" fzf.vim - fuzzy search for vim
" https://github.com/junegunn/fzf.vim
" Install:
" git clone https://github.com/junegunn/fzf.git ~/.vim/pack/vendor/start/fzf && ~/.vim/pack/vendor/start/fzf/install --bin
" git clone https://github.com/junegunn/fzf.vim.git ~/.vim/pack/vendor/start/fzf.vim
" fzf install requires a network connection, binary is placed in ~/.vim/pack/vendor/start/fzf/bin/fzf
" for syntax highlighting preview: sudo apt install bat && ln -s /usr/bin/batcat $HOME/bin/bat
" delta for git diffs: sudo apt install ./file.deb from https://github.com/dandavison/delta/releases (use the musl version to avoid libc conflicts)
" Tags and Helptags require `perl`
" Commands:
" Enter replaces current buffer, C-t new tab, C-x new split, C-v new vertical split
"
" override default rg command
"function! RgCmd(arg)
"    return "rg --column --line-number --no-heading --color=always --smart-case " . a:arg . " " . g:rg_extra . " -- "
"endfunction
"command! -bang -nargs=* Rg
"  \ call fzf#vim#grep(
"  \   RgCmd("").shellescape(<q-args>),
"  \   1,
"  \   fzf#vim#with_preview(),
"  \   <bang>0)
"command! -bang -nargs=* Rgf
"  \ call fzf#vim#grep(
"  \   RgCmd("-F"). '"' . <q-args> .'"',
"  \   1,
"  \   fzf#vim#with_preview(),
"  \   <bang>0)
"nnoremap <Leader>b :<C-u>Buffers<CR>
"nnoremap <Leader>f :<C-u>GitFiles<CR>
"nnoremap <Leader>F :<C-u>Files<CR>
"nnoremap <Leader>t :<C-u>Tags<CR>
"nnoremap <Leader>c :<C-u>BCommits<CR>
"nnoremap <Leader>C :<C-u>Commits<CR>
"nnoremap <Leader>x :<C-u>History:<CR>
"nnoremap <Leader>l :<C-u>:BLines<CR>
"nnoremap <Leader>L :<C-u>:Lines<CR>
" requires ripgrep sudo apt install ripgrep (also RG to launch on every input)
"nnoremap <Leader>s :<C-u>:Rg<CR>
"nnoremap <Leader>g :execute "Rgf " . expand("<cword>")<CR>
"nnoremap <Leader>G :execute "Rgf " . expand("<cWORD>")<CR>

" tabline - configure tab labels in vim
" https://github.com/mkitt/tabline.vim
" Install:
" git clone https://github.com/mkitt/tabline.vim ~/.vim/pack/vendor/start/tabline.vim

" Syntastic plugin - syntax checking for vim (run :lopen to view error messages)
" https://github.com/vim-syntastic/syntastic
" Install:
" git clone https://github.com/vim-syntastic/syntastic ~/.vim/pack/vendor/start/syntastic
"set statusline+=%#warningmsg#
"let g:syntastic_quiet_messages = { "!level": "errors"}
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_ocaml_checkers = ['merlin']
"let g:syntastic_asm_compiler_options = " -m32"

" for ocaml, do opam user-setup install and it will add lines below
