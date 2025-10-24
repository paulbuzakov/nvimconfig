return {
	"rcarriga/nvim-notify",
	opts = {
		timeout = 3000,
	},
	config = function(_, opts)
		require("notify").setup(opts)
		vim.notify = require("notify")
	end,
}
