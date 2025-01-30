return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = {
            ensure_installed = {
                "eslint",
                "ts_ls",
                "tailwindcss",
                "lua_ls",
                "csharp_ls",
            },
            automatic_installation = true,
        },
        config = function(_, opts)
            require("mason").setup()
            require("mason-lspconfig").setup(opts)
            local lspconfig = require("lspconfig")

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            lspconfig.eslint.setup({ capabilities = capabilities })
            lspconfig.ts_ls.setup({ capabilities = capabilities })
            lspconfig.tailwindcss.setup({ capabilities = capabilities })
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.csharp_ls.setup({ capabilities = capabilities })
        end,
    },
}
