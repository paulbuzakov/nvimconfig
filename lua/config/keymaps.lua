-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymaps = vim.keymap
local opts = { noremap = true, silent = true }

-- Tabs
keymaps.set("n", "te", ":tabedit")
keymaps.set("n", "<tab>", ":tabnext<Return>", opts)
keymaps.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Select all
keymaps.set("n", "<C-a>", "ggVG")

-- Split windows
keymaps.set("n", "ss", ":split<Return>", opts)
keymaps.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymaps.set("n", "sh", "<c-w>h")
keymaps.set("n", "sj", "<c-w>j")
keymaps.set("n", "sk", "<c-w>k")
keymaps.set("n", "sl", "<c-w>l")

-- Resize window
keymaps.set("n", "<c-w><left>", "<c-w><")
keymaps.set("n", "<c-w><right>", "<c-w>>")
keymaps.set("n", "<c-w><up>", "<c-w>+")
keymaps.set("n", "<c-w><down>", "<c-w>-")

-- Diagnostics
keymaps.set("n", "<c-j>", function()
  vim.diagnostic.goto_next()
end, opts)
