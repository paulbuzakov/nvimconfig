local M = { }

function M.setup()
  local opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    },
    ensure_installed = {
      "stylua",
      "prettierd",
      "eslint_d",
      "csharpier",
      "lua-language-server",
      "powershell-editor-services",
      "omnisharp",
      "csharp-language-server",
      "netcoredbg",
      "typescript-language-server",
      "cspell",
    }
  }
  require("mason").setup(opts)
  local mr = require("mason-registry")

  local function ensure_installed()
    for _, tool in ipairs(opts.ensure_installed) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end

  if mr.refresh then
    mr.refresh(ensure_installed)
  else
    ensure_installed()
  end


  require("mason-lspconfig").setup()

  require("lspconfig").lua_ls.setup{}


  require("lspsaga").setup({ })


  local null_ls = require("null-ls")
  local cspell = require('cspell')

  null_ls.setup({
    sources = {
      cspell.diagnostics,
      cspell.code_actions,
    }
  })

end

return M
