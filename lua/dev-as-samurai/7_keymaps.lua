local M = {}

function M.setup()
	local vim = vim
	local map = vim.keymap.set
	local opts = { noremap = true, silent = true }

	vim.o.timeout = true
	vim.o.timeoutlen = 300

	--Telescope keymaps
	local builtin = require("telescope.builtin")

	-- Work with files and buffers
	map("n", "fb", builtin.buffers, opts)
	map("n", "ff", builtin.find_files, opts)
	map("n", "fg", builtin.live_grep, opts)
	map("n", "fr", builtin.oldfiles, opts)

	-- Split pane
	map("n", "ss", ":split<CR>", opts)
	map("n", "sv", ":vsplit<CR>", opts)

	-- Deselect search words
	map("n", "<Esc>", ":nohlsearch<CR>")

	-- Change current window
	map("n", "<C-h>", "<C-w>h", opts)
	map("n", "<C-j>", "<C-w>j", opts)
	map("n", "<C-k>", "<C-w>k", opts)
	map("n", "<C-l>", "<C-w>l", opts)

	-- Create new, Go to the Next and Go to the Prev
	map("n", "te", ":tabedit<CR>", opts)
	map("n", "<Tab>", ":tabnext<CR>", opts)
	map("n", "<S-Tab>", ":tabprevious<CR>", opts)
end

return M
