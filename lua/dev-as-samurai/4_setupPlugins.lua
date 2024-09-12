local M = {}

function M.setup()
  local vim = vim

  require("neodev").setup({
    library = {
      plugins = { "nvim-dap-ui" },
      types = true,
    },
  })

  require("neoconf").setup({})

  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  vim.opt.termguicolors = true

  -- If you want icons for diagnostic errors, you'll need to define them somewhere:
  vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

  require("neo-tree").setup({})
  vim.cmd([[nnoremap \ :Neotree reveal<cr>]])

  -- -- require("solarized-osaka").setup({})
  -- vim.cmd.colorscheme("solarized-osaka")

  require("catppuccin").setup({
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
  })
  vim.cmd.colorscheme("catppuccin")

  require("gitsigns").setup({
    current_line_blame = true,
  })

  require("mini.starter").setup({
    header = "Good morning, samurai",
  })
  require("mini.trailspace").setup()
  require("mini.indentscope").setup()
  require("mini.cursorword").setup()
  require("mini.comment").setup({
    mappings = {
      comment = "gc",
      comment_line = "gcc",
      comment_visual = "gc",
      textobject = "gc",
    },
  })

  require("flash").setup({})

  local notify = require("notify")
  notify.setup({
    background_colour = "#888888",
  })
  vim.notify = notify

  require("nvim-treesitter.configs").setup({
    ensure_installed = { "json", "lua", "css", "scss", "typescript", "html", "tsx", "c_sharp" },
    sync_install = true,
    auto_install = true,
    ignore_install = { "javascript" },
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
  })

  require("trouble").setup()

  require("bufferline").setup({
    options = {
      mode = "buffers",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
    },
  })
  require("lualine").setup()

  require("telescope").setup({
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
  })

  require("telescope").load_extension("ui-select")

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local cmp = require("cmp")
  cmp.setup({
    enabled = true,
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
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
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
      { name = "vsnip" }, -- For ultisnips users.
      { name = "nvim_lsp" },
    }, {
      { name = "buffer" },
    }),
  })
  --
  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  --
  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  require("colorizer").setup()
end

return M
