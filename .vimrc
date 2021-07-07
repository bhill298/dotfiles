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
" may ctrl c copy visual selection (linux, X window system only)
vnoremap <C-c> :w !xclip -selection c<CR><CR>
" search recursively for a tags file; generate in a dir with `ctags -R *` (exuberant-ctags)
set tags=./tags;/
" Disable Ex mode shortcut
nnoremap Q <Nop>
" Disable creastion of .swp files
" alternative: set backupdir=~/.vim/backup// set directory=~/.vim/swap// set undodir=~/.vim/undo//
set noswapfile

" Plugins:
" clone to ~/.vim/pack/vendor/start then run :helptags ALL in vim as root

" Syntastic plugin (run :lopen to view error messages)
" https://github.com/vim-syntastic/syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_ocaml_checkers = ['merlin']

" merlin OCaml
"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"
