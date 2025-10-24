local opt = vim.opt
local g = vim.g


-- ----------------------------
-- Disable netrw file explorer
-- ----------------------------
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- ----------------------------
-- UI & Display
-- ----------------------------
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true -- Highlight the current line
opt.signcolumn = "yes" -- Always show the sign column
opt.scrolloff = 8 -- Minimal number of screen lines above/below cursor
opt.colorcolumn = "80,120" -- Highlight column at 80 chars

-- ----------------------------
-- Indentation
-- ----------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Number of spaces to use for each indent
opt.tabstop = 4 -- Number of spaces a tab counts for
opt.smartindent = true -- Smart autoindenting
opt.autoindent = true -- Copy indent from current line when starting new one

-- ----------------------------
-- Search
-- ----------------------------
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there's a capital letter
opt.incsearch = true -- Show matches while typing
opt.hlsearch = true -- Highlight search matches

-- ----------------------------
-- Completion
-- ----------------------------
opt.completeopt = { "menu", "menuone", "noselect" } -- Completion menu behavior
opt.updatetime = 50 -- Faster completion and diagnostics

-- ----------------------------
-- No wrapping
-- ----------------------------
opt.wrap = false

-- ----------------------------
-- Splits
-- ----------------------------
opt.splitright = true -- Vertical splits to the right
opt.splitbelow = true -- Horizontal splits below

-- ----------------------------
-- Files & Encoding
-- ----------------------------
opt.encoding = "utf-8" -- Use UTF-8 by default
opt.fileencoding = "utf-8" -- File content encoding for the buffer
opt.swapfile = false -- Disable swap files
opt.backup = false -- Disable backup files
opt.undofile = true -- Enable persistent undo
opt.writebackup = false

-- ----------------------------
-- Clipboard
-- ----------------------------
opt.clipboard = "unnamedplus" -- Use system clipboard

-- ----------------------------
-- Mouse
-- ----------------------------
opt.mouse = "a" -- Enable mouse in all modes

-- ----------------------------
-- Folding
-- ----------------------------
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- ----------------------------
-- Performance
-- ----------------------------
-- opt.lazyredraw = true         -- Improve performance for macros
opt.timeoutlen = 400 -- Shorter time for mapped sequences
opt.ttimeoutlen = 0

-- ----------------------------
-- UI: Command line height
-- ----------------------------
opt.cmdheight = 1 -- Minimum space for command line

-- ----------------------------
-- Misc
-- ----------------------------
opt.termguicolors = true -- True color support
opt.isfname:append("@-@") -- Allow `@` in file names
opt.backspace = { "start", "eol", "indent" } -- Better backspace behavior

-- ----------------------------
-- Leader key
-- ----------------------------
g.mapleader = " " -- Set <leader> to space
g.maplocalleader = " "
