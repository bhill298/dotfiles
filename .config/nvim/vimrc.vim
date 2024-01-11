" ~/.config/nvim/init.vim OR :exe 'edit '.stdpath('config').'/init.vim'
" see :help nvim-from-vim
" then put packages in ~/.config/nvim/pack/plugins/start
" :scriptnames to see what's loaded

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
autocmd FileType qf nnoremap <silent><buffer> <Space> <CR>:tabdo cclose<CR>
" disable quickfix highlight (can also use ctermbg=black to be less obnoxious)
hi QuickFixLine guibg=NONE ctermbg=none
" search recursively for a tags file; generate in a dir with `ctags -R *` (exuberant-ctags)
set tags=./tags;/
nnoremap Q <Nop>
set noswapfile
let mapleader = "-"
let maplocalleader = "\\"
" No longer necessary in neovim
" set pastetoggle=<F2>
" control + L hides current search highlight
nnoremap <nowait><silent> <C-L> :noh<CR>
" open a new tab page before loading the buffer to switch to
" also use an existing tab if it already exists
set switchbuf+=usetab,newtab
" grep in current directory under cursor (opens a quickfix window)
" this replaces the default gs sleep for 1s keybinding, which is useuless
"nnoremap gs :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
nnoremap <silent> gs :execute "Grep " . '"' . expand("<cword>") . '"'<CR>
nnoremap <silent> gS :execute "Grep " . '"' . expand("<cWORD>") . '"'<CR>
" merges the current pane (vertically) to next tab, then merges to previous tab
" Moving to prev tab is a bit wonky in that it merges to the right at first
nnoremap mt :call MoveToNextTab()<CR><C-w>H
nnoremap mT :call MoveToPrevTab()<CR><C-w>H
" enable mouse support
set mouse=a
" set registers to share with system clipboard (works nicely with set mouse=a)
" requires vim-gui-common package in ubuntu or +xterm_clipboard feature
set clipboard=unnamedplus
" unmess up tmux colors (next 3 lines)
set background=dark
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
" don't overwrite clipboad when visual pasting
vnoremap p "0p
vnoremap P "0P

let asmsyntax="nasm"

" Fix syntax highlighting breaking while scrolling sometimes (may be slow)
" can also try: syntax sync minlines=200
" autocmd BufEnter * syntax sync fromstart

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
nnoremap <Leader>b :<C-u>Buffers<CR>
nnoremap <Leader>f :<C-u>GitFiles<CR>
nnoremap <Leader>F :<C-u>Files<CR>
nnoremap <Leader>t :<C-u>Tags<CR>
nnoremap <Leader>c :<C-u>BCommits<CR>
nnoremap <Leader>C :<C-u>Commits<CR>
nnoremap <Leader>x :<C-u>History:<CR>
nnoremap <Leader>l :<C-u>:BLines<CR>
nnoremap <Leader>L :<C-u>:Lines<CR>
" requires ripgrep sudo apt install ripgrep (also RG to launch on every input)
nnoremap <Leader>g :<C-u>:Rg<CR>
" Useful commands
" Enter replaces current buffer, C-t new tab, C-x new split, C-v new vertical split
" files in given directory, default to cwd
" :Files
" # if in git repo, shows files from git root tracked by git
" :GitFiles
" # open buffers
" :Buffers
" # open windows
" :Windows
" # git commit history
" :Commits
" # git commits of file
" :BCommits
" # vim commands
" :Commands
" # file history, [:] is command history, [/] is search history
" :History[:/]
" # search tags if present
" :Tags

" tabline - configure tab labels in vim
" https://github.com/mkitt/tabline.vim
" Install:
" git clone https://github.com/mkitt/tabline.vim ~/.vim/pack/vendor/start/tabline.vim
"
" Syntastic plugin - syntax checking for vim (run :lopen to view error messages)
" https://github.com/vim-syntastic/syntastic
" Install:
" git clone https://github.com/vim-syntastic/syntastic ~/.vim/pack/vendor/start/syntastic
"set statusline+=%#warningmsg#
"let g:syntastic_quiet_messages = { "!level": "errors"}
""set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_ocaml_checkers = ['merlin']
"let g:syntastic_asm_compiler_options = " -m32"

" for ocaml, do opam user-setup install and it will add lines below

" Function definitions not in plugins

" see https://vim.fandom.com/wiki/Move_current_window_between_tabs
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
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
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
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
  "opening current buffer in new window
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
    let options = '-rsFnI --exclude=tags --exclude-dir=.git'
    let pattern = a:1
    let dir = ''
  else
    let options = a:1 . 'snI --exclude=tags --exclude-dir=.git'
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
