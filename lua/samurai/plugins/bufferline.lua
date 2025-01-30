return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local bufferline = require("bufferline")

            bufferline.setup({
                options = {
                    mode = "buffers",
                    style_preset = bufferline.style_preset.no_italic,
                },
            })
        end,
    },
}
