local M = {}

function M.setup()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
    ensure_installed = {
      "eslint",
      "ts_ls",
      "tailwindcss",
      "lua_ls",
      "csharp_ls",
    },
    automatic_installation = true,
  })

  local lspconfig = require("lspconfig")

  lspconfig.eslint.setup({})
  lspconfig.ts_ls.setup({})
  lspconfig.tailwindcss.setup({})
  lspconfig.lua_ls.setup({})
  lspconfig.csharp_ls.setup({})

  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.completion.vsnip,
      null_ls.builtins.code_actions.refactoring,
      require("none-ls.diagnostics.eslint_d"),
      require("none-ls.code_actions.eslint_d"),
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.csharpier,
    },
  })

  require("auto-save").setup({})
end

return M
