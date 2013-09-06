set number
set nocompatible
filetype off
filetype plugin on
syntax enable

"vundle your bundles
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

"vundle bundles
Bundle 'kien/ctrlp.vim'
Bundle 'danro/rename.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tomtom/tcomment_vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bling/vim-airline'
Bundle 'vim-perl/vim-perl'
Bundle 'wesQ3/wombat.vim'

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

set autoindent
set wildmenu
set mouse=a
set backspace=2
set ignorecase
set smartcase
set incsearch
set hlsearch
set ruler
set laststatus=2
set showcmd
set encoding=utf-8
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

nnoremap <C-Space> :call DirCtrlP()<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>f :call FileRelCtrlP()<CR>

"swappin mah buffers!
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

noremap <silent> <leader>mw :call MarkWindowSwap()<CR>
noremap <silent> <leader>pw :call DoWindowSwap()<CR>

" center on search
map N Nzz
map n nzz

" try this out
let perl_fold = 1

