if vim.fn.has("nvim-0.12") == 0 then
	vim.api.nvim_err_writeln("This config requires Neovim >= 0.12")
	return
end

if vim.loader and vim.loader.enable then
	vim.loader.enable()
end

require("core")
require("samurai-way")
