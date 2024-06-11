local M = {}

function M.init()
  -- Setup common options
  require('dev-as-samurai.options').setup()

  -- Setup lazy.nvim plugin manager
  require('dev-as-samurai.lazy').setup()

  require('dev-as-samurai.autocmd').setup()
  require('dev-as-samurai.keymaps').setup()
  require('dev-as-samurai.lspKeymaps').setup()
end

return M
