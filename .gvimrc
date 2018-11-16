" =============================================================================
" Color scheme
" =============================================================================

colorscheme Tomorrow-Night
" colorscheme Tomorrow
" set background=light

if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=0
elseif has("win32") || has ("win64")
    set guifont=MSゴシック:h12
else
    " TODO: Ubuntuという条件判断
    set guifont=Ubuntu\ Mono\ Regular\ 11
endif
set guifont=Ricty\ Diminished:h14


" =============================================================================
" Visual
" =============================================================================

" GUI
set guioptions=egmrTi

" Cursor
set guicursor=a:blinkon0


" =============================================================================
" Mappings
" =============================================================================

" .gvimrc short cut
command! Preferences edit $MYGVIMRC
