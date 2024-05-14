local M = { }

function M.setup()
  local vim = vim

  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  vim.opt.termguicolors = true

  require("nvim-tree").setup({
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })


  require("tokyonight").setup({
    style = "moon",
    light_style = "day",
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "transparent",
      floats = "transparent",
    },
    sidebars = { "qf", "help" },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,
  })

  vim.cmd.colorscheme("tokyonight-moon")


  require("gitsigns").setup( {
    current_line_blame = true
  })


  require('mini.starter').setup({
    header = "Good morning, samurai"
  })
  require('mini.trailspace').setup()
  require('mini.pairs').setup()
  require('mini.indentscope').setup()
  require('mini.cursorword').setup()
  require('mini.comment').setup({
    mappings = {
      comment = 'gc',
      comment_line = 'gcc',
      comment_visual = 'gc',
      textobject = 'gc',
    }
  })


  require("notify").setup({
    render = "wrapped-compact",
    stages = "slide",
  })

  vim.notify = require("notify")


  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "lua", "vim", "vimdoc",
      "c_sharp",
      "html", "css", "scss", "styled", "javascript", "tsx", "typescript",
      "json", "json5", "xml",
      "markdown",
      "git_rebase", "gitcommit", "gitignore",
      "sql"
    },
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })


  require("trouble").setup()


  require("telescope").setup()


  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-s>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig').lua_ls.setup {
    capabilities = capabilities
  }

end

return M
