local M = {}

function M.setup()
  local map = vim.keymap.set
  local builtin = require("telescope.builtin")
  local buf = vim.lsp.buf

  map("n", "gr", builtin.lsp_references)
  map("n", "gd", builtin.lsp_definitions)
  map("n", "gD", builtin.diagnostics)
  map("n", "gi", builtin.lsp_implementations)
  map("n", "rn", buf.rename)
  map({ "n", "v" }, "ca", buf.code_action)
  map("n", "cf", buf.format)
  map({ "n", "i" }, "gk", buf.signature_help)
  map("n", "gh", vim.lsp.buf.hover)
end

return M
