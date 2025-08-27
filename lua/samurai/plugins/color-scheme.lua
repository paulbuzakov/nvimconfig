return {
	{
		"olivercederborg/poimandres.nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		config = function()
			require("poimandres").setup({
				disable_italics = true,
			})
		end,
		init = function()
			vim.cmd("colorscheme poimandres")
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				no_italic = true,
			})

			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "storm",
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					functions = { italic = false },
					variables = { italic = false },
				},
			})

			vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				contrast = "hard",
				overrides = {},
				transparent_mode = true,
			})

			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		enabled = true,
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "medium",
				transparent_background_level = 0.5,
				disable_italic_comments = true,
			})

			vim.cmd("colorscheme everforest")
		end,
	},
}
