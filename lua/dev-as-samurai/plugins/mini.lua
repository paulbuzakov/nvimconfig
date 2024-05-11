return {
  {
    'echasnovski/mini.nvim',
    event = "VeryLazy",
    version = false
  },
  {
    'echasnovski/mini.starter',
    event = "VimEnter",
    version = false,
    opts = {
      header = "Good morning, samurai"
    },
    config = function(_, opts)
      require('mini.starter').setup(opts)
    end
  },
  {
    'echasnovski/mini.completion',
    event = 'VeryLazy',
    version = false,
    opts = { },
    config = function(_, opts)
      require('mini.completion').setup(opts)
    end
  },
  {
    'echasnovski/mini.trailspace',
    event = "VeryLazy",
    version = false,
    opts = { },
    config = function(_, opts)
      require('mini.trailspace').setup(opts)
    end
  },
  {
    'echasnovski/mini.indentscope',
    event ="VeryLazy",
    version = false,
    opts = { },
    config = function(_, opts)
      require('mini.indentscope').setup(opts)
    end
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    version = false,
    opts = { },
    config = function(_, opts)
      require('mini.pairs').setup(opts)
    end
  },
  {
    'echasnovski/mini.notify',
    event = "VeryLazy",
    version = false,
    opts = { },
    config = function(_, opts)
      require('mini.notify').setup(opts)
    end
  },
  {
    'echasnovski/mini.cursorword',
    event = 'VeryLazy',
    version = false,
    opts = { },
    config = function(_, opts)
      require('mini.cursorword').setup(opts)
    end
  },
  {
    'echasnovski/mini.comment',
    event = "VeryLazy",
    version = false,
    opts = {
      mappings = {
        comment = 'gc',
        comment_line = 'gcc',
        comment_visual = 'gc',
        textobject = 'gc',
      },
      hooks = {
        pre = function() end,
        post = function() end,
      },
    },
    config = function(_, opts)
      require('mini.comment').setup(opts)
    end
  },
}