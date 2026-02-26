local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- NEO-TREE
map('n', '<leader>fe', '<cmd>Neotree toggle<cr>', opts)

-- TELESCOPE
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)

-- LAZYGIT
map('n', '<leader>lg', '<cmd>LazyGit<cr>', opts)
