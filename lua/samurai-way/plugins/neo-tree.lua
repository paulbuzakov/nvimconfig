require("neo-tree").setup({
    window = {
        position = "float",
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
        },
    },
})