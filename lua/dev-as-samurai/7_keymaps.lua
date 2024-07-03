local M = {}

function M.setup()
  local vim = vim
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  vim.o.timeout = true
  vim.o.timeoutlen = 300

  local wk = require("which-key")
  wk.setup()

  --Telescope keymaps
  local builtin = require('telescope.builtin')
  wk.register({
    f = {
      name = "file",
      f = { function() builtin.find_files() end, "Find File" },
      r = { function() builtin.oldfiles() end, "Open Recent File" },
      g = { function() builtin.live_grep() end, "Live Grep" },
      b = { function() builtin.buffers() end, "Buffers" }
    },
    s = {
      name = "Split window",
      s = { ":split<CR>", "Split window" },
      v = { ":vsplit<CR>", "Vertical split window" },
    }
  }, { prefix = "<leader>" })

  -- Save and Save All
  map('n', '<C-s>', ':wa<CR>', opts)

  -- Deselect search words
  map('n', '<Esc>', ':nohlsearch<CR>')

  -- Change current window
  map('n', '<C-h>', '<C-w>h', opts)
  map('n', '<C-j>', '<C-w>j', opts)
  map('n', '<C-k>', '<C-w>k', opts)
  map('n', '<C-l>', '<C-w>l', opts)

  -- Create new, Go to the Next and Go to the Prev
  map('n', 'te', ':tabedit<CR>', opts)
  map('n', '<Tab>', ":tabnext<CR>", opts)
  map('n', '<S-Tab>', ":tabprevious<CR>", opts)
end

return M
