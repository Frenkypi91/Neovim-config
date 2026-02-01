------------------------------------------------------------
-- Alias
------------------------------------------------------------
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

------------------------------------------------------------
-- Leader
------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------------------------------------------------------
-- Basic navigation
------------------------------------------------------------

-- Save / Quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>Q", ":qa!<CR>", opts)

-- Avoid ESC
keymap("i", "jk", "<Esc>", opts)

-- Make long lines more readable
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

------------------------------------------------------------
-- Buffers and windows
------------------------------------------------------------

-- Buffers
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
keymap("n", "<leader>bl", ":ls<CR>", opts)

-- Splits
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>sc", ":close<CR>", opts)

-- Split navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

------------------------------------------------------------
-- Search and text
------------------------------------------------------------

-- Clear highlight
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Visual search without losing selection
keymap("v", "//", 'y/\\V<C-R>"<CR>', opts)

-- Move lines up/down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

------------------------------------------------------------
-- Clipboard
------------------------------------------------------------

-- Copy/paste using system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', opts)
keymap("n", "<leader>p", '"+p', opts)

------------------------------------------------------------
-- Terminal
------------------------------------------------------------

keymap("n", "<leader>tt", ":terminal<CR>", opts)
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

------------------------------------------------------------
-- Files and project
------------------------------------------------------------

-- File explorer (netrw or nvim-tree)
keymap("n", "<leader>e", ":Ex<CR>", opts)

-- Reload config
keymap("n", "<leader>r", ":source $MYVIMRC<CR>", opts)

------------------------------------------------------------
-- LSP
------------------------------------------------------------

keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "<leader>f", function()
vim.lsp.buf.format { async = true }
end, opts)

------------------------------------------------------------
-- Diagnostics
------------------------------------------------------------

keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>d", vim.diagnostic.open_float, opts)

------------------------------------------------------------
-- PDF / LaTeX
------------------------------------------------------------

-- Open PDF with Zathura (if a PDF with the same name exists)
keymap("n", "<leader>pdf", ":!zathura %:r.pdf &<CR>", opts)

------------------------------------------------------------
-- Quality of life
------------------------------------------------------------

-- Keep cursor centered
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Centered search
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
