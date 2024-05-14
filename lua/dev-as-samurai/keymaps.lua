local M = { }

function M.setup()
  local vim = vim

  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Split current window
  map('n', 'ss', ':split<CR>', opts)
  map('n', 'sv', ':vsplit<CR>', opts)

  -- Change current window
  map('n', '<C-h>', '<C-w>h', opts)
  map('n', '<C-j>', '<C-w>j', opts)
  map('n', '<C-k>', '<C-w>k', opts)
  map('n', '<C-l>', '<C-w>l', opts)

  -- Create new, Go to the Next and Go to the Prev
  map('n', 'te', ':tabedit<CR>', opts)
  map('n', '<Tab>', ":tabnext<CR>", opts)
  map('n', '<S-Tab>', ":tabprevious<CR>", opts)

  --  Open/Close terminal modal
  map('n', '<A-d>', '<cmd>Lspsaga term_toggle')

  -- Open/Close solution explorer
  map('n', '<Leader>e', ':NvimTreeToggle<CR>', opts)

  --Telescope keymaps
  local builtin = require('telescope.builtin')
  map('n', 'ff', builtin.find_files)
  map('n', 'fg', builtin.live_grep)
  map('n', 'fb', builtin.buffers)
  map('n', 'fh', builtin.help_tags)
end

return M
