-- Autocommands for Samurai Neovim configuration
-- Adds autosave and auto-format on leaving Insert mode.

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
