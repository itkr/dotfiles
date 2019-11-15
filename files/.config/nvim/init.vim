
" =============================================================================
" Basic
" =============================================================================

" %で対になるタグなどに飛ぶ
runtime macros/matchit.vim

" leaderをマッピング
let mapleader=','
noremap \ ,

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

" Scrolling
set ttyfast

" Fix backspace indent
set backspace=indent,eol,start

" Tabs (May be overriten by autocmd rules)
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
if executable('pt')
    set grepprg=pt\ --nogroup\ --nocolor
endif

" Automatically generated file
set backupskip=/tmp/*,/private/tmp/*  " `crontab -e`が`set nobackup`の指定だけではうまく行かなかった
if has('win32') || has('win64')
    set backupdir=$HOME/AppData/Local/Temp
    set directory=$HOME/AppData/Local/Temp
else
    set backupdir=~/.vim/tmp
    set directory=~/.vim/tmp
endif

" File formats
set fileformats=unix,dos,mac

" Commands
set showcmd

" Decimal number
set nrformats=

" Commandline completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" Buffers
set autoread
set hidden

" Titie
set title
set titlestring=%F

" Clipboard
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

" History
set history=200

" =============================================================================
" Visual
" =============================================================================

" Syntax
syntax on

" Line number
set number

" Mouse
set mousemodel=popup
set mouse=a

" Status line
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Tabline
set showtabline=2

" Cursor
set cursorline
set scrolloff=1

" Cursor
if !has('gui_running')
    if exists('$TMUX')
        let &t_SI = "\ePtmux;\e\e[6 q\e\\"
        let &t_EI = "\ePtmux;\e\e[2 q\e\\"
    else
        let &t_SI.="\e[6 q"
        let &t_EI.="\e[2 q"
        let &t_SR.="\e[4 q"
    endif
endif

" Disable visualbell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" =============================================================================
" Mappings
" =============================================================================

" コマンドラインでカレントディレクトリ表示
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h:p') . '/' : '%%'

" Using the clipboard
noremap YY "+y<CR>
noremap XX "+x<CR>
noremap <leader>p "+gp<CR>
noremap <leader>P "+gP<CR>

" Buffer operation
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>c :Bd<CR>

" Resizing windows
noremap <C-j> <C-w>-
noremap <C-k> <C-w>+
noremap <C-l> <C-w>>
noremap <C-h> <C-w><

" Command line operation like Emacs
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos() - 2]<CR>

" Insert operation like Emacs
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-k> <C-o>D

" Moving cursor in insert mode
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Moving cursor
noremap j gj
noremap k gk
noremap gj j
noremap gk k

"
cnoreabbrev Q q
cnoreabbrev W w

" .vimrc short cut
command! Preferences edit $MYVIMRC
