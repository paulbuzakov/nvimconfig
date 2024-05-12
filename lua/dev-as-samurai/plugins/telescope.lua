return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    version = false,
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require('telescope').setup(opts)
    end
  }
}
