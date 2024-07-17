local M = {}

function M.init()
	-- Setup common options
	require("dev-as-samurai.1_options").setup()

	-- Setup lazy.nvim plugin manager
	require("dev-as-samurai.2_lazy").setup()

	-- Setup lazyvim's plugins
	require("dev-as-samurai.3_plugins").setup()
	require("dev-as-samurai.4_setupPlugins").setup()
	require("dev-as-samurai.5_setupLspPlugins").setup()

	-- Setup autocommands
	require("dev-as-samurai.6_autocmd").setup()

	-- Setup keymaps
	require("dev-as-samurai.7_keymaps").setup()
	require("dev-as-samurai.8_lspKeymaps").setup()
end

return M
