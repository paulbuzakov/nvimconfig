local M = {}

function M.setup()
    require("lazy").setup({
        { "folke/neodev.nvim" },
        { "folke/neoconf.nvim" },
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-lua/plenary.nvim" },
        { "MunifTanjim/nui.nvim" },
        { "nvim-neo-tree/neo-tree.nvim" },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
        },
        { "lewis6991/gitsigns.nvim" },
        { "echasnovski/mini.nvim" },
        { "echasnovski/mini.starter" },
        { "echasnovski/mini.trailspace" },
        { "echasnovski/mini.indentscope" },
        { "echasnovski/mini.cursorword" },
        { "echasnovski/mini.comment" },
        { "tpope/vim-surround" },
        { "folke/flash.nvim" },
        { "rcarriga/nvim-notify" },
        { "norcalli/nvim-colorizer.lua" },
        {
            "nvim-treesitter/nvim-treesitter",
            build = function()
                require("nvim-treesitter.install").update({ with_sync = true })()
            end,
        },
        { "folke/noice.nvim" },
        { "MunifTanjim/nui.nvim" },
        { "rcarriga/nvim-notify" },
        { "akinsho/bufferline.nvim" },
        { "nvim-lualine/lualine.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "folke/trouble.nvim" },
        { "neovim/nvim-lspconfig" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-vsnip" },
        { "hrsh7th/vim-vsnip" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
        { "nvimtools/none-ls.nvim" },
        { "nvimtools/none-ls-extras.nvim" },
        { "RishabhRD/popfix" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "j-hui/fidget.nvim" },
        { "paulbuzakov/auto-save.nvim" },

        -- 9_debuggings.lua
        { "mfussenegger/nvim-dap" },
        { "rcarriga/nvim-dap-ui" },
        { "nvim-neotest/nvim-nio" },

        { -- The task runner we use
            "stevearc/overseer.nvim",
            commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
            cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
            opts = {
                task_list = {
                    direction = "bottom",
                    min_height = 25,
                    max_height = 25,
                    default_detail = 1,
                },
            },
        },

        -- AI plugins
        { "ibhagwan/fzf-lua" },
        {
            "frankroeder/parrot.nvim",
            config = function()
                require("parrot").setup({
                    providers = {
                        -- anthropic = {
                        --     api_key = os.getenv("ANTHROPIC_API_KEY"),
                        -- },
                        openai = {
                            api_key = os.getenv("OPENAI_API_KEY"),
                        },
                        -- github = {
                        --     api_key = os.getenv("GITHUB_TOKEN"),
                        -- },
                    },
                })
            end,
        },
    })
end

return M
