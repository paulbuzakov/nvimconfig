# Neovim Configuration

This is my personal Neovim configuration, built with a focus on productivity and modern development workflows.

## Features

- 🎨 Modern and clean UI with custom colorscheme
- 📁 File explorer with Neo-tree
- 🔍 Powerful fuzzy finding with Telescope
- ⌨️ Efficient keymaps for navigation and editing
- 🚀 Fast startup with lazy.nvim package manager

## Requirements

- Neovim >= 0.8.0
- Git
- A Nerd Font (for icons)

## Installation

1. Clone this repository:
```bash
git clone https://github.com/paulbuzakov/nvimconfig.git ~/.config/nvim
```

2. Start Neovim and wait for the plugins to install:
```bash
nvim
```

## Keymaps

### General
- `gcc` - Comment/Uncomment current line
- `n` - Next searched word
- `N` - Previous searched word

### Window Management
- `<Ctrl> + h` - Switch to the Left window
- `<Ctrl> + j` - Switch to the Down window
- `<Ctrl> + k` - Switch to the Up window
- `<Ctrl> + l` - Switch to the Right window

### Neo-tree (File Explorer)
- `<Leader> + e` - Open/Close file explorer

### Telescope (Fuzzy Finder)
- `<Leader> + ff` - Find files
- `<Leader> + fg` - Live grep (search in files)
- `<Leader> + fb` - Open buffers

## Plugins

### Core Plugins
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - File explorer
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder

### UI/UX
- Custom colorscheme configuration

## Customization

The configuration is organized in the following structure:
```
~/.config/nvim/
├── init.lua           # Main entry point
├── lazy-lock.json     # Plugin versions lock file
├── lua/
│   ├── config/       # Core configuration
│   └── plugins/      # Plugin configurations
└── README.md         # This file
```

## Contributing

Feel free to submit issues and enhancement requests!
