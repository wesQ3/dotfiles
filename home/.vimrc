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
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'danro/rename.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tomtom/tcomment_vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
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
      set guifont=Droid\ Sans\ Mono\ 8
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

"fuzzyfind? fuzzybind!
nnoremap <C-Space> :FufFile<CR>
nnoremap <Leader>b :FufBuffer<CR>
nnoremap <Leader>f :FufFileWithCurrentBufferDir<CR>

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

