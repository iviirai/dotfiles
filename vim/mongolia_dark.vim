set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name = "Mongolia Night"

" PreProc
highlight Include 	ctermfg=6 	ctermbg=NONE
highlight Define 	ctermfg=12	ctermbg=NONE
highlight Macro		ctermfg=12	ctermbg=NONE
highlight PreCondit	ctermfg=11	ctermbg=NONE
" Constant
highlight Constant	ctermfg=5	ctermbg=NONE
highlight Number	ctermfg=14	ctermbg=NONE
highlight Float		ctermfg=14	ctermbg=NONE
highlight Boolean	ctermfg=14	ctermbg=NONE
" Identifier
highlight Identifier	ctermfg=3	ctermbg=NONE
highlight Function	ctermfg=18	ctermbg=NONE
" Statement
highlight Conditional	ctermfg=11	ctermbg=NONE
highlight Repeat	ctermfg=2	ctermbg=NONE
highlight Label		ctermfg=13	ctermbg=NONE
highlight Operator	ctermfg=10	ctermbg=NONE
highlight Keyword	ctermfg=9	ctermbg=NONE
highlight Exception	ctermfg=9	ctermbg=NONE
" Type
highlight Type		ctermfg=4	ctermbg=NONE
highlight StorageClass	ctermfg=9	ctermbg=NONE
highlight Structure	ctermfg=16	ctermbg=NONE
highlight Typedef	ctermfg=1	ctermbg=NONE
" Commment
highlight Comment	ctermfg=7	ctermbg=NONE
" Special
highlight Special	ctermfg=17	ctermbg=NONE

