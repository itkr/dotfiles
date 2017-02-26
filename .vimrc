" =============================================================================
" Vim-PLug core
" =============================================================================

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

"=============================================================================
"" Plug install packages
"=============================================================================

let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif

"" Snippets
Plug 'SirVer/ultisnips'                      " Snippets(v:version >=704)             TODO: 検討
Plug 'honza/vim-snippets'                    " Snippets                              TODO: 検討

" Basic
Plug 'Shougo/unite.vim'                      " 統合インターフェイス
Plug 'Shougo/vimfiler.vim'                   " ファイラ(Uniteに依存)
Plug 'Shougo/vimproc.vim', {'do': g:make}    " 非同期実行
Plug 'Shougo/vimshell.vim'                   " Vimでシェル(vimprocに依存)
Plug 'Yggdroot/indentLine'                   " インデントを視覚化
Plug 'airblade/vim-gitgutter'                " 変更箇所表示(git)
Plug 'airblade/vim-rooter'                   " 自動でルートディレクトリへ
Plug 'bling/vim-bufferline'                  " buffer list 表示
Plug 'itchyny/lightline.vim'                 " airlineっぽいやつ
Plug 'majutsushi/tagbar'                     " ctagsの扱い
Plug 'moll/vim-bbye'                         " Bdelete(window構造を変更せずにbdelete) を追加
Plug 'ntpeters/vim-better-whitespace'        " 行末スペースのハイライト
Plug 'scrooloose/syntastic'                  " 構文チェック
Plug 'sheerun/vim-polyglot'                  " 言語サポート(字下げやシンタックス)    TODO: 検討
Plug 'tpope/vim-commentary'                  " 便利にコメントアウト gc
Plug 'vim-scripts/CSApprox'                  " GVim用カラースキーマをCUI用に変換
Plug 'vim-scripts/grep.vim'                  " -

"" Session
Plug 'xolox/vim-misc'                        " セッション管理
Plug 'xolox/vim-session'                     " セッション管理

" Color
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
" Plug 'hdima/python-syntax'                   " pythonのシンタックスグループを追加
" Plug 'kevinw/pyflakes-vim'                   " flask シンタックスチェック
" Plug 'lambdalisue/vim-pyenv'                 " Vimでpyenvを扱う

call plug#end()

" Required:
filetype plugin indent on

"=============================================================================
"" Autocmd Rules
"=============================================================================

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

" =============================================================================
" Basic
" =============================================================================

" %で対になるタグなどに飛ぶ
runtime macros/matchit.vim

" leaderをマッピング
let mapleader=','
" noremap \ ,

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
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Automatically generated file
set nobackup
set noswapfile

" File formats
set fileformats=unix,dos,mac

" Commands
set showcmd

" Shell
set shell=/bin/sh

" Decimal number
set nrformats=

" Commandline completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" Buffers
set autoread
set hidden

" Clipboard
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

" =============================================================================
" Color scheme
" =============================================================================

" Override color scheme
augroup change-color-scheme
    autocmd!
    autocmd ColorScheme * highlight Visual ctermbg=12 ctermfg=15
    autocmd ColorScheme * highlight Cursor guifg=NONE guibg=#ff39d9
augroup END

set t_Co=256

if !exists('g:not_finish_vimplug')
    colorscheme hybrid
endif

if has("gui_running")
    if has("gui_mac") || has("gui_macvim")
        colorscheme solarized
        set background=light
        set guifont=Menlo:h12
        set transparency=0
    endif
else
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

" =============================================================================
" Visual
" =============================================================================

" Syntax
syntax on

" Line number
set number

" GUI
set guioptions=gmrTi

" Mouse
set mousemodel=popup

" Status line
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Tabline
set showtabline=2

" Cursor
set cursorline
set scrolloff=1

" Cursor
if has('gui_running')
    set guicursor=a:blinkon0
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Disable visualbell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"=============================================================================
"" Plugin
"=============================================================================

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

"" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

"" terminal emulation
nnoremap <silent> <leader>sh :VimShellCreate<CR>

" bufferline
let g:bufferline_echo = 0
let g:bufferline_active_buffer_left = '❰'
let g:bufferline_active_buffer_right = '❱'
let g:bufferline_modified = '*'

" lightline
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'currentdir' ], [ 'readonly', 'relativepath', 'modified' ] ]
            \ },
            \ 'colorscheme': 'solarized'
            \ }
let g:lightline.tabline = {
            \ 'left': [ [ 'bufferline' ] ],
            \ 'right': [ [ 'tabs' ] ] }
let g:lightline.component = {
            \ 'currentdir': '%(%{fnamemodify(getcwd(), ":~")}%)',
            \ 'lineinfo': '[%3l/%L : %-2v]'}
let g:lightline.component_function = {
            \   'bufferline': 'MyBufferline'
            \ }
let g:lightline.component_expand = {
            \ 'tabs': 'lightline#tabs'}
let g:lightline.component_type = {
            \ 'tabs': 'tabsel' }

function! MyBufferline()
    call bufferline#refresh_status()
    let b = g:bufferline_status_info.before
    let c = g:bufferline_status_info.current
    let a = g:bufferline_status_info.after
    return b . c . a
endfunction

"" snippets
let g:UltiSnipsExpandTrigger                  = "<tab>"
let g:UltiSnipsJumpForwardTrigger             = "<tab>"
let g:UltiSnipsJumpBackwardTrigger            = "<c-b>"
let g:UltiSnipsEditSplit                      = "vertical"

"" syntastic
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

" vim-rooter
let g:rooter_use_lcd = 1

" vim-session
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

""
if !has("gui_running")
    " CSApprox
    let g:CSApprox_loaded = 1
    " IndentLine
    let g:indentLine_enabled = 1
    let g:indentLine_concealcursor = 0
    let g:indentLine_char = '┆'
    let g:indentLine_faster = 1
endif

"=============================================================================
"" Functions
"=============================================================================

if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wrapmargin=2
        set textwidth=79
    endfunction
endif

"=============================================================================
"" Mappings
"=============================================================================

" TODO: 検討
cnoremap <expr> %% getcmdtype() ==':' ? expand('%:h:p').'/' : '%%'

"" コマンドラインでカレントディレクトリ表示
cnoremap <C-X><C-P> <C-R>=expand("%:p:h") . "/" <CR>
"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>
"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

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

" Moving cursor
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Comment out
nmap <leader>/ gcc
vmap <leader>/ gc

" Start visual mode
nnoremap <S-Down> vj
nnoremap <S-Up> vk
vnoremap <S-Down> j
vnoremap <S-Up> k

" .vimrc short cut
command! Preferences edit $MYVIMRC

"=============================================================================
"" File type
"=============================================================================

"" html
"" for html files, 2 spaces
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

"" javascript
let g:javascript_enable_domhtmlcss = 1

"" vim-javascript
augroup vimrc-javascript
    autocmd!
    autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4 smartindent
augroup END

"" python
"" vim-python
augroup vimrc-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
                \ formatoptions+=croq softtabstop=4 smartindent
                \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

"" jedi-vim
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

"" Default highlight is better than polyglot
let g:polyglot_disabled = ['python']

" python syntax highlight
let python_highlight_all = 1

"=============================================================================
"" Extra
"=============================================================================

if filereadable(expand("~/.vim/colors/custom.vim"))
    source ~/.vim/colors/custom.vim
endif
