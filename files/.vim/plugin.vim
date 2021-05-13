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
Plug 'bling/vim-bufferline'                  " buffer list 表示
Plug 'dhruvasagar/vim-table-mode'            " テーブル作成
Plug 'itchyny/lightline.vim'                 " airlineっぽいやつ
Plug 'jszakmeister/vim-togglecursor'         " カーソルを設定する
Plug 'kannokanno/previm'                     " Markdownをブラウザでプレビューする
Plug 'kshenoy/vim-signature'                 " markを可視化
Plug 'lambdalisue/fern.vim'                  " ファイラ(旧fila.vim)
Plug 'lambdalisue/fern-git-status.vim'
Plug 'moll/vim-bbye'                         " Bdelete(window構造を変更せずにbdelete) を追加
Plug 'ntpeters/vim-better-whitespace'        " 行末スペースのハイライト
Plug 'osyo-manga/vim-anzu'                   " 検索位置を確認する
Plug 'tpope/vim-commentary'                  " 便利にコメントアウト gc
Plug 'tyru/open-browser.vim'                 " ブラウザを開く(previmで使用)
Plug 'vim-scripts/CSApprox'                  " GVim用カラースキーマをCUI用に変換

" 検討
Plug 'airblade/vim-rooter'                   " 自動でルートディレクトリへ
Plug 'majutsushi/tagbar'                     " ctagsの扱い
Plug 'scrooloose/syntastic'                  " 構文チェック
Plug 'sheerun/vim-polyglot'                  " 言語サポート(字下げやシンタックス)
Plug 'vim-scripts/grep.vim'                  " -

" SQL
Plug 'mattn/vim-sqlfmt'                      " SQL整形(go get github.com/jackc/sqlfmt/...)

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" LSP, complete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" LSP, settings
Plug 'mattn/vim-lsp-settings'
" LSP, icons
Plug 'mattn/vim-lsp-icons'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

"" Session
Plug 'xolox/vim-misc'                        " セッション管理
Plug 'xolox/vim-session'                     " セッション管理

" Color
Plug 'chriskempson/vim-tomorrow-theme'       " colorscheme
" Plug 'yasukotelin/shirotelin'

"" HTML Bundle
" Plug 'gorodinskiy/vim-coloresque'            " カラーコードプレビュー 重い！
" Plug 'hail2u/vim-css3-syntax'                " -
Plug 'mattn/emmet-vim'                       " -
Plug 'tpope/vim-haml'                        " -

"" Javascript Bundle
" Plug 'jelera/vim-javascript-syntax'          " -

" Go
" Plug 'fatih/vim-go'                          " -

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

" vim-togglecursor
let g:togglecursor_insert = 'line'

" }}}

" ===== LSP =====

" https://mattn.kaoriya.net/software/vim/20191231213507.htm

" LSP, config (検討)
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_signs_hint = {'text': '？'}
let g:lsp_diagnostics_echo_cursor = 1
" LSP, config (検討)
let g:lsp_diagnostics_enabled = 1
let g:asyncomplete_auto_popup = 1
" let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
" 実験的設定
let g:lsp_text_edit_enabled = 1

"" LSP,
if empty(globpath(&rtp, 'autoload/lsp.vim'))
    finish
endif

"" LSP,
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <f2> <plug>(lsp-rename)
    inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

" LSP, Language Server インストール促し
augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" LSP, デバッグ用設定
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

" https://kashewnuts.github.io/2019/01/28/move_from_jedivim_to_vimlsp.html

" 検討
function! s:configure_lsp() abort
    " オムニ補完を有効化
    setlocal omnifunc=lsp#complete
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
autocmd FileType * call s:configure_lsp()
