" =============================================================================
" Basic
" =============================================================================

" {{{

" %で対になるタグなどに飛ぶ
runtime macros/matchit.vim

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
if executable('pt')  " agから移行
    set grepprg=pt\ --nogroup\ --nocolor
endif
" grepなどの後に:cw実行
autocmd QuickFixCmdPost *grep* cwindow

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

" make
let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif

" }}}

" =============================================================================
" Mappings
" =============================================================================

" {{{

" leaderをマッピング
let mapleader=','
noremap \ ,

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
" TODO: 候補一覧と競合するので検討
cnoremap <C-d> <Del>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos() - 2]<CR>

" Insert operation like Emacs
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
" TODO: ダイグラフと競合するので検討
inoremap <C-k> <C-o>D

" Moving cursor in insert mode
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Moving cursor
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Comment out
nmap <leader>/ gcc
vmap <leader>/ gc

"
cnoreabbrev Q q
cnoreabbrev W w
cnoreabbrev Noh noh

" .vimrc short cut
command! Preferences edit $MYVIMRC

" }}}

" =============================================================================
" Color scheme
" =============================================================================

" {{{

" Override color scheme
augroup change-color-scheme
    autocmd!
    autocmd ColorScheme * highlight Visual ctermbg=12 ctermfg=15
    autocmd ColorScheme * highlight Cursor guifg=NONE guibg=#ff39d9
augroup END

set t_Co=256

if !has("gui_running")
    if $COLORTERM == 'gnome-terminal'
        set term=gnome-256color
    else
        if $TERM == 'xterm'
            set term=xterm-256color
        endif
    endif
endif

if &term =~ '256color'
    set t_ut=
endif

" }}}

" =============================================================================
" Visual
" =============================================================================

" {{{

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

" Disable visualbell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Cursor
set cursorline
set scrolloff=1

" Cursor(Plugin使わない時用)
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

" }}}

"=============================================================================
"" Functions
"=============================================================================

" {{{

if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wrapmargin=2
        set textwidth=79
    endfunction
endif

" jq
" 参考: https://qiita.com/tekkoc/items/324d736f68b0f27680b8
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction

" }}}

"=============================================================================
"" Autocmd Rules
"=============================================================================

" {{{

" TODO: 検討

"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
    autocmd!
    autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" vimrcの折りたたみ
" autocmd FileType vim setlocal foldmethod=marker

" }}}

" =============================================================================
" Import plugin
" =============================================================================

if filereadable(expand('~/.vim/plugin.vim'))
    source ~/.vim/plugin.vim
endif
