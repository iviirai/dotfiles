set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name = "Mongolia Night"

" Normal
highlight Normal 	ctermfg=23	ctermbg=NONE

" PreProc
highlight PreProc	ctermfg=6	ctermbg=NONE
highlight Include 	ctermfg=6 	ctermbg=NONE
highlight Define 	ctermfg=12	ctermbg=NONE
highlight Macro		ctermfg=12	ctermbg=NONE
highlight PreCondit	ctermfg=11	ctermbg=NONE
" Constant
highlight Constant	ctermfg=9	ctermbg=NONE
highlight String	ctermfg=5	ctermbg=NONE
highlight Character	ctermfg=5	ctermbg=NONE
highlight Number	ctermfg=24	ctermbg=NONE
highlight Float		ctermfg=24	ctermbg=NONE
highlight Boolean	ctermfg=24	ctermbg=NONE
" Identifier
highlight Identifier	ctermfg=3	ctermbg=NONE	cterm=NONE
highlight Function	ctermfg=22	ctermbg=NONE
" Statement
highlight Statement	ctermfg=18	ctermbg=NONE
highlight Conditional	ctermfg=11	ctermbg=NONE
highlight Repeat	ctermfg=19	ctermbg=NONE
highlight Label		ctermfg=13	ctermbg=NONE
highlight Operator	ctermfg=20	ctermbg=NONE
highlight Keyword	ctermfg=9	ctermbg=NONE
highlight Exception	ctermfg=9	ctermbg=NONE
" Type
highlight Type		ctermfg=4	ctermbg=NONE
highlight StorageClass	ctermfg=9	ctermbg=NONE
highlight Structure	ctermfg=3	ctermbg=NONE
highlight Typedef	ctermfg=3	ctermbg=NONE
" Commment
highlight Comment	ctermfg=7	ctermbg=NONE
" Special
highlight Special	ctermfg=17	ctermbg=NONE
highlight Delimiter	ctermfg=17	ctermbg=NONE
" Current line number
highlight LineNr	ctermfg=4	ctermbg=NONE
highlight CursorLineNr	ctermfg=11	ctermbg=NONE
" Matching bracket
highlight MatchParen 	ctermfg=8	ctermbg=13	cterm=bold
" highlight typedef _t as type.
" http://blog.cdleary.com/2007/08/matching-_t-types-in-your-vimrc/
" syntax match cType	/\w\+_t\ze\W/
" put it in syntax plugin


" Diff
highlight DiffAdd	ctermfg=8	ctermbg=4	cterm=bold
highlight DiffChange	ctermfg=8	ctermbg=13	cterm=bold
highlight DiffDelete	ctermfg=8	ctermbg=6	cterm=bold
highlight DiffText	ctermfg=8	ctermbg=9	cterm=bold

" Fold
highlight Folded	ctermfg=8	ctermbg=7	cterm=bold
highlight FoldColumn 	ctermfg=8	ctermbg=7	cterm=bold

" Error
highlight ErrorMsg 	ctermfg=15	ctermbg=9	cterm=bold
highlight WarningMsg	ctermfg=0	ctermbg=3	cterm=bold
highlight Error		ctermfg=15	ctermbg=9	cterm=NONE
 
" MoreMsg
highlight MoreMsg	ctermfg=4	ctermbg=15	cterm=bold

" Search
highlight IncSearch	ctermfg=NONE	ctermbg=NONE	cterm=reverse
highlight Search	ctermfg=15	ctermbg=4	cterm=NONE

" Status
highlight StatusLine	ctermfg=8	ctermbg=12	cterm=NONE
highlight StatusLineNC	ctermfg=3	ctermbg=8	cterm=NONE

" Split
highlight VertSplit	ctermfg=15	ctermbg=NONE	cterm=NONE

" Popup Menu
highlight Pmenu		ctermfg=8	ctermbg=12	cterm=NONE
highlight PmenuSel	ctermfg=12	ctermbg=8	cterm=bold
highlight PmenuSbar	ctermfg=4	ctermbg=4	cterm=NONE
highlight PmenuThumb	ctermfg=15	ctermbg=15	cterm=NONE

" Cursor IMPORTANT!! Urxvt or some other terms use it's own color anyway.
highlight CursorLine	ctermfg=NONE	ctermbg=0	cterm=NONE
" highlight Cursor	ctermfg=8	ctermbg=17	cterm=bold

" Visual
highlight Visual	ctermfg=0	ctermbg=4	cterm=bold

" NonText
highlight NonText	ctermfg=4	ctermbg=NONE

" Underline
highlight Underlined	ctermfg=24	ctermbg=NONE	cterm=underline

" For YouCompleteMe Plugin
highlight YcmErrorLine	ctermfg=15	ctermbg=9	cterm=NONE
highlight YcmWarningLine ctermfg=0	ctermbg=3	cterm=bold
highlight YcmErrorSection ctermfg=15	ctermbg=9	cterm=NONE
highlight YcmWarningSection ctermfg=0	ctermbg=3	cterm=bold
