local u = require("utils.core")

-- Set mapleader to comma ','
vim.g.mapleader = ","

-- Repeat letest f, t, F or T in opposite direction
u.map("n", "'", ",")

-- NOTE: C-6 to jump between last two files

u.map("n", "Q", "<Nop>")
u.map("n", "<leader>tS", ":luafile %<CR>", {silent = false})

-- Clear search (highlight)
u.map("n", "<Esc>", ":nohlsearch<CR>")
u.map("n", "<BS>", "<C-^>")
u.map("n", "Y", "y$")
u.map("t", "<C-o>", [[<C-\><C-n>]])
u.map("n", "<A-t>", ":ToggleTerm<CR>")
u.map("t", "<A-t>", [[<C-\><C-n>:ToggleTerm<CR>]])
-- u.map("i", "{<Enter>", "{<Enter>}<Esc>O")

-- Move selected line / block of text in visual mode
u.map("x", "K", ":move '<-2<CR>gv=gv")
u.map("x", "J", ":move '>+1<CR>gv=gv")

-- Packer.nvim shortcut to update all plugins
vim.cmd[[command! PU PackerUpdate]]

-- Automatically jump to the end of pasted text
u.map("v", "y", "y`]")
u.map("v", "p", "p`]")
u.map("n", "p", "p`]")

-- close all buffers but current
u.map("n", "<leader>!", [[<cmd>w <bar> %bd <bar> e#<CR>]])

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

-- File manager
u.map("n", "<leader>n", ":NvimTreeToggle<CR>")

-- Undotree
u.map("n", "<leader>u", ":UndotreeToggle<CR>")

-- new files
u.map("n", "<leader>nb", [[:enew<CR>]], {silent = false})
u.map("n", "<leader>nf", [[:e <C-R>=expand("%:p:h") . "/" <CR>]], {silent = false})
u.map("n", "<leader>ns", [[:vsp <C-R>=expand("%:p:h") . "/" <CR>]], {silent = false})
u.map("n", "<leader>nt", [[:tabedit <C-R>=expand("%:p:h") . "/" <CR>]], {silent = false})

-- help
u.map("n", "<leader>hv", ":Telescope help_tags<CR>")
u.map("n", "<leader>hm", ":Telescope man_pages<CR>")

-- buffer navigation
u.map("n", "<TAB>", ":bnext<CR>")
u.map("n", "<S-TAB>", ":bprev<CR>")
-- buffers
u.map("n", "<leader>bb", ":Telescope buffers<CR>") -- all buffers
u.map("n", "<leader>bs", ":update<CR>") -- save buffer
u.map("n", "<leader>bS", ":wa<CR>") -- save all buffers
u.map("n", "<leader>bq", ":update | bdelete<CR>") -- quit buffer
u.map("n", "<leader>bQ", [[<cmd>w <bar> %bd <bar> e#<CR>]]) -- quit all buffers but current
u.map("n", "<leader>b%", ":luafile %<CR>", {silent = false}) -- source buffer
u.map("n", "<leader>b]", ":bnext<CR>") -- buffer next
u.map("n", "<leader>b[", ":bprev<CR>") -- buffer previous

-- windows
u.map("n", "<leader>ww", "<C-w>q") -- cycle through window
u.map("n", "<leader>wq", "<C-w>q") -- quit window
u.map("n", "<leader>ws", "<C-w>s") -- split window
u.map("n", "<leader>wv", "<C-w>v") -- vertical split
u.map("n", "<leader>wh", "<C-w>h") -- jump to left window
u.map("n", "<leader>wj", "<C-w>j") -- jump to the down window
u.map("n", "<leader>wk", "<C-w>k") -- jump to the up window
u.map("n", "<leader>wl", "<C-w>l") -- jump to right window
u.map("n", "<leader>wm", "<C-w>|") -- max out to fullscreen
u.map("n", "<leader>w=", "<C-w>=") -- equally high and width
u.map("n", "<leader>wT", "<C-w>T") -- break out into a new tab
u.map("n", "<leader>wr", "<C-w>x") -- replace current with next
u.map("n", "<leader>w<", ":vertical resize -10<CR>") -- decrease width
u.map("n", "<leader>w>", ":vertical resize +10<CR>") -- increase width
u.map("n", "<leader>w-", ":resize -15<CR>") -- decrease height
u.map("n", "<leader>w+", ":resize +15<CR>") -- increase height

-- Git
u.map("n", "<F5>", ":lua require('utils.core')._lazygit_toggle()<CR>") -- lazygit
u.map("n", "<leader>gf", ":Telescope git_files<CR>") -- git files
u.map("n", "<leader>gc", ":Telescope git_commits<CR>") -- git commits
u.map("n", "<leader>gb", ":Telescope git_branches<CR>") -- git branches
u.map("n", "<leader>gs", ":Telescope git_status<CR>") -- git status
u.map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>") -- preview hunk
u.map("n", "<leader>gl", ":Gitsigns toggle_current_line_blame<CR>") -- toggle line blame
u.map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>") -- reset hunk
u.map("n", "<leader>gR", ":Gitsigns reset_buffer<CR>") -- reset buffer
u.map("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>") -- undo last stage hunk
u.map("n", "<leader>gI", ":Gitsigns reset_buffer_index<CR>") -- reset buffer index
u.map("n", "<leader>gt", ":Gitsigns stage_hunk<CR>") -- git stage hunk
u.map("n", "<leader>gT", ":Gitsigns stage_buffer<CR>") -- git stage buffer
u.map("n", "<leader>g[", ":Gitsigns prev_hunk<CR>") -- previous hunk
u.map("n", "<leader>g]", ":Gitsigns next_hunk<CR>") -- next hunk

-- Telescope
u.map("n", "<leader><space>", ":Telescope find_files<CR>")
u.map("n", "<leader>ff", ":Telescope find_files<CR>")
u.map("n", "<leader>fr", ":Telescope oldfiles<CR>")
u.map("n", "<leader>fg", ":Telescope live_grep<CR>")
u.map("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find<CR>")
u.map("n", "<leader>ft", ":Telescope colorscheme<CR>")
u.map("n", "<leader>fc", ":Telescope command_history<CR>")
u.map("n", "<leader>fs", ":Telescope search_history<CR>")
u.map("n", "<leader>fn", ":lua require('utils.core').search_nvim()<CR>")
