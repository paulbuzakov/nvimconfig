local M = { }

function M.setup()
  local vim = vim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  end

  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

  require("lazy").setup("dev-as-samurai.plugins")

  require("dev-as-samurai.setupPlugins").setup()
  require("dev-as-samurai.setupLspPlugins").setup()
end

return M
