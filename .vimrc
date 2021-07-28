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

" Plugins
" clone to ~/.vim/pack/vendor/start then run :helptags ALL in vim as root

" Syntastic plugin (run :lopen to view error messages)
" https://github.com/vim-syntastic/syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_ocaml_checkers = ['merlin']

" OCaml / merlin
"let g:opamshare = substitute(system('opam var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"
"let g:ocpindentshare = substitute(system('opam var ocp-indent:share'),'\n$','','''')
"execute 'autocmd FileType ocaml source' . g:ocpindentshare . '/vim/indent/ocaml.vim'

