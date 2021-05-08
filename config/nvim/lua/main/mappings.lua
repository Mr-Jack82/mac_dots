local u = require("utils.core")

-- Set mapleader to comma ','
vim.g.mapleader = ","

-- Repeat letest f, t, F or T in opposite direction
u.map("n", "'", ",")

-- NOTE: C-6 to jump between last two files

-- Basics
u.map("n", "<leader>w", ":update<CR>")
u.map("n", "<leader>*", ":wa<CR>")
u.map("n", "<leader>q", ":update | bdelete<CR>")
u.map("n", "Q", "<Nop>")
u.map("n", "<leader>tS", ":luafile %<CR>", {silent = false})

-- Clean search (highlight)
u.map("n", "<Esc>", ":nohlsearch<CR>")
u.map("n", "<BS>", "<C-^>")
u.map("t", "<C-o>", [[<C-\><C-n>]])
u.map("n", "<A-t>", ":ToggleTerm<CR>")
u.map("t", "<A-t>", [[<C-\><C-n>:ToggleTerm<CR>]])
-- u.map("i", "{<Enter>", "{<Enter>}<Esc>O")

-- Remap for dealing with word wrap in Normal mode
u.map("n", "k", 'v:count == 0 ? "gk" : "k"', {expr = true})
u.map("n", "j", 'v:count == 0 ? "gj" : "j"', {expr = true})
-- same for visual mode
u.map("x", "k", '(v:count == 0 && mode() !=# "V") ? "gk" : "k"', {expr = true})
u.map("x", "j", '(v:count == 0 && mode() !=# "V") ? "gj" : "j"', {expr = true})

-- Visually select the text that was last edited/pasted
u.map("n", "gV", "`[v`]", {noremap = false})

-- new files
u.map("n", "<leader>nf", [[:e <C-R>=expand("%:p:h") . "/" <CR>]], {silent = false})
u.map("n", "<leader>ns", [[:vsp <C-R>=expand("%:p:h") . "/" <CR>]], {silent = false})
u.map("n", "<leader>nt", [[:tabedit <C-R>=expand("%:p:h") . "/" <CR>]], {silent = false})

-- Lsp Stop
u.map("n", "<leader>l.s", [[:LspStop <C-R>=<CR>]], {silent = false})

-- text
u.map("n", [[<leader>t"]], [[ciw"<c-r>""<esc>]])
u.map("n", [[<leader>t`]], [[ciw`<c-r>"`<esc>]])
u.map("n", [[<leader>t']], [[ciw'<c-r>"'<esc>]])
u.map("n", [[<leader>t)]], [[ciw(<c-r>")<esc>]])
u.map("n", [[<leader>t}]], [[ciw{<c-r>"}<esc>]])
u.map("n", [[<leader>tu]], [[guw]])
u.map("n", [[<leader>tU]], [[gUw]])
u.map("n", "<leader>t,", "A,<ESC>")
u.map("n", "<leader>t;", "A;<ESC>")
u.map("n", "<leader>t:", "A:<ESC>")

-- Automatically jump to the end of pasted text
u.map("v", "y", "y`]")
u.map("v", "p", "p`]")
u.map("n", "p", "p`]")

-- close all buffers but current
u.map("n", "<leader>!", [[<cmd>w <bar> %bd <bar> e#<CR>]])

-- Yank to the end of line
u.map("n", "Y", "y$", {silent = false} )

-- Remap for dealing with word wrap in Normal mode
u.map("n", "k", 'v:count == 0 ? "gk" : "k"', {expr = true})
u.map("n", "j", 'v:count == 0 ? "gj" : "j"', {expr = true})

-- same for visual mode
u.map("x", "k", '(v:count == 0 && mode() !=# "V") ? "gk" : "k"', {expr = true})
u.map("x", "j", '(v:count == 0 && mode() !=# "V") ? "gj" : "j"', {expr = true})

-- Allows you to save files you opened without write permissions via sudo
vim.cmd[[cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!]]

-- Enable soft wraping text
vim.cmd[[command! -nargs=* Wrap set wrap linebreak nolist]]

-- easy expansion of the active file directory
u.map("c", "%%", "<C-r>=fnameescape(expand('%:h')).'/'<CR>", {silent = false})
u.map("", "<leader>ew", ":e %%", {noremap = false, silent = false})
u.map("", "<leader>es", ":sp %%", {noremap = false, silent = false})
u.map("", "<leader>ev", ":vsp %%", {noremap = false, silent = false})
u.map("", "<leader>et", ":tabe %%", {noremap = false, silent = false})

-- Set working directory to the current buffer's directory
u.map("n", "cd", ":lcd %:p:h<bar>pwd<CR>", {silent = false})
u.map("n", "cu", "..<bar>pwd<CR>", {silent = false})

-- Make {motion} text uppercase in INSERT mode.
u.map("!", "<C-f>", "<Esc>gUiw`]a", {noremap = false})

-- Easier way to use of :ls command
u.map("n", "<leader>l", ":ls<CR>:b<Space>", {silent = false})

-- Visually select the text that was last edited/pasted
u.map("n", "gV", "`[v`]", {noremap = false})

-- Automatically jump to the end of pasted text
u.map("v", "y", "y`]")
u.map("v", "p", "p`]")
u.map("n", "p", "p`]")

-- Keep the flags from the previous substitute command for normal and visual mode
u.map("n", "&", ":&&<CR>", {silent = false})
u.map("x", "&", ":&&<CR>", {silent = false})

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
u.map("n", "n", "nzzzv")
u.map("n", "N", "Nzzzv")

-- Move selected line / block of text in visual mode
u.map("x", "K", ":move '<-2<CR>gv=gv")
u.map("x", "J", ":move '>+1<CR>gv=gv")

-- Better window navigation
u.map("n", "<C-h>", "<C-w>h")
u.map("n", "<C-j>", "<C-w>j")
u.map("n", "<C-k>", "<C-w>k")
u.map("n", "<C-l>", "<C-w>l")

-- Resize windows
u.map("n", "<S-k>", ":resize -2<CR>")
u.map("n", "<S-j>", ":resize +2<CR>")
u.map("n", "<S-h>", ":vertical resize -2<CR>")
u.map("n", "<S-l>", ":vertical resize +2<CR>")

-- Undotree
u.map("n", "<leader>u", ":UndotreeToggle<CR>")

-- Git
u.map("n", "<F5>", ":lua require('utils.core')._lazygit_toggle()<CR>")
u.map("n", "<leader>gf", ":Telescope git_files<CR>")
u.map("n", "<leader>gc", ":Telescope git_commits<CR>")
u.map("n", "<leader>gb", ":Telescope git_branches<CR>")
u.map("n", "<leader>gs", ":Telescope git_status<CR>")

-- buffer navigation
u.map("n", "<TAB>", ":bnext<CR>")
u.map("n", "<S-TAB>", ":bprev<CR>")

-- File manager
u.map("n", "<leader>n", ":NvimTreeToggle<CR>")

-- Telescope
u.map("n", "<leader>ff", ":Telescope find_files<CR>")
u.map("n", "<leader>fo", ":Telescope oldfiles<CR>")
u.map("n", "<leader>fg", ":Telescope live_grep<CR>")
u.map("n", "<leader>fh", ":Telescope help_tags<CR>")
u.map("n", "<leader>fc", ":Telescope colorscheme<CR>")
u.map("n", "<leader>fn", ":lua require('utils.core').search_nvim()<CR>")
u.map("n", "<leader>b", ":Telescope buffers<CR>")

-- LSP
u.map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
u.map("n", "gd", ":Telescope lsp_definitions<CR>")
u.map("n", "gy", ":lua vim.lsp.buf.type_definition()<CR>")
u.map("n", "gr", ":Telescope lsp_references<CR>")
u.map("n", "gh", ":Lspsaga hover_doc<CR>")
u.map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
u.map("n", "<leader>ld", ":Telescope lsp_document_diagnostics<CR>")
u.map("n", "<leader>lD", ":Telescope lsp_workspace_diagnostics<CR>")
u.map("n", "<leader>lr", ":Lspsaga rename<CR>")
u.map("n", "<c-p>", ":Lspsaga diagnostic_jump_prev<CR>")
u.map("n", "<c-n>", ":Lspsaga diagnostic_jump_next<CR>")
