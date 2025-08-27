return {
	{
		"saghen/blink.cmp",
		build = "cargo build --release",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"fang2hou/blink-copilot",
		},
		version = "1.*",
		opts = {
			keymap = {
				preset = "enter",
			},
			appearance = {
				nerd_font_variant = "normal",
			},
			completion = {
				documentation = {
					auto_show = false,
					window = {
						border = "single",
					},
				},
				menu = {
					border = "single",
				},
			},
			signature = {
				window = {
					border = "single",
				},
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"copilot",
				},
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		},
		opts_extend = {
			"sources.default",
		},
	},
}
