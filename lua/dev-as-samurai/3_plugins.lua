local M = {}

function M.setup()
	require("lazy").setup({
		{ "folke/neodev.nvim" },
		{ "folke/neoconf.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
		{ "folke/which-key.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "MunifTanjim/nui.nvim" },
		{ "nvim-neo-tree/neo-tree.nvim" },
		{ "folke/tokyonight.nvim" },
		{ "lewis6991/gitsigns.nvim" },
		{ "echasnovski/mini.nvim" },
		{ "echasnovski/mini.starter" },
		{ "echasnovski/mini.trailspace" },
		{ "echasnovski/mini.indentscope" },
		{ "echasnovski/mini.cursorword" },
		{ "echasnovski/mini.comment" },
		{ "tpope/vim-surround" },
		{ "folke/flash.nvim" },
		{ "rcarriga/nvim-notify" },
		{
			"nvim-treesitter/nvim-treesitter",
			build = function()
				require("nvim-treesitter.install").update({ with_sync = true })()
			end,
		},
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = {
				-- add any options here
			},
			dependencies = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
		},
		{ "akinsho/bufferline.nvim" },
		{ "nvim-lualine/lualine.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "folke/trouble.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-vsnip" },
		{ "hrsh7th/vim-vsnip" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "nvimtools/none-ls.nvim" },
		{ "nvimtools/none-ls-extras.nvim" },
		{ "RishabhRD/popfix" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "j-hui/fidget.nvim" },
		{ "Pocco81/auto-save.nvim" },
	})
end

return M
