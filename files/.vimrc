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
autocmd FileType vim setlocal foldmethod=marker

" }}}

" =============================================================================
" Vim-PLug core
" =============================================================================

" {{{

if has('vim_starting')
    set nocompatible  " Be iMproved
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

" }}}

"=============================================================================
"" Plug install packages
"=============================================================================

" {{{

" Basic
Plug 'Yggdroot/indentLine'                   " インデントを視覚化
Plug 'airblade/vim-gitgutter'                " 変更箇所表示(git)
Plug 'airblade/vim-rooter'                   " 自動でルートディレクトリへ
Plug 'bling/vim-bufferline'                  " buffer list 表示
Plug 'dhruvasagar/vim-table-mode'            " テーブル作成
Plug 'itchyny/lightline.vim'                 " airlineっぽいやつ
Plug 'kannokanno/previm'                     " Markdownをブラウザでプレビューする
Plug 'kshenoy/vim-signature'                 " markを可視化
Plug 'majutsushi/tagbar'                     " ctagsの扱い
Plug 'moll/vim-bbye'                         " Bdelete(window構造を変更せずにbdelete) を追加
Plug 'ntpeters/vim-better-whitespace'        " 行末スペースのハイライト
Plug 'osyo-manga/vim-anzu'                   " 検索位置を確認する
Plug 'scrooloose/syntastic'                  " 構文チェック
Plug 'sheerun/vim-polyglot'                  " 言語サポート(字下げやシンタックス)
Plug 'tpope/vim-commentary'                  " 便利にコメントアウト gc
Plug 'tyru/open-browser.vim'                 " ブラウザを開く(previmで使用)
Plug 'vim-scripts/CSApprox'                  " GVim用カラースキーマをCUI用に変換
Plug 'vim-scripts/grep.vim'                  " -

"
Plug 'lambdalisue/fern.vim'                  " ファイラ(旧fila.vim)
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

" SQL
Plug 'mattn/vim-sqlfmt'                      " SQL整形(go get github.com/jackc/sqlfmt/...)

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" complete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" settings
" Plug 'mattn/vim-lsp-settings'

"" Session
Plug 'xolox/vim-misc'                        " セッション管理
Plug 'xolox/vim-session'                     " セッション管理

" Color
Plug 'chriskempson/vim-tomorrow-theme'       " colorscheme
Plug 'yasukotelin/shirotelin'

"" HTML Bundle
Plug 'gorodinskiy/vim-coloresque'            " -
Plug 'hail2u/vim-css3-syntax'                " -
Plug 'mattn/emmet-vim'                       " -
Plug 'tpope/vim-haml'                        " -

"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'          " -

" Go
Plug 'fatih/vim-go'                          " -

"" C
Plug 'justmao945/vim-clang'

" CSV
Plug 'mechatroner/rainbow_csv'

"" plist
Plug 'darfink/vim-plist'

call plug#end()

" }}}

" Required:
filetype plugin indent on

"=============================================================================
"" Plugin settings
"=============================================================================

" {{{

" Color Schema
if !exists('g:not_finish_vimplug')
    colorscheme Tomorrow-Night
endif

" vim-plist
let g:plist_display_format = 'json'  " or 'xml'

" vim-anzu
nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
augroup vim-anzu
    autocmd!
    autocmd CursorMoved,CursorMovedI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

" vim-bbye
cnoreabbrev bd Bd
cnoreabbrev bd! Bd!

" Fern.vim (旧Fila.vim)
" noremap <F3> :Fila -drawer -toggle -keep<CR>
noremap <F3> :Fern . -drawer -toggle -keep<CR>
let g:fern#disable_viewer_hide_cursor = 1
" let g:fern#disable_drawer_auto_resize = 1
let g:fern#drawer_width = 40
" let g:fern#renderer = "nerdfont"

"" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" bufferline
let g:bufferline_modified = '*'

" lightline
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'currentdir' ], [ 'readonly', 'relativepath', 'modified' ] ],
            \   'right': [ [ 'anzu', 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'colorscheme': 'wombat'
            \ }
let g:lightline.tabline = {
            \ 'left': [ [ 'bufferline' ] ],
            \ 'right': [ [ 'tabs' ] ] }
let g:lightline.component = {
            \ 'currentdir': '%(%{fnamemodify(getcwd(), ":~")}%)',
            \ 'lineinfo': '[%3l/%L : %-2v]'}
let g:lightline.component_function = {
            \ 'bufferline': 'MyBufferline',
            \ 'anzu': 'anzu#search_status'
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
" let g:rooter_use_lcd = 1
let g:rooter_cd_cmd="lcd"

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
    let g:indentLine_faster = 1
endif

" previm
let g:previm_open_cmd = ''  " open-browse.vimで開く
let g:previm_enable_realtime = 1
let g:previm_show_header = 0
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '~/Projects/github.com/itkr/dotfiles/files/markdown.css'

" vim-polyglot(vim-markdown)でmarkdownのリンクを畳み込まない
let g:vim_markdown_conceal = 0
" vim-polyglot(vim-markdown)でmarkdownのコードブロックを畳み込まない
let g:vim_markdown_conceal_code_blocks = 0

" vim-table-mode
let g:table_mode_corner='|'
function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
            \ <SID>isAtStartOfLine('\|\|') ?
            \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
            \ <SID>isAtStartOfLine('__') ?
            \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" SQLFmt
" デフォルトは'sqlformat -r -k upper -o %s -'これはpythonのsqlparseが必要
" goのsqlfmtを使う
let g:sqlfmt_program = 'sqlfmt'

" }}}

" ===== LSP =====
"
" vim-lsp
" https://kashewnuts.github.io/2019/01/28/move_from_jedivim_to_vimlsp.html
" TODO: 見直し・更新する

" デバッグ用設定
let g:lsp_log_verbose = 1  " デバッグ用ログを出力
" let g:lsp_log_file = expand('~/.cache/tmp/vim-lsp.log')  " ログ出力のPATHを設定

" 言語用Serverの設定
augroup MyLsp
  autocmd!
  " pip install python-language-server
  if executable('pyls')
    " Python用の設定を記載
    " workspace_configで以下の設定を記載
    " - pycodestyleの設定はALEと重複するので無効にする
    " - jediの定義ジャンプで一部無効になっている設定を有効化
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': { server_info -> ['pyls'] },
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {
        \   'pycodestyle': {'enabled': v:false},
        \   'jedi_definition': {'follow_imports': v:true, 'follow_builtin_imports': v:true},}}}
        \})
    autocmd FileType python call s:configure_lsp()
  endif
augroup END

" go用(仮)
if executable('gopls')
  augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-lang',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ 'workspace_config': {'gopls': {
        \     'staticcheck': v:true,
        \     'completeUnimported': v:true,
        \     'caseSensitiveCompletion': v:true,
        \     'usePlaceholders': v:true,
        \     'completionDocumentation': v:true,
        \     'watchFileChanges': v:true,
        \     'hoverKind': 'SingleLine',
        \   }},
        \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
    autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
    autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
  augroup END
endif

" 言語ごとにServerが実行されたらする設定を関数化
function! s:configure_lsp() abort
  setlocal omnifunc=lsp#complete   " オムニ補完を有効化
  " LSP用にマッピング
  nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
  nnoremap <buffer> gd :<C-u>LspDefinition<CR>
  nnoremap <buffer> gD :<C-u>LspReferences<CR>
  nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
  nnoremap <buffer> gS :<C-u>LspWorkspaceSymbol<CR>
  nnoremap <buffer> gQ :<C-u>LspDocumentFormat<CR>
  vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
  nnoremap <buffer> K :<C-u>LspHover<CR>
  nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
  nnoremap <buffer> <F2> :<C-u>LspRename<CR>
endfunction

" vim-lsp
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_signs_hint = {'text': '？'}
let g:lsp_diagnostics_echo_cursor = 1
