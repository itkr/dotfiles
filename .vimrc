" NeoBundle
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'scrooloose/nerdtree'
call neobundle#end()

" filetype
filetype plugin indent on
filetype indent on

" Syntax
syntax on

" Set
set number
set tabstop=4
set autoindent
set shiftwidth=4
set nocompatible  " be iMproved

" inoremap
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" color
"colorscheme solarized
"colorscheme molokai
