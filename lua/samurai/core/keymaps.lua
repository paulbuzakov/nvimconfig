local map = vim.keymap.set
local fzf = require("fzf-lua")
local opts = { noremap = true, silent = true }

-----------------------
-- Trim whitespaces
-----------------------
map("n", "<leader>cw", function()
	require("mini.trailspace").trim()
end, opts)

-----------------------
-- Inc Rename
-----------------------
map("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-----------------------
-- Find files & buffers
-----------------------
map("n", "<leader>ff", function()
	fzf.files()
end, opts)
map("n", "<leader>fb", function()
	fzf.buffers()
end, opts)
map("n", "<leader>fg", function()
	fzf.live_grep()
end, opts)

-----------------------
-- Git
-----------------------
map("n", "<leader>lg", "<cmd>LazyGit<cr>", opts)
map("n", "<leader>gl", "<cmd>LazyGitLog<cr>", opts)

-----------------------
-- LSP
-----------------------
map("n", "<leader>lr", function()
	fzf.lsp_references()
end, opts)
map("n", "<leader>ld", function()
	fzf.lsp_definitions()
end, opts)
map("n", "<leader>lD", function()
	fzf.lsp_declarations()
end, opts)
map("n", "<leader>lt", function()
	fzf.lsp_typedefs()
end, opts)
map("n", "<leader>li", function()
	fzf.lsp_implementations()
end, opts)
map("n", "<leader>ca", function()
	fzf.lsp_code_actions()
end, opts)
map("n", "<leader>lh", function()
	fzf.lsp_document_symbols()
end, opts)
map("n", "<leader>lH", function()
	fzf.lsp_workspace_symbols()
end, opts)

map("n", "<leader>le", function()
	fzf.lsp_workspace_diagnostics()
end, opts)

-----------------------
-- Formatting
-----------------------
map("n", "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, opts)

-----------------------
-- Save and Format
-----------------------
map("n", "<C-s>", function()
	vim.cmd("w")
end, opts)

-----------------------
-- Debugging
-----------------------
local dap = require("dap")

-- Debugger control
vim.keymap.set("n", "<F5>", dap.continue, opts) -- ▶ Start/Continue
vim.keymap.set("n", "<F10>", dap.step_over, opts) -- ⏭ Step Over
vim.keymap.set("n", "<F11>", dap.step_into, opts) -- ⏬ Step Into
vim.keymap.set("n", "<F12>", dap.step_out, opts) -- ⏮ Step Out
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<F4>", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", opts)

-- Restart and terminate
vim.keymap.set("n", "<Leader>dr", dap.restart, opts)
vim.keymap.set("n", "<Leader>dq", dap.terminate, opts)
