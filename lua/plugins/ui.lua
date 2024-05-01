return {
  { "folke/flash.nvim", enabled = false },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = { enabled = false }
    end,
  },
}
