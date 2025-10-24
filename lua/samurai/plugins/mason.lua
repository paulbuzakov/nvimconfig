return {
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			automatic_enable = false,
			ensure_installed = {
				"lua_ls",
				"clangd",
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"csharpier",
				"prettier",
				"xmlformatter",
				"stylua",
				-- "netcoredbg",
				"roslyn",
				"clang-format",
				"codelldb",
				"fixjson",
			},
		},
	},
}
