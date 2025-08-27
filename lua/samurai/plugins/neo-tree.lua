return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	cmd = "Neotree",
	opts = {
		window = {
			position = "float",
		},
		filesystem = {
			filtered_items = {
				hide_by_name = {
					"node_modules",
				},
				always_show_by_pattern = { -- uses glob style patterns
					--".env*",
				},
				never_show = {
					".DS_Store",
					"thumbs.db",
				},
			},
		},
	},
	keys = {
		{
			"<leader>fe",
			"<cmd>Neotree toggle<cr>",
			desc = "Show File Explorer",
		},
	},
}
