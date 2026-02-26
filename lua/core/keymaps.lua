local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- --------------------------------
-- General
-- --------------------------------
map("n", "<Esc>", "<cmd>nohlsearch<cr>", opts) -- Clear search highlight

-- --------------------------------
-- Buffer Navigation
-- --------------------------------
map("n", "<leader>bd", "<cmd>bdelete<cr>", opts) -- Close current buffer

-- --------------------------------
-- Plugin Management (vim.pack)
-- --------------------------------
map("n", "<leader>pl", "<cmd>PackStatus<cr>", opts) -- Open plugin status buffer
map("n", "<leader>ps", "<cmd>PackSync<cr>", opts) -- Update all plugins immediately
map("n", "<leader>pu", "<cmd>PackUpdate<cr>", opts) -- Review and update plugins
map("n", "<leader>pc", "<cmd>PackClean<cr>", opts) -- Remove inactive plugins

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
