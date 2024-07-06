local M = {}

function M.setup()
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = "*.*",
    callback = function()
      vim.cmd("lua vim.lsp.buf.format()")
      vim.cmd("update")
    end,
  })
end

return M
