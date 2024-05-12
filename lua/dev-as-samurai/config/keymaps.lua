local map = vim.keymap.set
local opts = { noremap = true, silent = true }


-- Open/Close solution explorer
map('n', '<Leader>e', ':NvimTreeToggle<CR>', opts)

--Telescope keymaps
local builtin = require('telescope.builtin')
map('n', 'ff', builtin.find_files)
map('n', 'fg', builtin.live_grep)
map('n', 'fb', builtin.buffers)
map('n', 'fh', builtin.help_tags)
