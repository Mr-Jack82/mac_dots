" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Minimalist Vim Plugin Manager
Plug 'junegunn/vim-plug'

" === Editing Plugins === "

" Automatically save changes to disk in Vim
Plug '907th/vim-auto-save'

" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" A Vim alignment plugin
Plug 'junegunn/vim-easy-align'

" auto-close plugin
Plug 'cohama/lexima.vim'

" Easy text exchange operator for Vim
Plug 'tommcdo/vim-exchange'

" vim match-up: even better % fist_oncoming navigate and highlight
" matching words fist_oncoming modern matchit and matchparen replacement
Plug 'andymass/vim-matchup', { 'for':
    \  ['dart', 'eruby', 'html', 'javascript', 'json', 'xml']
    \}

" === Code completion, snippets === "

" Nodejs extension host for vim & neovim, load extensions like VSCode and host
" language servers.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'

" emmet for vim: https://emmet.io/
Plug 'mattn/emmet-vim', {'for': ['html', 'css']}

" Snippet support
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" EditorConfig plugin for Vim
" Note: this plugin conflicts with 'vim-auto-save'
Plug 'editorconfig/editorconfig-vim'

" === Seaching and Moving === "

" fzf ♡ vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" Most Recently Used (MRU) Vim Plugin
Plug 'yegappan/mru'

" Tmux/Neovim movement integration
Plug 'christoomey/vim-tmux-navigator'

" File explorer
Plug 'preservim/nerdtree'

" Preview colours in source code while editing
Plug 'ap/vim-css-color'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" A very simple plugin that makes hlsearch more useful
Plug 'romainl/vim-cool'

" === UI === "

" Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Initialize plugin system
call plug#end()

" =============================================================
" ==> General
" =============================================================

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
 set nocompatible
endif

" Enables 24-bit RGB color in the TUI
set laststatus=2
syntax on

" Set encoding
if &encoding ==# 'latin1' && !exists('$LANG')
   set encoding=utf-8
endif

scriptencoding utf-8

" Remap leader key to ','
let g:mapleader=','

" Enable line numbers
set number

" Show the line number relative to the line with the cursor in front of
" each line.
set relativenumber

" Show file title in terminal tab
set title

" Show (partial) command in the last line of the screen.
set showcmd

" Set show matching parenthesis
set showmatch

" ignore case if search pattern is all lowercase
set smartcase

" ignore case when searching
set ignorecase

" highlight search terms
set hlsearch

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Do incremental searching when it's possible to timeout.
if has('reltime')
 set incsearch
endif

" make <C-a> and <C-x> play well with zero-padded numbers (i.e. don't cosider
" them octal or hex)
set nrformats-=octal

" Disable bell for all events
set belloff=all

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
     \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
     \ |   exe "normal! g`\""
     \ | endif
augroup END

" Make keyboard fast and reduce the delay in entering escape sequences
set ttyfast
set timeout timeoutlen=1000 ttimeoutlen=50

" Don't update the display while executing macros
set lazyredraw

" to change the cursor in different modes use this:
" from https://habr.com/ru/post/468265/
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

" Enable mouse support in all modes.
set mouse=a

" Enable loading the plugin files for specific file types.
filetype plugin indent on

" remember more commands and history
set history=1000

set undolevels=1000
if v:version >= 730
 set undofile
 set undodir=~/.vim/undodir
endif

" don't keep backup files
set nobackup

" do not write out changes via backup files
set nowritebackup

" No backup files
set noswapfile

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
   runtime! macros/matchit.vim
endif

" Setting up vertical split separator as in Tmux.
set fillchars+=vert:│

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=7

" Hides buffers instead of closing them.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=50

" Always show signcolumns.
set signcolumn=yes

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Search relative to current file + directory
" Provides tab-completion for all file-related tasks
set path+=**

" === TAB/Space settings === "
" default indentation: 4 spaces
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Be smart
set smarttab

" Do smart autoindenting when starting a new line.
set smartindent

" do not wrap long lines by default
set nowrap

" Move through visual line normally only if they exists
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> j (v:count == 0 && mode() !=# 'V') ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> k (v:count == 0 && mode() !=# 'V') ? 'gk' : 'k'

" Don't highlight current cursor line
set nocursorline

" 256 color support
set t_Co=256

" Enable status line
set laststatus=2

" Show as much as possible of the last line.
set display=lastline

" Only two line for command line
set cmdheight=2

" Nice command completions
set wildmenu
set wildmode=full

" === Completion Settings === "

" A comma separated list of options for Insert mode completion
if exists('+completeopt')
 set completeopt=noinsert,menuone,noselect
endif

" Height of complete list
set pumheight=20

"	don't give 'ins-completion-menu' messages.  For example,
" 'match 1 of 2', 'The only match'
set shortmess+=c

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" ===[ Coc.nvim ]===
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
 " Recently vim can merge signcolumn and number column into one
 set signcolumn=number
else
 set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

let g:coc_global_extensions=[
   \ 'coc-tsserver',
   \ 'coc-prettier',
   \ 'coc-css',
   \ 'coc-json',
   \ 'coc-emmet',
   \ 'coc-eslint',
   \ 'coc-highlight',
   \ 'coc-vimlsp',
   \ 'coc-sh',
   \ 'coc-tslint-plugin',
   \ 'coc-neosnippet',
   \ 'coc-lua',
   \ 'coc-pairs'
   \ ]

" =====[ Easy-motion shortcuts ]=====
" Setting up <Leader> key for easymotion
map <Leader> <Plug>(easymotion-prefix)

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding. `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)

" Bidirectional & within line 't' motion
omap t <Plug>(easymotion-bd-tl)

" Enable 'dot' repeat feature
omap z <Plug>(easymotion-t)
let g:EasyMotion_keys='hklyuiopnm,qwertzxcvbasdgjf;'

" Lazy targeting
let g:EasyMotion_smartcase = 1

" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'

" ===[ NERDTree ] ===
" Show hidden files/directories
let g:NERDTreeShowHidden = 1

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Automatically close NerdTree when you open a file
let NERDTreeQuitOnOpen = 1

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
 return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a
" modifiable file, and we're not in vimdiff
function! SyncTree()
 if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
   NERDTreeFind
   wincmd p
 endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

" ===== Vim airline ===== "
" Enable extensions
let g:airline_extensions = ['branch', 'hunks', 'coc']

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Customize vim airline per filetype
" 'nerdtree'  - Hide nerdtree status line
" 'list'      - Only show file type plus current line number out of total
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

" =====[ NeoSnippet ]=====
" Map <C-j> as shortcut to activate snippet if available
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

" Fix for jumping over placeholders for neosnippet
smap <expr><TAB> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_jump)"
\: "\<TAB>"

" Load custom snippets from snippets folder
" let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" For conceal markers
if has('conceal')
 set conceallevel=2 concealcursor=niv
endif

" =====[ vim-auto-save ]=====
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

" Disable auto save for javascript and json files
augroup ft_javascript
  au!
  au FileType javascript,json let b:auto_save = 0
augroup END

" =====[ vim-matchup ]=====
let g:matchup_surround_enabled     = 1
let g:matchup_transmute_enabled    = 1
let g:matchup_delim_noskip         = 2
let g:matchup_matchparen_deferred  = 1
let g:matchup_matchparen_nomode    = 'i'
let g:matchup_matchparen_offscreen = { 'method': 'popup', 'scrolloff': 1 }
let g:matchup_matchpref            = {
 \  'html':  { 'tagnameonly': 1, 'nolists': 1 },
 \  'eruby': { 'tagnameonly': 1, 'nolists': 1 },
 \  'xml':   { 'tagnameonly': 1, 'nolists': 1 },
 \}

" ===[ editorconfig-vim ]===
" Fix conflicts with Tim Pope's fugitive and avoid loading EditorConfig
" for any remote files over ssh
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Fix conflicts of trailing whitespace trimming and buffer autosaving
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

" ===[ highlightedyank ]===
let g:highlightedyank_highlight_duration = 150
" ==============================================================================

" Setting up ignores
set wildignore+=*.o,*.obj,*.pyc                " output objects
set wildignore+=*.png,*.jpg,*.gif,*.ico        " image format
set wildignore+=*.swf,*.fla                    " image format
set wildignore+=*.mp3,*.mp4,*.avi,*.mkv        " media format
set wildignore+=*.git*,*.hg*,*.svn*            " version control system
set wildignore+=*sass-cache*
set wildignore+=*.DS_Store
set wildignore+=log/**
set wildignore+=tmp/**

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Enable true color support
" for more details see :h xterm-true-color
" NOTE: the "^[" is a single character. To insert it, press
" "Ctrl-v" and then "Esc" or use "\<Esc>" instead
if exists('+termguicolors')
 let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
 let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
 set termguicolors
endif

" Set preview window to appear at bottom
set splitbelow

" Vim airline theme
let g:airline_theme='space'

" ============================================================================ "
" ===                      CUSTOM COLORSCHEME CHANGES                      === "
" ============================================================================ "
" Add custom highlights in method that is executed every time a
" colorscheme is sourced
" See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for
" details
function! TrailingSpaceHighlights() abort
  " Hightlight trailing whitespace
  highlight Trail ctermbg=red guibg=red
  call matchadd('Trail', '\s\+$', 100)
endfunction

function! s:custom_jarvis_colors()
    " coc.nvim color changes
    hi! link CocErrorSign WarningMsg
    hi! link CocWarningSign Number
    hi! link CocInfoSign Type

    " Make background transparent for many things
    hi! Normal ctermbg=NONE guibg=NONE
    hi! NonText ctermbg=NONE guibg=NONE
    hi! LineNr ctermfg=NONE guibg=NONE
    hi! SignColumn ctermfg=NONE guibg=NONE
    hi! StatusLine guifg=#16252b guibg=#6699CC
    hi! StatusLineNC guifg=#16252b guibg=#16252b

    " Try to hide vertical spit and end of buffer symbol
    hi! VertSplit gui=NONE guifg=#17252c guibg=#17252c
    hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=#17252c guifg=#17252c

    " Customize NERDTree directory
    hi! NERDTreeCWD guifg=#99c794

    " Make background color transparent for git changes
    hi! SignifySignAdd guibg=NONE
    hi! SignifySignDelete guibg=NONE
    hi! SignifySignChange guibg=NONE

    " Highlight git change signs
    hi! SignifySignAdd guifg=#99c794
    hi! SignifySignDelete guifg=#ec5f67
    hi! SignifySignChange guifg=#c594c5
endfunction

augroup trailing-space-highlight
  autocmd! ColorScheme * call TrailingSpaceHighlights()
  autocmd! ColorScheme OceanicNext call s:custom_jarvis_colors()
augroup END

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" Color Theme
colorscheme gruvbox
" For gruvbox specifically
set background=dark

" Make it more obvious where 'ColorColumn' is
highlight ColorColumn guibg=SlateBlue3

" =============================================================
" ==> Moving around, tabs, windows and buffers
" =============================================================

" Open vimrc file with a few key strokes
nmap <leader>v :tabedit $MYVIMRC<CR>

" Allows you to save files you opened without write permissions via sudo
" cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Easy expansion of the active file directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Easy movement in *INSERT* mode
inoremap <C-l> <Right>
inoremap <C-h> <Left>

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" =====[ Nerdtree shorcuts ]=====
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

" Clean search (highlight)
nnoremap <silent><Space> :noh<CR>

" Make {motion} text uppercase in INSERT mode.
map! <C-F> <Esc>gUiw`]a

" Allows you to save files you opened without write permissions via sudo
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Repeat latest f, t, F or T in opposite direction
nnoremap ' ,

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Automaticaly jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Search for the Current Selection (Redux)
" from Practical Vim, 2nd edition book by Drew Neil
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
   let temp = @s
   norm! gv"sy
   let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
   let @s = temp
endfunction

" Keep the flags from the previous substitute command for normal
" and visual mode
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Vim-Plug shortcut for update all plugins and upgrade itself
" (:PU instead of :PlugUpdate | PlugUpgrade)
command! PU PlugUpdate | PlugUpgrade

" Move selected text Up and Down
" from Vimcast #26 Bubbling text
" >>>Note that "[e, ]e" and other work only if vim-unimpaired is installed<<<
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Easier way to use of :ls command
nnoremap <Leader>l :ls<cr>:b<Space>

" Shortcut to save
nmap <Leader>, :w<CR>

" Yank to end of line
nnoremap Y y$

" Making things easier a little bit
" Hacked from Steeve Losh
" https://bitbucket.org/sjl/dotfiles/src/default/vim/vimrc
nnoremap H ^
nnoremap L $
vnoremap L g_

" Set working directory to the current buffer's directory
nnoremap cd :lcd %:p:h<bar>pwd<cr>
nnoremap cu :lcd ..<bar>pwd<cr>
