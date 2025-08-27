return {
	{
		"mfussenegger/nvim-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			vim.fn.setenv("DAP_LOG", "true")
			dap.set_log_level("TRACE")

			dapui.setup()

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

			-- local mason_path = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"
			local explicit_path = "/Users/paulbu/Documents/net_debugger/netcoredbg"
			local netcoredbg_adapter = {
				type = "executable",
				command = explicit_path,
				args = { "--interpreter=vscode" },
			}

			dap.adapters.netcoredbg = netcoredbg_adapter
			dap.adapters.coreclr = netcoredbg_adapter

			-- CodeLLDB adapter for C/C++
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			local dotnet = require("samurai.utils.dotnet")

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return dotnet.build_dll_path()
					end,
				},
				{
					type = "coreclr",
					name = "Debug Tests (Select Project)",
					request = "launch",
					program = "dotnet",
					args = function()
						local csproj = dotnet.build_and_get_test_project()
						return { "test", csproj, "--no-build" }
					end,
					cwd = function()
						local csproj = vim.g.dotnet_selected_test_csproj
						if csproj then return vim.fn.fnamemodify(csproj, ':p:h') end
						return vim.loop.cwd()
					end,
					console = "integratedTerminal",
				},
				{
					type = "coreclr",
					name = "Attach to Process (Pick)",
					request = "attach",
					processId = function()
						return require('dap.utils').pick_process()
					end,
				},
			}

			-- C/C++ configurations
			dap.configurations.c = {
				{
					name = "Launch (C)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},
				},
				{
					name = "Attach to process (C)",
					type = "codelldb",
					request = "attach",
					pid = require('dap.utils').pick_process,
					args = {},
				},
			}

			dap.configurations.cpp = dap.configurations.c
		end,
	},
}
