local M = {}

function M.setup()
  local vim = vim
  local map = vim.keymap.set

  map('n', '<Leader>e', vim.diagnostic.open_float)
  map('n', '<C-j>', vim.diagnostic.goto_next)
  map('n', '<Leader>q', vim.diagnostic.setloclist)

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      local opts = { buffer = ev.buf }
      local builtin = require('telescope.builtin')

      -- map('n', '<leader>gD', builtin.declaration, opts)
      map('n', 'gr', builtin.lsp_references, opts)
      map('n', 'gd', builtin.lsp_definitions, opts)
      map('n', 'gD', builtin.diagnostics)
      map('n', 'gi', builtin.lsp_implementations, opts)
      map('n', 'rn', vim.lsp.buf.rename, opts)
      map({ 'n', 'v' }, 'ca', vim.lsp.buf.code_action, opts)
      map('n', 'cf', function()
        vim.lsp.buf.format { async = true }
      end, opts)

      -- map('n', 'K', ':Lspsaga hover_doc<CR>', opts)
      -- map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      -- map('i', '<C-k>', vim.lsp.buf.signature_help, opts)
      -- map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      -- map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      -- map('n', '<space>wl', function()
      --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- end, opts)
    end,
  })
end

return M
