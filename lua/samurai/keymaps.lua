local vim = vim
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Split pane
map("n", "ss", ":split<CR>", opts)
map("n", "sv", ":vsplit<CR>", opts)

-- Deselect search words
map("n", "<Esc>", ":nohlsearch<CR>")

-- Change current window
map("n", "<c-h>", "<c-w>h", opts)
map("n", "<c-j>", "<c-w>j", opts)
map("n", "<c-k>", "<c-w>k", opts)
map("n", "<c-l>", "<c-w>l", opts)

-- Create new, Go to the Next and Go to the Prev
map("n", "te", ":tabedit<CR>", opts)
map("n", "<Tab>", ":tabnext<CR>", opts)
map("n", "<S-Tab>", ":tabprevious<CR>", opts)

local fzf = require("fzf-lua")

-- Work with files and buffers
map("n", "fb", fzf.buffers, opts)
map("n", "ff", fzf.files, opts)
map("n", "fg", fzf.live_grep, opts)
map("n", "FF", "<Cmd>Neotree toggle<CR>", opts)
map("n", "S", "<Cmd>wa<CR>", opts)

-- Work with LSP
map("n", "gr", fzf.lsp_references)
map("n", "gd", fzf.lsp_definitions)
map("n", "gD", fzf.diagnostics_workspace)
map("n", "gi", fzf.lsp_implementations)
map("n", "rn", vim.lsp.buf.rename)
map({ "n", "v" }, "ca", fzf.lsp_code_actions)
map({ "n", "i" }, "gk", vim.lsp.buf.signature_help)
map("n", "gh", vim.lsp.buf.hover)
