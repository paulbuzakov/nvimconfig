local M = {}

function M.setup()
  local vim = vim
  local map = vim.keymap.set

  map('n', '<space>e', vim.diagnostic.open_float)
  map('n', '<C-j>', vim.diagnostic.goto_next)
  map('n', '<space>q', vim.diagnostic.setloclist)

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      local opts = { buffer = ev.buf }

      map('n', 'gD', vim.lsp.buf.declaration, opts)
      map('n', 'gd', vim.lsp.buf.definition, opts)
      map('n', 'K', vim.lsp.buf.hover, opts)
      map('n', 'gi', vim.lsp.buf.implementation, opts)
      map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      map('i', '<C-k>', vim.lsp.buf.signature_help, opts)
      map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      map('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      map('n', '<space>D', vim.lsp.buf.type_definition, opts)
      map('n', '<space>rn', vim.lsp.buf.rename, opts)
      map({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      map('n', 'gr', vim.lsp.buf.references, opts)
      map('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })
end

return M
