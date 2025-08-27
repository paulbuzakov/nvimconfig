return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"c_sharp",
				"json",
				"html",
                "hcl",
                "terraform",
				"css",
				"javascript",
				"typescript",
				"rust",
				"sql",
				"dockerfile",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			auto_install = true,
		})
	end,
}
