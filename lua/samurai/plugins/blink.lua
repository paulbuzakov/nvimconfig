return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"Kaiser-Yang/blink-cmp-avante",
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
					"avante",
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
				providers = {
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {
							-- options for blink-cmp-avante
						},
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
