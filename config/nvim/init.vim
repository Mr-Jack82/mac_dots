autocmd!
source ~/.config/nvim/plugins.vim

" source of this config is https://github.com/ctaylo21/jarvis
" also read his article "A guide to modern Web Development with (Neo)vim"
" https://www.freecodecamp.org/news/a-guide-to-modern-web-development-with-neo-vim-333f7efbf8e2/

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" Remap leader key to ,
let g:mapleader=','

if has('vim_starting')
	set encoding=utf-8
	scriptencoding utf-8

	" Enables 24-bit RGB color in the TUI
	if has('termguicolors') && $COLORTERM =~# 'truecolor\|24bit'
		set termguicolors
	endif
endif

" Enable line numbers
set number
set numberwidth=5

" Show the line number relative to the line with the cursor in front of
" each line.
set relativenumber

" Show (partial) command in the last line of the screen.
set showcmd

" Yank and paste with the system clipboard
set clipboard=unnamedplus

" Remember last cursor position
augroup remember-cursor-position
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") &&
        \   &ft !~# '\%(^git\%(config\)\@!\|commit\)'
        \ | exe "normal! g`\""
        \ | endif
augroup END

" Enable mouse support in all modes.
set mouse=a

" Enable loading the plugin files for specific file types and indent support
filetype plugin indent on

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Setting up vertical split separator as in Tmux.
set fillchars+=vert:│

" Match angle brackets...
set matchpairs+=<:>,«:»,｢:｣

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=7

" Making scrolling horizontally a bit more useful
set sidescroll=5
set listchars+=precedes:<,extends:>

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Hides buffers instead of closing them
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=50

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Set Python3 provider as of Neovim is recommend
let g:python3_host_prog = '/usr/bin/python3'

" =====[ TAB/Space settings ]=====

" default indentation: 2 spaces
 set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

 " Only do this part when compiled with support for autocommands
augroup tabs-and-spaces
  if has("autocmd")

    " Enable file type detection
    filetype on

    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

    " Customisations based on house-style (arbitrary)
    autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType javascript setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml

    " Treat .ejs (embedded javascript) file as HTML
    autocmd BufNewFile,BufRead *.ejs set filetype=html
augroup END

" Set tabstop, softtabstop and shiftwidth to the same value
" from vimcast.org #2 Tabs and Spaces
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon 'shiftwidth='.&l:sw
    echon 'softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

  " Enable syntax highlight for *.log files
augroup log-messages
  autocmd!
  autocmd BufNewFile,BufReadPost *.log :set filetype=messages
endif
augroup END

" do not wrap long lines by default
set nowrap

" Don't highlight current cursor line
set nocursorline

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=2

" =====[ Completion Settings ]=====

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" Do smart autoindenting when starting a new line.
set smartindent

" Fix spelling errors
iabbrev cosnt const

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" =====[ Coc.nvim ]=====
" Use <tab> for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

function! HasEslintConfig()
  for name in ['.eslintrc.js', '.eslintrc.json', '.eslintrc']
    if globpath('.', name) != ''
      return 1
    endif
  endfor
endfunction

" Turn off eslint when cannot find eslintrc
call coc#config('eslint.enable', HasEslintConfig())

" Essentially avoid turning on typescript in a flow project
call coc#config('tsserver.enableJavascript', globpath('.', '.flowconfig') == '')

" lookup local flow executable
" and turn on flow for coc in executable exists
function! SetFlow()
  let s:flow_in_project = findfile('.nvm/versions/node/v10.19.0/lib/node_modules/flow-bin/flow-linux64-v0.123.0/flow')
  let s:flow_exe = empty(s:flow_in_project) ? '' : getcwd() . '/' . s:flow_in_project
  let s:flow_config = {
    \    'command': s:flow_exe,
    \    'args': ['lsp'],
    \    'filetypes': ['javascript', 'javascriptreact'],
    \    'initializationOptions': {},
    \    'requireRootPattern': 1,
    \    'settings': {},
    \    'rootPatterns': ['.flowconfig']
    \}

" Turn on flow when flow executable exists
  if !empty(s:flow_exe)
    call coc#config('languageserver', { 'flow': s:flow_config })
  endif
endfunction

call SetFlow()

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
    \ 'coc-marketplace',
    \ 'coc-lua',
    \ 'coc-pairs'
    \ ]

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
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" For conceal markers
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" =====[ NERDTree ]=====
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

" Synchronizing nerdtree with the currently opened file
" from reddit post (https://www.reddit.com/r/vim/comments/g47z4f/synchronizing_nerdtree_with_the_currently_opened/?%24deep_link=true&correlation_id=8c881181-a7d4-4e11-94dc-f125f7daaa68&ref=email_digest&ref_campaign=email_digest&ref_source=email&utm_content=post_title&utm_medium=digest&utm_name=top_posts&utm_source=email&utm_term=day&%243p=e_as&%24original_url=https%3A%2F%2Fwww.reddit.com%2Fr%2Fvim%2Fcomments%2Fg47z4f%2Fsynchronizing_nerdtree_with_the_currently_opened%2F%3F%24deep_link%3Dtrue%26correlation_id%3D8c881181-a7d4-4e11-94dc-f125f7daaa68%26ref%3Demail_digest%26ref_campaign%3Demail_digest%26ref_source%3Demail%26utm_content%3Dpost_title%26utm_medium%3Ddigest%26utm_name%3Dtop_posts%26utm_source%3Demail%26utm_term%3Dday&_branch_match_id=699372985519899548)
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

" Wrap in try/catch to avoid errors on initial install before plugin is available
try

" =====[ Vim airline ]======
" Enable extensions
let g:airline#extensions#bufferline#enabled = 1
let g:airline_extensions = ['branch', 'hunks', 'coc']

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [
  \ ['a', 'b', 'c'],
  \ ['x', 'z', 'error', 'warning',]
  \ ]

" Customize vim airline per filetype
" 'nerdtree'  - Hide nerdtree status line
" 'list'      - Only show file type plus current line number out of total
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L' ],
  \ }

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '❮'
let g:airline_right_sep = '❯'

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

" =====[ echodoc ]=====
" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1

" =====[ vim-javascript ]=====
" Enable syntax highlighting for JSDoc
let g:javascript_plugin_jsdoc = 1

" =====[ vim-jsx ]=====
" Highlight jsx syntax even in non .jsx files
let g:jsx_ext_required = 0

" =====[ javascript-libraries-syntax ]=====
let g:used_javascript_libs = 'underscore,requirejs,chai,jquery'

" =====[ Signify ]=====
let g:signify_sign_delete = '-'

" =====[ EasyAlign ]=====
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" =====[ vim-auto-save ]=====
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

" Disable auto save for javascript and json files
augroup ft_javascript
  au!
  au FileType javascript,json let b:auto_save = 0
augroup END

" =====[ vim-repeat ]=====
" This is an example from Github page and needed to edit properly
" from Vimcast #61
nnoremap <silent> <Plug>TransposeCharacters xp
      \:call repeat#set("\<Plug>TransposeCharacters")<CR>
nmap cp <Plug>TransposeCharacters

" =====[ indent-blankline ]=====
" Specifies a list of |buftype| values for which this plugin is not enabled.
let g:indent_blankline_buftype_exclude = [ 'terminal' ]

" Specifies a list of |filetype| values for which this plugin is not enabled.
let g:indent_blankline_filetype_exclude = [ 'help', 'startify', 'packer' ]

" Specifies the character to be used as indent line.
let g:indent_blankline_char = '▏'

" Displays a trailing indentation guide on blank lines, to match the
" indentation of surrounding code.
" Turn this off if you want to use background highlighting instead of chars.
let g:indent_blankline_show_trailing_blankline_indent = v:false

" Do not show indentation for the first line
let g:indent_blankline_show_first_indent_level = v:false

" Displays a trailing indentation guide on blank lines, to match the
" indentation of surrounding code.
" Turn this off if you want to use background highlighting instead of chars.
let g:indent_blankline_show_trailing_blankline_indent = v:true

" Highlight of indent character when base of current context.
" NOTE: This feature requires Treesitter
" let g:indent_blankline_show_current_context = v:true
" let g:indent_blankline_context_patterns = [
"       \ 'class', 'return', 'function', 'method', '^if', '^while',
"       \ 'jsx_element', '^for', '^object', '^table', 'block', 'arguments',
"       \ 'if_statement', 'else_clause', 'jsx_element',
"       \ 'jsx_self_closing_element', 'try_statement', 'catch_clause',
"       \ 'import_statement'
"       \ ]

" =====[ undotree ]=====
let g:undotree_WindowLayout = 3

" =====[ fugitive ]=====
" Auto-clean fugitive buffers
augroup auto-clean-fugitive
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" Use '..' to go up the history of Git commits, but only for buffers
" containing a git blob or tree
augroup go-up-fugitive
  autocmd!
  autocmd User fugitive
        \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
        \     nnoremap <buffer> .. :edit %:h<cr> |
        \ endif
augroup END

" Vim-Plug shortcut for update all plugins and upgrade itself
" (:PU instead of :PlugUpdate | PlugUpgrade)
command! PU PlugUpdate | PlugUpgrade

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

" =====[ fzf.vim ]=====

" Mappings
nnoremap <leader>p           :Files<cr>
nnoremap <leader>.           :Tags<cr>
nnoremap <leader>b           :Buffers<cr>
nnoremap <silent> <leader>'  :Marks<cr>
nnoremap <silent> <Leader>L  :Lines<cr>

" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '40%' }

" Hide statusline.
" It's a good combo with `{ 'down': '40%' }` layout
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
endif

" Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" ===[ editorconfig-vim ]===
" Fix conflicts with Tim Pope's fugitive and avoid loading EditorConfig
" for any remote files over ssh
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Fix conflicts of trailing whitespace trimming and buffer autosaving
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

"For correct appear in some terminals
if exists('+termguicolors')
 let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
 let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
 set termguicolors

 "for italic in tmux
endif

" ===[ nvim-colorizer ]===
lua require'colorizer'.setup()

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Vim airline theme
let g:airline_theme='space'
" silent! colorscheme kolor

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
" From denite.vim docs: To use "floating", you need to use neovim 0.4.0+
" (|nvim_open_win()|). neovim 0.3(includes 0.3.7) does not work.
set winblend=10

" Set a WildMenu in old style
set wildoptions=""

" Window management in (neo)Vim
augroup ReduceNoise
    autocmd!
    " Automatically resize active split to 85 width
    autocmd WinEnter * :call ResizeSplits()
augroup END

function! ResizeSplits()
    set winwidth=60
    wincmd =
endfunction

" Unfocuse window when cursor lives
autocmd WinEnter * setlocal cursorline
autocmd WinEnter * setlocal signcolumn=auto

autocmd WinLeave * setlocal nocursorline
autocmd WinLeave * setlocal signcolumn=no

" ============================================================================ "
" ===                      CUSTOM COLORSCHEME CHANGES                      === "
" ============================================================================ "
"
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

" Editor theme
set background=dark
try
  colorscheme OceanicNext
catch
  colorscheme slate
endtry

" Make it more obvious where 'ColorColumn' is
highlight ColorColumn guibg=SlateBlue3
" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" =====[ Nerdtree shorcuts ]=====
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

"   <Space> - PageDown
"   -       - PageUp
noremap <Space> <PageDown>
noremap - <PageUp>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" =====[ coc.nvim ]=====
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> <leader>ds :<C-u>CocList -I -N --top symbols<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" =====[ vim-better-whitespace ]=====
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>

" =====[ Search shorcuts ]=====
"   <leader>h - Find and replace
"   <leader>/ - Clear highlighted search terms while preserving history
map <leader>h :%s///<left><left>

" =====[ Easy-motion shortcuts ]=====
" Disable default mappings
" let g:EasyMotion_do_mapping = 0

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

" =====[ vim-jsdoc shortcuts ]=====
" Generate jsdoc for function under cursor
nmap <leader>z :JsDoc<CR>

" =====[ undotree ]=====
nnoremap <Leader>u :UndotreeToggle<cr>

" =====[ Little usability improvements ]=====

" Allows you to save files you opened without write permissions via sudo
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" cmap w!! w !sudo tee %

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

"" Clean search (highlight)
nnoremap <silent> <esc> :nohlsearch<cr>

" Make {motion} text uppercase in INSERT mode.
map! <C-F> <Esc>gUiw`]a

" When change some text delete the source without affecting the normal
" registers ("_ is a "black hole" register).
" nnoreMap c "_c

" Repeat latest f, t, F or T in opposite direction
nnoremap ' ,

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easy expansion of the active file directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" >>> Instead of that use a dot '.' command <<<
"" Vmap for maintain Visual Mode after shifting > and <
" vmap < <gv
" vmap > >gv

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

" >>> Use unimpaired.vim keybindings <<<
" nnoremap <silent> [b :bprevious<CR>
" nnoremap <silent> ]b :bnext<CR>
" nnoremap <silent> [B :bfirst<CR>
" nnoremap <silent> ]B :blast<CR>

" Automaticaly jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Enable soft wraping text
command! -nargs=* Wrap set wrap linebreak nolist

" Moving around through wrapped lines
vmap <M-j> gj
vmap <M-k> gk
vmap <M-4> g$
vmap <M-6> g^
vmap <M-0> g^
nmap <M-j> gj
nmap <M-k> gk
nmap <M-4> g$
nmap <M-6> g^
nmap <M-0> g^

" Visually select the text that was last edited/pasted
nmap gV `[v`]

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

" Switching between Terminal Mode and Normal Mode
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif

" Distinguishing the Terminal Cursor from the Normal Cursor
if has('nvim')
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

" Easy window switching for Terminal mode
if has('nvim')
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
endif

" When in terminal buffer -> Insert Mode
augroup insert_in_term
  autocmd!
  if has('nvim')
    autocmd!
    autocmd TermOpen,BufEnter term://* startinsert
  endif
augroup END

" Insert blank lines
nnoremap <cr> o<esc>

" Yank to end of line
nnoremap Y y$

" Making things easier a little bit
" Hacked from Steeve Losh
" https://bitbucket.org/sjl/dotfiles/src/default/vim/vimrc
nnoremap H ^
nnoremap L $
vnoremap L g_

" Move through visual line normally only if they exists
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <expr> j (v:count == 0 && mode() !=# 'V') ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <expr> k (v:count == 0 && mode() !=# 'V') ? 'gk' : 'k'

" Set working directory to the current buffer's directory
nnoremap cd :lcd %:p:h<bar>pwd<cr>
nnoremap cu :lcd ..<bar>pwd<cr>

" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "

" Automaticaly close nvim if NERDTree is only thing left open
augroup close-nerdtree
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" =====[ Search ]=====
" Turning On Neovim built-in feature inccommand, to live preview the
" :substitute command
if has("nvim")
  set inccommand=nosplit
endif

" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case
" sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Clear all registers with :WipeReg command
command! WipeReg for i in range(34,122) | silent!
      \ call setreg(nr2char(i), []) | endfor

" Resize splits when the window is resized
augroup on_vim_resized
  autocmd!
  autocmd VimResized * wincmd =
augroup END

" Prevent Neovim from nesting inside of a terminal buffer
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait + 'set bufhidden=wipe'"
endif

" Disable persistent undo for temporary files
augroup vimrc
  autocmd!
  autocmd BufWritePre /tmp/* setlocal noundofile
augroup END

" Turn off line number and relativenumber for term buffer
augroup termBuffer
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" Highlight on yank
augroup highlight_yank
  if exists('##TextYankPost')
    autocmd!
    autocmd TextYankPost *
          \ silent! lua return (not vim.v.event.visual) and
          \ require'vim.highlight'.on_yank({higroup="IncSearch", timeout = 150})
  endif
augroup END

" Autosave
" from:
" https://github.com/junegunn/dotfiles/blob/18e886d73eac4866724cfcb00ef168dffd5be0d4/vimrc#L904
" function! s:autosave(enable)
"   augroup autosave
"     autocmd!
"     if a:enable
"       autocmd TextChanged,InsertLeave <buffer>
"             \  if empty(&buftype) && !empty(bufname(''))
"             \|   silent! update
"             \| endif
"     endif
"   augroup END
" endfunction

" command! -bang AutoSave call s:autosave(<bang>1)
