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
Plugin 'Shougo/neocomplete.vim'
Plugin 'danro/rename.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-vinegar'
Plugin 'tomtom/tcomment_vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-perl/vim-perl'
Plugin 'elzr/vim-json'
Plugin 'Matt-Deacalion/vim-systemd-syntax'
Plugin 'hashivim/vim-terraform'
Plugin 'juliosueiras/vim-terraform-completion'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'udalov/kotlin-vim'
Plugin 'Konfekt/FastFold'
Plugin 'unblevable/quick-scope'
Plugin 'mhinz/vim-startify'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'lucapette/vim-textobj-underscore'
Plugin 'frioux/vim-regedit'
Plugin 'frioux/vim-lost'
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
         set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 9
         let g:airline_powerline_fonts = 1
      endif
   endif
   set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↲
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

" ignore binaries
let g:ctrlp_custom_ignore = {
   \ 'file': '\v\.(exe|so|dll|gif|jpg|png|ico|bin|wav|msi)$',
   \ }

" set matcher location and size
let g:ctrlp_match_window = 'top,order:ttb,min:5,max:30'

let g:ctrlp_extensions = [
   \ 'branches',
   \ ]

nnoremap <Leader>f :call DirCtrlP()<CR>
nnoremap <Leader>F :call FileRelCtrlP()<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>B :CtrlPBranches<CR>
nnoremap <Leader>p :CtrlP $HOME/.plenv/versions/5.26.1/lib/perl5/<CR>
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

" open splits more intuitively (for me)
set splitright
set splitbelow

" only show quick-scope hints when moving
let g:qs_highlight_on_keys = [ 'f', 'F', 't', 'T' ]

" filetypes
au BufNewFile,BufRead *.tt.html set filetype=tt2html
au BufNewFile,BufRead *.html.tt set filetype=tt2html
au FileType gitrebase setlocal nomodeline

" start screen
let g:startify_lists = [
   \ { 'type': 'sessions',  'header': ['   Sessions']},
   \ { 'type': 'files',     'header': ['   Recently used files']},
   \ { 'type': 'dir',       'header': ['   Recent in '. getcwd()] },
   \ { 'type': 'bookmarks', 'header': ['   Bookmarks']},
   \ { 'type': 'commands',  'header': ['   Commands']},
   \ ]

let g:startify_bookmarks = [ '~/.vimrc', '~/.zshrc' ]
let g:startify_session_dir = '~/.vim/session'
let g:startify_change_to_vcs_root = 1

" peek at syntax elements for colorscheming
noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
         \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
         \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
