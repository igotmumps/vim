" Original Author: Michael Zacharias

" License: AGPL
" Date: 2011 November 5

" === General Settings ===
set nocp
filetype plugin on

" Turn on Syntax Highlighting
syntax on

" Autoindent
set ai

" Incremental search
set incsearch

" Don't highlight results of search
set nohlsearch

" Ruler
set ruler

set cursorline

" Ignore case when searching
set ignorecase

" Start in my workbench
cd $HOME/workbench
"set expandtab
set smarttab

"Use file-specific plugins and indentation
set nosmartindent

" Tabs are 8 spaces
set tabstop=8
set softtabstop=8
set shiftwidth=8

set tags+=~/tags,~/.tags

" Remember where I am in a file when I open it again
set viminfo='100  " for the last 100 files

let g:screen_size_restore_pos = 1

" --------------------------------------------------------------------------
" === Theme Config ===
" -------------------------------------------------------------------------

colo solarized

" GVIM config
if has("gui_running")
	colo zenburn
	" set gvim window size
	set lines=100 columns=120
	if screen_size_restore_pos
		silent! execute "winpos "10 3
	endif
	" No menu or toolbar
	set guioptions -=m
	set guioptions -=T
	set guioptions -=L
	set guioptions -=l
	set guioptions -=R
	set guioptions -=r
	set guioptions -=b

	" Nice copy 'n paste
	set guioptions +=a

	if has("gui_gtk2")
		set guifont=Inconsolata\ 16
	elseif has("gui_win32")
		" Enable Windows behavior
		behave mswin
		set guifont=Lucida_Console:h16:cANSI
	endif
endif

" -------------------------------------------------------------------------
"  === Plugin Settings ===
" -------------------------------------------------------------------------
"
" Airline config
let g:airline_theme='zenburn'

" -------------------------------------------------------------------------
"  GT.M Config and settings
" -------------------------------------------------------------------------
" Turn on syntax highlighting for EWD, mumps
augroup filetypedetect
au! BufRead,BufNewFile *.ewd	setfiletype html
au! BufRead,BufNewFile *.m  setfiletype mumps
au! BufRead,BufNewFile *.ro setfiletype mumps
au! BufRead,BufNewFile *.PROC setfiletype psl
au! BufRead,BufNewFile *.BATCH setfiletype psl
au! BufRead,BufNewFile *.md setfiletype markdown
augroup END

" Open mumps files (only if filetype is mumps)
" au filetype mumps nmap gf :vsp %:p:h/<cfile><CR>
au filetype mumps noremap gf F^bywf^w<C-W>fgg/^<C-R>"<CR>           
au filetype mumps set suffixesadd=.m                               " Routine names end with .m 
au filetype mumps set includeexpr=substitute(v:fname,'\%','_','g') " Translate % to _
" Remove comma as a valid file name b/c in includes D ^XUP,PSS^DEE as one.
au filetype mumps set isfname=@,48-57,/,.,-,_,+,#,$,%,~,=

" Omni complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

source ~/.vim/scripts/m-ctags.vim
" source ~/.vim/scripts/m-gdump.vim
source ~/.vim/scripts/m-datetime.vim
source ~/.vim/scripts/m-tools.vim
" source ~/.vim/scripts/m-setpath.vim

" autocmd BufEnter *.m call MapTags()
" autocmd BufEnter *.m call GlobalDump()
" autocmd BufEnter *.m call ZWRCommand()
" autocmd BufEnter *.m call SetMumpsRoutinesPath()
" autocmd BufLeave *.m call UnmapTags()
" autocmd BufLeave *.m call UnGlobalDump()
" autocmd BufLeave *.m call UnZWRCommand()
" autocmd BufWrite *.m call DateTime()

"----------------------------------------------------------------
" === Functions and Key Bindings ===
"----------------------------------------------------------------
"Use comma as leader
let mapleader = ','

" Remap new tab
nmap <Leader>t <ESC>:tabnew<CR>
nmap <Leader>tn <ESC>:tabnext<CR>
nmap <Leader>tp <ESC>:tabprev<CR>
nmap <Leader>tf <ESC>:tabfirst<CR>
nmap <Leader>tl <ESC>:tablast<CR>
nmap <Leader>tc <ESC>:tabclose<CR>

"Toggle Syntax
function! ToggleSyntax()
	if exists("g:syntax_on")
		syntax off
	else
		syntax enable
	endif
endfunction

" Easier split navigation
" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR> 
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>


nmap <silent> <Leader>s :call ToggleSyntax()<CR>
nmap <silent> <Leader>ev <ESC>:e $MYVIMRC<CR>
nmap <silent> <Leader>nt <ESC>:NERDTreeToggle ./<CR>
nnoremap <silen> <Leader>+ :exe "vertical resize 80"
nnoremap <silent> <Leader>d2u <ESC>:%s/{Ctrl+V}{Ctrl+M}//<CR>

