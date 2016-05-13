set nocompatible
filetype off


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on
set number
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'powerlineish'
set tabstop=8		"use tab which 8 spaces long
set shiftwidth=8
set noexpandtab
set cindent 		"c-style indent
set hlsearch 		"highlight search
set wrapscan 		"when to the bottom,then back to top
set incsearch 		"use increment search
set showcmd 		"show cmd you entered
set ruler
set cursorline
"set cursorline if seted every window will hight cursor line at the same time
"set cursorcolumn
hi CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi VertSplit cterm=NONE ctermbg=NONE ctermfg=white
hi StatusLineNC cterm=NONE ctermbg=darkblue ctermfg=darkred
hi StatusLine cterm=NONE ctermbg=white ctermfg=black
hi Pmenu cterm=NONE ctermbg=darkyellow ctermfg=black
hi PmenuSel cterm=NONE ctermbg=white ctermfg=black
hi PmenuThumb cterm=NONE ctermbg=darkgreen ctermfg=darkgreen
hi Visual cterm=NONE ctermbg=darkyellow ctermfg=black


"  different filetype different indentation
" autocmd Filetype c,h setlocal noexpandtab tabstop=8 shiftwidth=8
" autocmd Filetype cc,hh setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.c,*.h setlocal noexpandtab tabstop=8 shiftwidth=8
autocmd BufNewFile,BufRead *.cc,*.hh setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

"map some useful keys
"include no highlight search(not perminant turnoff)
	nmap .xs :nohlsearch<CR>
"map keys of window operation
	"map basic window movement keys
		nmap .k <C-W>k
		nmap .j <C-W>j
		nmap .h <C-W>h
		nmap .l <C-W>l
	"map keys of opening and closing a window
	 	nmap .s :split<CR>
		nmap .v :vsplit<CR>
		nmap .n :new<CR>
		nmap [n :vnew<CR>
	"map keys of chosing a window
		nmap .t <C-W>t
		nmap .b <C-W>b
		nmap [p <C-W>p
	"map key of exchanging two windows
		nmap .x <C-W>x
"map key of openning nerdtree
	nmap .2 :NERDTree<CR>
"map key of openning tagbar
	nmap .3 :TagbarToggle<CR>
"map key of openning taglist
	"nmap \3 :TlistToggle<CR>
"map hotkey of omnicppcomplation, use this to generate tags file 
	map <C-F11> :!ctags -R  --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
"map key of changing cursorline
	"map ,c :setlocal cursorline<CR>
	"map ,d :setlocal nocursorline<CR>


"map of Alternate Header file plugin a.vim
nmap ,s :AS<CR>
nmap ,v :AV<CR>
nmap ,a :A<CR>
nmap ,w :IHV<CR>
nmap ,e :IHS<CR>
nmap ,r :IH<CR>


"map of hex edit-function
nmap ,g :%!xxd -r<CR>
nmap ,h :%!xxd<CR>
