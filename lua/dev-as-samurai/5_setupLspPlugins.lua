local M = {}

function M.setup()
  require("mason").setup()
  require('mason-lspconfig').setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    },
    ensure_installed = {
      "eslint",
      "tsserver",
      "tailwindcss",
      "lua_ls",
    },
    automatic_installation = true,
  })

  local lspconfig = require('lspconfig')

  lspconfig.eslint.setup {}
  lspconfig.tsserver.setup {}
  lspconfig.tailwindcss.setup {}
  lspconfig.lua_ls.setup {}

  local null_ls = require("null-ls")

  -- code action sources
  local code_actions = null_ls.builtins.code_actions

  -- diagnostic sources
  local diagnostics = null_ls.builtins.diagnostics

  -- formatting sources
  local formatting = null_ls.builtins.formatting

  -- hover sources
  local hover = null_ls.builtins.hover

  -- completion sources
  local completion = null_ls.builtins.completion

  null_ls.setup({
    sources = {
      formatting.prettier,
      require("none-ls.code_actions.eslint"),
      require("none-ls.diagnostics.eslint"),
      formatting.stylua,
      hover.dictionary,
      completion.vsnip
    },
  })
end

return M
