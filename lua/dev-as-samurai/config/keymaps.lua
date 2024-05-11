local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<Leader>e', ':NvimTreeToggle<CR>', opts)
