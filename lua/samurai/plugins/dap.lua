return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"williamboman/mason.nvim",
			"rcarriga/nvim-dap-ui",
		},
		event = "VeryLazy",
		config = function()
			local dap = require("dap")

			local cpp = require("samurai.utils.cpp")
			dap.adapters.codelldb = cpp.get_dap_adapter({
				local_path = nil,
				mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
			})
			dap.configurations.cpp = cpp.get_dap_configurations()

			local dotnet = require("samurai.utils.dotnet")
			local netcoredbg = dotnet.get_dap_adapter({
				local_path = "/usr/local/netcoredbg",
				mason_path = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
			})

			dap.adapters.netcoredbg = netcoredbg
			dap.adapters.coreclr = netcoredbg
			dap.configurations.cs = dotnet.get_dap_configurations()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		opts = {
			ui = {},
			virtual_text_opts = {
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = true,
				show_stop_reason = true,
				commented = false,
				only_first_definition = true,
				all_references = false,
				filter_references_pattern = "<module",
			},
		},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_virtual_text = require("nvim-dap-virtual-text")

			dapui.setup(opts.ui)
			dap_virtual_text.setup(opts.virtual_text_opts)

			vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "󰳟 ", texthl = "", linehl = "", numhl = "" })

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
	{
		"nvim-neotest/neotest",
		commit = "52fca6717ef972113ddd6ca223e30ad0abb2800c",
		dependencies = {
			"Issafalcon/neotest-dotnet",
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local neotest = require("neotest")
			local dotnet = require("neotest-dotnet")

			neotest.setup({
				status = {
					virtual_text = true,
				},
				adapters = {
					dotnet({
						dap = {
							args = { justMyCode = false },
							adapter_name = "netcoredbg",
						},
						custom_attributes = {
							xunit = { "MyCustomFactAttribute" },
							nunit = { "MyCustomTestAttribute" },
							mstest = { "MyCustomTestMethodAttribute" },
						},
						dotnet_additional_args = {
							"--verbosity detailed",
						},
						discovery_root = "project",
					}),
				},
			})
		end,
	},
}
