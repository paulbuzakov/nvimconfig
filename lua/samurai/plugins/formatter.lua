return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			markdown = { "prettier" },
			cs = { "csharpier" },
			sln = { "xmlformat" },
			slnx = { "xmlformat" },
			csproj = { "xmlformat" },
			xml = { "xmlformat" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			objc = { "clang-format" },
			objcpp = { "clang-format" },
			json = { "fixjson" },
		},
		formatters = {
			csharpier = {
				command = "csharpier",
				args = {
					"format",
					"--write-stdout",
				},
				to_stdin = true,
			},
			prettier = {
				command = "prettier",
				args = {
					"--stdin-filepath",
					vim.api.nvim_buf_get_name(0),
				},
				stdin = true,
			},
			xmlformat = {
				command = "xmlformat",
				args = {
					"-",
				},
				stdin = true,
			},
			["clang-format"] = {
				command = "clang-format",
				args = {
					"-style",
					"Google", -- You can change this to your preferred style
				},
				stdin = true,
			},
		},
	},
}
