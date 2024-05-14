local M = {}

function M.setup()
  local vim = vim

  require("neodev").setup({})
  require("neoconf").setup({})

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


  require("gitsigns").setup({
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

  require("flash").setup({})

  require("notify").setup({
    render = "wrapped-compact",
    stages = "slide",
  })
  vim.notify = require("notify")


  require("toggleterm").setup({
    direction = 'float',
  })


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

  require("bufferline").setup {
    options = {
      mode = 'buffers',
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        }
      },
    },
  }
  require('lualine').setup()

  require("telescope").setup()

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local cmp = require('cmp')
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
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
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),   -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      -- Super-Tab like mappings
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#vim-vsnip
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()       -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),

    }),
    sources = cmp.config.sources({
      { name = 'vsnip' },   -- For ultisnips users.
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })
  --
  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
  --
  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
end

return M
