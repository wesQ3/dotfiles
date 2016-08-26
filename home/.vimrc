set nocompatible
filetype off
filetype plugin on
syntax enable

"vundle your bundles
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"vundle bundles
Plugin 'tpope/vim-sensible'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'imkmf/ctrlp-branches'
Plugin 'danro/rename.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-obsession'
Plugin 'tomtom/tcomment_vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'vim-perl/vim-perl'
Plugin 'elzr/vim-json'
Plugin 'unblevable/quick-scope'
Plugin 'mhinz/vim-startify'
Plugin 'wesQ3/wombat.vim'
Plugin 'wesQ3/vim-windowswap'
Plugin 'wesQ3/vim-matchit'
call vundle#end()

colorscheme desert
if has("gui_running")
   " Remove Toolbar
   set guioptions=i
   set cursorline
   set nomousehide
   colorscheme wombat
   if filereadable(expand('~/.vim/local/font.vim'))
      source ~/.vim/local/font.vim
   else
      if has('win32')
         set guifont=Consolas:h8
      else
         set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 8
         let g:airline_powerline_fonts = 1
      endif
   endif
   set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
   set showbreak=↪\ |"that trailing space is intentional
endif

set number
set mouse=a
set ignorecase
set wildignorecase
set smartcase
inoremap jj <Esc>
let mapleader = " "

" set ; to : in command mode
noremap : ;
noremap! : ;
noremap ; :
noremap! ; :

iunmap :
iunmap ;

" no tabs
set expandtab
set smarttab
set shiftwidth=3
set softtabstop=3

" keeps swap files local!
if has('win32')
   set directory=~/vimfiles/swap/
else
   set directory=~/.vim/swap/
endif

" persistent undo!
set undofile
if has('win32')
   set undodir=~/vimfiles/undo
else
   set undodir=~/.vim/undo
endif

"file rifling
function! DirCtrlP()
   let g:ctrlp_working_path_mode = 0
   CtrlP
endfunction

function! FileRelCtrlP()
   let g:ctrlp_working_path_mode = 'c'
   CtrlP
endfunction

" set matcher location and size
let g:ctrlp_match_window = 'top,order:ttb,min:5,max:30'

let g:ctrlp_extensions = [
   \ 'branches',
   \ ]

nnoremap <Leader>f :call DirCtrlP()<CR>
nnoremap <Leader>F :call FileRelCtrlP()<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>B :CtrlPBranches<CR>
nnoremap <Leader>c :CtrlPClearCache<CR>

" center on search
map N Nzz
map n nzz

" perl
let perl_fold = 1
let perl_nofold_packages = 1
let perl_sub_signatures = 1

"fix vim thinking the : is part of the object key in js
set iskeyword=@,48-57,_,192-255

"move around easier
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k


" only show quick-scope hints when moving
let g:qs_highlight_on_keys = [ 'f', 'F', 't', 'T' ]

" filetypes
au BufNewFile,BufRead *.tt.html set filetype=tt2html
au BufNewFile,BufRead *.html.tt set filetype=tt2html
au FileType gitrebase setlocal nomodeline

" start screen
let g:startify_list_order = [
   \ ['   Sessions'],
   \ 'sessions',
   \ ['   Most recently used files'],
   \ 'files',
   \ ['   Most recently used files in the current directory'],
   \ 'dir',
   \ ['   Bookmarks'],
   \ 'bookmarks',
   \ ]
