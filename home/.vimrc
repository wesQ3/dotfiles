set nocompatible

" bootstrap plugin system
set rtp+=~/.vim/bundle/vim-plug
call plug#begin('~/.vim/bundle')

Plug 'junegunn/vim-plug'

"plugin bundles
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'danro/rename.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
Plug 'tomtom/tcomment_vim'
Plug 'justinmk/vim-sneak'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'elzr/vim-json'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'udalov/kotlin-vim'
Plug 'wesQ3/vim-bitbake'
Plug 'Konfekt/FastFold'
Plug 'unblevable/quick-scope'
Plug 'mhinz/vim-startify'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'kana/vim-textobj-user'
Plug 'lucapette/vim-textobj-underscore'
Plug 'frioux/vim-regedit'
Plug 'frioux/vim-lost'
Plug 'wesQ3/wombat.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'wesQ3/vim-matchit'
Plug 'gruvbox-community/gruvbox'

call plug#end()

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
else
   set termguicolors
   colorscheme gruvbox
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

function! s:get_git_root(dir)
  let dir = len(a:dir) ? a:dir : substitute(split(expand('%:p:h'), '[/\\]\.git\([/\\]\|$\)')[0], '^fugitive://', '', '')
  let root = systemlist('git -C ' . fzf#shellescape(dir) . ' rev-parse --show-toplevel')[0]
  return v:shell_error ? '' : (len(a:dir) ? fnamemodify(a:dir, ':p') : root)
endfunction

nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>B :FzfBranches<CR>
" WIP search from git root first, then fall back to cwd
nnoremap <Leader>F :call fzf#vim#files('~/code/')<CR>

" branch selector
let s:git_source_cmd = 'git branch --all --sort=-committerdate --color=always | sed -E "s/^[* ]+//"'
let s:git_preview_cmd = "git describe --always $(echo {1} | sed -E 's#^remotes/##'); echo; git log -n 5 --date=short --color=always --pretty=format:'%C(yellow)%h %Cblue%>(7)%cN %Cgreen%cd%Creset %s' $(echo {1} | sed -E 's#^remotes/##')"

command! -bang FzfBranches call fzf#run(fzf#wrap({
  \ 'source': s:git_source_cmd,
  \ 'sink': 'Git checkout',
  \ 'options': '--ansi --preview "' . s:git_preview_cmd . '"'
  \}))

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
let perl_fold_anonymous_subs = 0
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
let g:deoplete#enable_at_startup = has('nvim') ? 1 : 0
call deoplete#custom#option({
   \ 'smart_case': v:true,
   \ 'auto_complete_delay': 10,
   \ })

"syntastic
let g:syntastic_python_checkers = ['python3']

"common fugitive cmds
nnoremap <C-g> :Gsplit :<CR>
nnoremap <C-b> :G blame<CR>

" sneaking
let g:sneak#label = 1      " like easymotion
let g:sneak#use_ic_scs = 1 " smart casing
let g:sneak#s_next = 1     " hit s to repeat
