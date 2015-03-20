set nocompatible
filetype off
filetype plugin on
syntax enable

"vundle your bundles
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

"vundle bundles
Plugin 'tpope/vim-sensible'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'danro/rename.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tomtom/tcomment_vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'vim-perl/vim-perl'
Plugin 'wesQ3/wombat.vim'
Plugin 'wesQ3/vim-windowswap'
Plugin 'wesQ3/vim-matchit'
call vundle#end()

if has("gui_running")
   " Remove Toolbar
   set guioptions=i
   set cursorline
   set nomousehide
   colorscheme wombat
   if has('win32')
      set guifont=Consolas:h8
   else
      set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 8
      let g:airline_powerline_fonts = 1
   endif
endif

set number
set mouse=a
set ignorecase
set wildignorecase
set smartcase
inoremap jj <Esc>
let mapleader = ","

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

nnoremap <Leader>f :call DirCtrlP()<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>F :call FileRelCtrlP()<CR>
nnoremap <Leader>c :CtrlPClearCache<CR>

" center on search
map N Nzz
map n nzz

" perl
let perl_fold = 1
let perl_nofold_packages = 1
let perl_no_subprototype_error = 1

"fix vim thinking the : is part of the object key in js
set iskeyword=@,48-57,_,192-255

"move around easier
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
