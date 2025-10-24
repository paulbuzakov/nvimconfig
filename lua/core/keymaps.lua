local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ""
-- --------------------------------

-- --------------------------------
-- General
-- --------------------------------
map("n", "<Esc>", "<cmd>nohlsearch<cr>", opts) -- Clear search highlight

-- --------------------------------
-- Buffer Navigation
-- --------------------------------
map("n", "<leader>bn", "<cmd>bnext<cr>", opts)
map("n", "<leader>bb", "<cmd>bprevious<cr>", opts)
map("n", "<leader>bd", "<cmd>bdelete<cr>", opts) -- Close current buffer

-- --------------------------------
-- Move Lines Left / Right (Visual Mode)
-- --------------------------------
map("v", "<Tab>", ">gv", opts)
map("v", "<S-Tab>", "<gv", opts)

-- --------------------------------
-- Move Lines Up / Down (Visual Mode)
-- --------------------------------
map("v", "<s-up>", ":m '<-2<CR>gv=gv", opts) -- Move line up
map("v", "<s-down>", ":m '>+1<CR>gv=gv", opts) -- Move line down
