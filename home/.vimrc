set nocompatible
filetype off
filetype plugin on
syntax enable

"vundle your bundles
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

"vundle bundles
Bundle 'tpope/vim-sensible'
Bundle 'kien/ctrlp.vim'
Bundle 'danro/rename.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'tomtom/tcomment_vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/syntastic'
Bundle 'vim-perl/vim-perl'
Bundle 'wesQ3/wombat.vim'
Bundle 'wesQ3/vim-windowswap'
Bundle 'wesQ3/vim-matchit'

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

nnoremap <C-Space> :call DirCtrlP()<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>f :call FileRelCtrlP()<CR>
nnoremap <Leader>c :CtrlPClearCache<CR>

" center on search
map N Nzz
map n nzz

" perl
let perl_fold = 1
let perl_nofold_packages = 1

"syntastic
let g:syntastic_perl_interpreter = '~/perl5/perlbrew/current/bin/perl'

"fix vim thinking the : is part of the object key in js
set iskeyword=@,48-57,_,192-255

