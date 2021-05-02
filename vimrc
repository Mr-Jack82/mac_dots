" ============================================================================= "
" ===                             BASIC OPTIONS                             === "
" ============================================================================= "

set nocompatible
filetype off
syntax on
filetype plugin indent on

" Remap leader to ','
let g:mapleader=','

" Navigation in russian layout
nmap р h
nmap о j
nmap л k
nmap д l
nmap ш i
nmap ф a
nmap в d

set modelines=0
set nu
set rnu
set nowrap
set ruler
set colorcolumn=80

set noerrorbells
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set scrolloff=8
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
set path=$PWD/**    " enable fuzzy finding in the vim command line
set wildmenu        " enable fuzzy menu
set wildignore+=**/.git/**,**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd
set nohls
set incsearch
set ignorecase
set smartcase
set showmatch
" set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·
" set list

" Yank and paste with the system clipboard
if has ('unnamedplus')
    set clipboard=unnamed,unnamedplus
else
    set clipboard=unnamed
endif

" Remember last cursor position.
augroup remember-cursor-position
  autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") &&
        \   &ft !~# '\%(^git\%(config\)\@!\|commit\)'
        \ | exe "normal! g`\""
        \ | endif
augroup END

" to change the cursor in different modes use this:
" from https://habr.com/ru/post/468265/
set ttimeoutlen=10          " Reduce the delay in entering escape sequences
let &t_SI.="\e[5 q"         " SI = INSERT mode
let &t_SR.="\e[3 q"         " SR = REPLACE mode
let &t_EI.="\e[1 q"         " EI = NORMAL mode
" Where:
" 1 - is the flashing rectangle
" 2 - regular rectangle
" 3 - flashing underline
" 4 - just underline
" 5 - flashing vertical bar
" 6 - just a vertical bar

map <leader>l :set list!<CR> " Toggle tabs and EOL

" Plugin Management
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'

" Auto completion
" Plug 'maxboisvert/vim-simple-complete'
Plug 'lifepillar/vim-mucomplete'

Plug 'tekannor/ayu-vim'

" Initialize plugin system
call plug#end()

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" My Remaps
 nnoremap <C-b> :NERDTreeToggle<CR>
 nnoremap <C-p> :find
