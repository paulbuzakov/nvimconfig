return {
  {
    "lewis6991/gitsigns.nvim",
    version = false,
    event = "VeryLazy",
    opts = {
      current_line_blame = true
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end
  }
}
