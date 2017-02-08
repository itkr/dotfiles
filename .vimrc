" TODO: 不要なものを削る
" TODO: GUI 関連を分離する

"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************

if has('vim_starting')
    set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
    echo "Installing Vim-Plug..."
    echo ""
    silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************

let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif

"Plug 'Raimondi/delimitMate'                  " 括弧などの補完 TODO: 検討
Plug 'Shougo/unite.vim'                      " 統合インターフェイス
Plug 'Shougo/vimfiler.vim'                   " ファイラ
Plug 'Shougo/vimproc.vim', {'do': g:make}    " 非同期実行(make)
Plug 'Shougo/vimshell.vim'                   " Vimでシェルを動かす(v:version >= 703)
Plug 'Yggdroot/indentLine'                   " インデントを視覚化
Plug 'airblade/vim-gitgutter'                " 変更箇所表示(git)
Plug 'bronson/vim-trailing-whitespace'       " 行末スペースのハイライト
Plug 'majutsushi/tagbar'                     " -
Plug 'moll/vim-bbye'                         " Bdelete(window構造を変更せずにbdelete) を追加
Plug 'scrooloose/syntastic'                  " 構文チェック
Plug 'sheerun/vim-polyglot'                  " 言語サポート(字下げやシンタックス) TODO: 検討
Plug 'tpope/vim-commentary'                  " 便利にコメントアウト gc
Plug 'tpope/vim-fugitive'                    " Git操作する
Plug 'vim-airline/vim-airline'               " vimを見やすく表示
Plug 'vim-airline/vim-airline-themes'        " vimを見やすく表示(theme)
Plug 'vim-scripts/CSApprox'                  " GVim用カラースキーマ変換
Plug 'vim-scripts/grep.vim'                  " -

"" Session
Plug 'xolox/vim-misc'                        " セッション管理
Plug 'xolox/vim-session'                     " セッション管理

"" Snippets
Plug 'SirVer/ultisnips'                      " Snippets(v:version >=704)
Plug 'FelikZ/ctrlp-py-matcher'               " Snippets(v:version >=704)
Plug 'honza/vim-snippets'                    " Snippets

"" Color
Plug 'altercation/vim-colors-solarized'      " colorscheme
Plug 'w0ng/vim-hybrid'                       " colorscheme

"" HTML Bundle
Plug 'gorodinskiy/vim-coloresque'            " -
Plug 'hail2u/vim-css3-syntax'                " -
Plug 'mattn/emmet-vim'                       " -
Plug 'tpope/vim-haml'                        " -

"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'          " -

"" Python Bundle
Plug 'davidhalter/jedi-vim'                  " pythonのコード補完
"Plug 'hdima/python-syntax'                   " pythonのシンタックスグループを追加
"Plug 'kevinw/pyflakes-vim'                   " flask シンタックスチェック
"Plug 'lambdalisue/vim-pyenv'                 " Vimでpyenvを扱う

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"

"" セッション管理
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"" leaderをマッピング
let mapleader=','

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

"" 10進数を扱う
set nrformats=

"" コマンドラインの補完表示方法
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" grep
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

" TODO: 検討
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

"*****************************************************************************
"" Visual Settings
"*****************************************************************************

" (syntax on の前に書く :h no_buffers_menu)  TODO: 検討
let no_buffers_menu=1

" カラースキーマ上書き
augroup change-color-scheme
    autocmd!
    autocmd ColorScheme * highlight Visual ctermbg=12 ctermfg=15
    autocmd ColorScheme * highlight Cursor guifg=NONE guibg=#ff39d9
augroup END

syntax on
set ruler
set number

if !exists('g:not_finish_vimplug')
    colorscheme hybrid
endif

set mousemodel=popup
set t_Co=256
set guioptions=egmrti

if has("gui_running")
    if has("gui_mac") || has("gui_macvim")
        colorscheme solarized
        set background=light
        set guifont=Menlo:h12
        set transparency=0
    endif
else
    let g:CSApprox_loaded = 1

    " IndentLine
    let g:indentLine_enabled = 1
    let g:indentLine_concealcursor = 0
    let g:indentLine_char = '┆'
    let g:indentLine_faster = 1

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

"" Disable the blinking cursor.
set guicursor=a:blinkon0

"" スクロール時のカーソル
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

"" Title
set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
    set statusline+=%{fugitive#statusline()}
endif

" カーソル
set cursorline

"*****************************************************************************
"" Abbreviations
"*****************************************************************************

" vim-bbye
cnoreabbrev bd Bd
cnoreabbrev bd! Bd!

" VimFiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_leaf_icon      = '┆'
let g:vimfiler_tree_opened_icon    = '▿'
let g:vimfiler_tree_closed_icon    = '▸'
let g:vimfiler_file_icon           = '-'
let g:vimfiler_marked_file_icon    = '*'
let g:vimfiler_readonly_file_icon  = '✗'
let g:vimfiler_ignore_pattern      = '\(^\.\|\.pyc$\|\.db$\|\.sqlite$\|\.rbc$\)'
noremap <F3> :VimFilerExplorer<CR>

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$_'

" terminal emulation
nnoremap <silent> <leader>sh :VimShellCreate<CR>

" vim-airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme = 'tomorrow'
let g:airline_skip_empty_sections             = 1
let g:airline#extensions#branch#enabled       = 1
let g:airline#extensions#syntastic#enabled    = 1
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tagbar#enabled       = 1
let g:airline#extensions#tabline#left_sep     = ' '
let g:airline#extensions#tabline#left_alt_sep = '┆'
let g:airline_left_alt_sep                    = '»'
let g:airline_left_sep                        = '▶'
let g:airline_right_alt_sep                   = '«'
let g:airline_right_sep                       = '◀'

" snippets
let g:UltiSnipsExpandTrigger                  = "<tab>"
let g:UltiSnipsJumpForwardTrigger             = "<tab>"
let g:UltiSnipsJumpBackwardTrigger            = "<c-b>"
let g:UltiSnipsEditSplit                      = "vertical"

" syntastic
let g:syntastic_always_populate_loc_list      = 1
let g:syntastic_auto_loc_list                 = 1
let g:syntastic_aggregate_errors              = 1
let g:syntastic_error_symbol                  = '✗'
let g:syntastic_warning_symbol                = '⚠'
let g:syntastic_style_error_symbol            = '✗'
let g:syntastic_style_warning_symbol          = '⚠'

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

"*****************************************************************************
"" Functions
"*****************************************************************************

if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wm=2
        set textwidth=79
    endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************

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

""
set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" クリップボードの利用
noremap YY "+y<CR>
noremap XX "+x<CR>
noremap <leader>p "+gp<CR>
noremap <leader>P "+gP<CR>

"" バッファ操作 TODO: 検討
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
noremap <leader>c :Bd<CR>

"" ウィンドウサイズ変更
noremap <C-j> <C-w>-
noremap <C-k> <C-w>+
noremap <C-l> <C-w>>
noremap <C-h> <C-w><

"" ビジュアルモードでブロックごと移動
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

" コマンドラインでの入力をEmacsっぽく
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

" インサートモードでEmacsっぽく
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" 上下のカーソル移動を直感的に
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" .vimrc 編集ショートカット
command! Preferences edit $MYVIMRC

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
    autocmd!
    autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4 smartindent
augroup END

" python
" vim-python
augroup vimrc-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
                \ formatoptions+=croq softtabstop=4 smartindent
                \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" syntastic
let g:syntastic_python_checkers=['python', 'flake8']

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let python_highlight_all = 1

"*****************************************************************************
"" Extra
"*****************************************************************************

if filereadable(expand("~/.vim/colors/custom.vim"))
    source ~/.vim/colors/custom.vim
endif

