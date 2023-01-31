set nocompatible
filetype off

"vundle your bundles
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"vundle bundles
Plugin 'tpope/vim-sensible'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'Shougo/deoplete.nvim'
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
Plugin 'kergoth/vim-bitbake'
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
filetype plugin on
syntax enable

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
         set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14
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

" file rifling

nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>b :Buffers<CR>

let g:current_plenv_ver = system("ls -1 ~/.plenv/versions | sort --reverse | head -1 | tr -d '\n'")
if !v:shell_error && g:current_plenv_ver
   nnoremap <expr> <Leader>p ':FZF ~/.plenv/versions/' . g:current_plenv_ver . '/lib/perl5/<CR>'
else
   nnoremap <Leader>p :echo 'No current perl at $HOME/.plenv ??'<CR>
endif


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
let g:startify_skiplist = [
   \ '/run/user/.*/gvfs',
   \ ]

" peek at syntax elements for colorscheming
noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
         \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
         \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
   \ 'smart_case': v:true,
   \ 'auto_complete_delay': 10,
   \ })

"syntastic
let g:syntastic_python_checkers = ['python3']

" dart / flutter
let g:dart_style_guide = 2

"common fugitive cmds
nnoremap <C-g> :Gsplit :<CR>
nnoremap <C-b> :G blame<CR>
