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
" stop auto unindent w/ # comments (thinks everything is a preproc directive)
filetype plugin indent on
runtime macros/matchit.vim
" save the clipboard when vim exits
autocmd VimLeave * call system("xsel -ib", getreg('+'))
" search recursively for a tags file; generate in a dir with `ctags -R *` (exuberant-ctags)
set tags=./tags;/
nnoremap Q <Nop>
set noswapfile
let mapleader = "-"
let maplocalleader = "\\"
set pastetoggle=<F2>
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

" for ocaml, do opam user-setup install and it will add lines below
