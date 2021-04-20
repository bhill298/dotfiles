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
