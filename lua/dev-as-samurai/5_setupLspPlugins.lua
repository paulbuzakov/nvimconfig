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
			"tsserver",
			"tailwindcss",
			"lua_ls",
			"csharp_ls",
		},
		automatic_installation = true,
	})

	local lspconfig = require("lspconfig")

	lspconfig.eslint.setup({})
	lspconfig.tsserver.setup({})
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

	require("auto-save").setup({
		debounce_delay = 1000,
		callbacks = {
			before_saving = function()
				print("format")
				vim.lsp.buf.format({})
			end,
		},
	})
end

return M
