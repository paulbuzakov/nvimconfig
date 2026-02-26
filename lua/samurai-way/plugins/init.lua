local p = function(package)
    return "samurai-way.plugins." .. package
end

require(p("neo-tree"))
require(p("catppuccin"))
require(p("lualine"))
require(p("incline"))
require(p("telescope"))
require(p("lazygit"))