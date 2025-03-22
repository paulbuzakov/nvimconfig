return {
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                enabled = false,
            },
            explorer = {
                enabled = false,
            },
            picker = {
                enabled = false,
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        opts = {
            window = {
                position = "float",
            },
        },
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
                end,
                desc = "Explorer NeoTree (Root Dir)",
            },
        },
    },
}
