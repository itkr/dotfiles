set nocompatible  " be iMproved
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'scrooloose/nerdtree'

filetype plugin indent on  " required!
filetype indent on


" ==========
" Syntax
" ==========
syntax on

" ==========
" Set
" ==========
set number
set tabstop=4
set autoindent
set shiftwidth=4

" ==========
" inoremap
" ==========
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" ==========
" color
" ==========
"colorscheme solarized
colorscheme molokai
