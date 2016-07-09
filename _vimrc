" Original Author: Michael Zacharias

" License: AGPL
" Date: 2011 November 5

" --------------------------------------------------------------------------
" === General Settings === {{{
set nocp
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

filetype plugin indent on
set vb 
set t_vb =

"set fold method
set foldmethod=marker

"Use comma as leader
let mapleader = ','

" Turn on Syntax Highlighting
syntax on

" Turn on Color Column
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\>%80v.\+/
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn','\%81v',100)

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
cd $HOME/wb
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
" }}}

" --------------------------------------------------------------------------
" === Theme Config ==="{{{"{{{
" ------------------------------------------------------------------------- "}}}

colo desert

" GVIM config
if has("gui_running")
	colo desert
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
"}}}

" -------------------------------------------------------------------------
"  === Plugin Settings ==="{{{
" -------------------------------------------------------------------------
"
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
" Plugin 'bling/vim-bufferline'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/neocomplcache.vim'
"Plugin 'SirVer/ultisnips'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
" Color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'chriskempson/base16-vim'
Plugin 'fatih/vim-go'
call vundle#end()
"
" Airline config
let g:airline_theme='zenburn'
let g:airline_section_y = 'BN: %{bufnr("%")}'

" NerdTree config
let g:NERDTreeDirArrows=0


"}}}
" -------------------------------------------------------------------------
"  GT.M Config and settings"{{{
" -------------------------------------------------------------------------
" Turn on syntax highlighting for EWD, mumps
augroup filetypedetect
au! BufRead,BufNewFile *.ewd	setfiletype html
au! BufRead,BufNewFile *.m  setfiletype mumps
au! BufRead,BufNewFile *.ro setfiletype mumps
au! BufRead,BufNewFile *.PROC setfiletype mumps
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
au filetype mumps source ~/.vim/scripts/gtm-tools.vim
au filetype mumps nmap GD GDump
au filetype mumps nmap GF GFind
"}}}
" Omni complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

augroup VimReload
autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup end

source ~/vimfiles/scripts/m-ctags.vim
" source ~/.vim/scripts/m-gdump.vim
" source ~/.vim/scripts/m-datetime.vim
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
" === Functions and Key Bindings ==="{{{
"----------------------------------------------------------------

" Remap new tab
nmap t <ESC>:tabnext<CR>
nmap tn <ESC>:tabnew<CR>
nmap tp <ESC>:tabprev<CR>
nmap tf <ESC>:tabfirst<CR>
nmap tl <ESC>:tablast<CR>
nmap tc <ESC>:tabclose<CR>
nnoremap <Leader>c <ESC>:<Leader>cc<CR>

" Remap buffer commands
nnoremap <silent> <Leader>b <ESC>:bn<CR>
nnoremap <silent> <Leader>bp <ESC>:bp<CR>
nnoremap <silent> <Leader>bf <ESC>:bf<CR>

nnoremap <silent> <Leader>c <ESC>mqI;<ESC> `q

silent function! WINDOWS()
	return (has('win16') || has('win32') || has('win64'))
endfunction

silent function! LINUX()
	return has('unix') && !has('macunix') && !has('win32unix')
endfunction

"Toggle Syntax
function! ToggleSyntax()
	if exists("g:syntax_on")
		syntax off
	else
		syntax enable
	endif
endfunction
nnoremap <silent> <Leader>s :call ToggleSyntax()<CR>

" Easier split navigation
" Use ctrl-[hjkl] to select the active split
nnoremap <silent> <c-k> :wincmd k<CR> 
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

" Edit $MYVIMRC
nnoremap <silent> <Leader>ev <ESC>:vsplit $MYVIMRC<CR>

" Toggle NerdTree
nnoremap <silent> <F1> <ESC>:NERDTreeToggle ./<CR>

" resize the edit window
nnoremap <silent> <Leader>+ :exe "vertical resize 80"

"Convert from dos line endings to Unix
nnoremap <silent> <Leader>d2u <ESC>:%s/{Ctrl+V}{Ctrl+M}//<CR>

" Back up current file
nmap BB [Back up current file] :!bak -q %<CR><CR>:echomsg "Backed up" expand('%')<CR>

"NerdCommenter custom delimiter for mumps
let g:NERDCustomDelimiters = {'mumps': { 'left': ';'}}

vnoremap <Leader>c <Plug>NERDCommenterComment
set fileformats=unix,dos
"}}}
