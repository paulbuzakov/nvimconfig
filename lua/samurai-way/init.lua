local gh = function(url)
    return "https://github.com/" .. url
end

vim.pack.add({
    { src = gh('nvim-neo-tree/neo-tree.nvim') },
    { src = gh('nvim-lua/plenary.nvim') },
    { src = gh('nvim-tree/nvim-web-devicons') },
    { src = gh('MunifTanjim/nui.nvim') },
    { src = gh('catppuccin/nvim') },
    { src = gh('nvim-lualine/lualine.nvim') },
    { src = gh('b0o/incline.nvim') },
    { src = gh('SmiteshP/nvim-navic') },
    { src = gh('nvim-telescope/telescope.nvim') },
    { src = gh('nvim-telescope/telescope-fzf-native.nvim'), build = 'make' },
    { src = gh('kdheepak/lazygit.nvim') },

    -- LSP Configurations
    { src = gh('neovim/nvim-lspconfig') },
})

require('samurai-way.plugins')
require('samurai-way.keymaps')
