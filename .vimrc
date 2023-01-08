" vimrc file.

" vim-plug install
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" vim color theme install
if empty(glob("~/.vim/colors/blackboard.vim"))
    execute '!curl -fLo ~/.vim/colors/blackboard.vim --create-dirs https://raw.githubusercontent.com/daegeseage/dev/main/blackboard.vim'
endif


set mouse=
set ttymouse=
set backspace=indent,eol,start
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
colorscheme blackboard

" plugins
call plug#begin('~/.vim/bundle')
Plug 'itchyny/lightline.vim'
Plug 'pbondoer/vim-42header'
Plug 'ntpeters/vim-better-whitespace'
Plug 'hashivim/vim-terraform'
Plug 'chr4/nginx.vim'
call plug#end()

" adding username and mail for 42header
let g:hdr42user = 'daegeseage'
let g:hdr42mail = 'daegeseage98@gmail.com'

" enable of ligthline line.
set laststatus=2

" setting color theme
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ }
