local u = require("utils.core")

-- Set mapleader to comma ','
vim.g.mapleader = ","

-- Repeat letest f, t, F or T in opposite direction
u.map("n", "'", ",")

-- NOTE: C-6 to jump between last two files

-- Basics
u.map("n", "<leader>w", ":update<CR>")
u.map("n", "<leader>q", ":bdelete<CR>")
u.map("n", "Q", "<Nop>")
u.map("n", "<leader>r", ":luafile %<CR>", {silent = false})

-- Clean search (highlight)
u.map("n", "<Esc>", ":nohlsearch<CR>")
u.map("n", "<BS>", "<C-^>")
u.map("t", "<C-o>", [[<C-\><C-n>]])
u.map("n", "<A-t>", ":ToggleTerm<CR>")
u.map("t", "<A-t>", [[<C-\><C-n>:ToggleTerm<CR>]])
-- u.map("i", "{<Enter>", "{<Enter>}<Esc>O")

--[[ " Making things easier a little bit
 Hacked from Steeve Losh
 https://bitbucket.org/sjl/dotfiles/src/default/vim/vimrc ]]
--[[ u.map("n", "H", "^")
u.map("n", "L", "$") ]]
u.map("v", "<S-v>", "g_")

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

-- Check file in shellcheck
u.map("n", "<leader>sc", ":!clear && shellcheck -x %<CR>")

-- Resize windows
u.map("n", "<S-k>", ":resize -2<CR>")
u.map("n", "<S-j>", ":resize +2<CR>")
u.map("n", "<S-h>", ":vertical resize -2<CR>")
u.map("n", "<S-l>", ":vertical resize +2<CR>")

-- Floaterm
u.map("n", "<leader>tk", ":FloatermKill<CR>")

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
u.map("n", "<C-p>", ":bprev<CR>")

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
u.map("n", "gh", ":lua vim.lsp.buf.hover()<CR>")
u.map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
u.map("n", "<leader>dd", ":Telescope lsp_document_diagnostics<CR>")
u.map("n", "<leader>dw", ":Telescope lsp_workspace_diagnostics<CR>")
u.map("n", "<space>rn", ":lua vim.lsp.buf.rename()<CR>")
u.map("n", "<gT>", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
u.map("n", "<c-n>", ":lua vim.lsp.diagnostic.goto_next()<CR>")
