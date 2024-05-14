return {
  { "folke/neodev.nvim" },

  { "nvim-tree/nvim-web-devicons" },
  { "nvim-tree/nvim-tree.lua" },

  { "folke/tokyonight.nvim" },

  { "lewis6991/gitsigns.nvim" },

  { "echasnovski/mini.nvim" },
  { "echasnovski/mini.starter" },
  { "echasnovski/mini.trailspace" },
  { "echasnovski/mini.pairs" },
  { "echasnovski/mini.indentscope" },
  { "echasnovski/mini.cursorword" },
  { "echasnovski/mini.comment" },

  { "rcarriga/nvim-notify" },

  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
         require("nvim-treesitter.install").update({ with_sync = true })()
    end,
  },

  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim' },
  { 'folke/trouble.nvim' },

  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },

  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/vim-vsnip' },

  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "nvimdev/lspsaga.nvim" },

  { "davidmh/cspell.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
}
