return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "VeryLazy" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "c_sharp",
        "html", "css", "scss", "styled", "javascript", "tsx", "typescript",
        "json", "json5", "xml",
        "markdown",
        "git_rebase", "gitcommit", "gitignore",
        "sql"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function (_, opts)
      local configs = require("nvim-treesitter.configs").setup(opts)
    end
  }
}
