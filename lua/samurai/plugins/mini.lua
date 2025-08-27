return {
	{
		"echasnovski/mini.nvim",
		version = "*",
	},
	{
		"echasnovski/mini.trailspace",
		version = "*",
		config = function()
			require("mini.trailspace").setup({
				only_in_normal_buffers = false,
			})
		end,
	},
}
