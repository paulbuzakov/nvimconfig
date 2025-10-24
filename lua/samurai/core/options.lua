vim.g.editorconfig = true
vim.opt.laststatus = 3

vim.filetype.add({ extension = { razor = "razor" } })
vim.treesitter.language.register("html", "razor")

vim.g.dotnet_errors_only = true
vim.g.dotnet_show_project_file = false
