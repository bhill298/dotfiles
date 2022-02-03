set textwidth=100
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
" make vim recognize comments in C so it doesn't mess up brace matching
runtime macros/matchit.vim
" save the clipboard when vim exits
autocmd VimLeave * call system("xsel -ib", getreg('+'))
" search recursively for a tags file; generate in a dir with `ctags -R *` (exuberant-ctags)
set tags=./tags;/
" Disable Ex mode shortcut
nnoremap Q <Nop>
" Disable creastion of .swp files
" alternative: set backupdir=~/.vim/backup// set directory=~/.vim/swap// set undodir=~/.vim/undo//
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
set term=xterm-256color
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
" don't overwrite clipboard when visual pasting
vnoremap p "0p
vnoremap P "0P

let asmsyntax="nasm"

" Plugins
" do `git clone <repo> ~/.vim/pack/vendor/start/<plugin>` then run :helptags ALL in vim as root

" Syntastic plugin (run :lopen to view error messages)
" https://github.com/vim-syntastic/syntastic
"set statusline+=%#warningmsg#
""set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_ocaml_checkers = ['merlin']

" tabline
" https://github.com/mkitt/tabline.vim

" for ocaml, do 'opam user-setup install' and it will add lines below
