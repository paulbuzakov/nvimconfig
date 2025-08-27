return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
        -- vim.lsp.set_log_level("debug")

		-- Virtual text and other diagnostics settings
		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = false,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		vim.lsp.enable("lua_ls")
		-- vim.lsp.enable("csharp_ls")
		vim.lsp.enable("omnisharp")
		vim.lsp.enable("clangd")

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
				},
			},
		})

		vim.lsp.config("clangd", {
			cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			root_dir = function(fname)
				return require("lspconfig.util").root_pattern(
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git"
				)(fname)
			end,
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
		})
	end,
}
