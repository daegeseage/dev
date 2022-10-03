" vimrc file.

" vim-plug install
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif


set mouse=
set ttymouse=
set backspace=indent,eol,start
syntax on
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set background=dark
colorscheme blackboard

" plugins
call plug#begin('~/.vim/bundle')
Plug 'itchyny/lightline.vim'
Plug 'pbondoer/vim-42header'
Plug 'ntpeters/vim-better-whitespace'
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
