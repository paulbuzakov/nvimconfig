local CPP = {}

function CPP.get_dap_adapter(codelldb)
	codelldb = codelldb or {}

	local local_path = codelldb.local_path
	local mason_path = codelldb.mason_path

	if local_path or mason_path then
		return {
			type = "executable",
			command = local_path or mason_path,
		}
	else
		vim.notify("codelldb not found. Please install it via Mason or provide a local path.", vim.log.levels.WARN)
	end

	return nil
end

function CPP.get_dap_configurations()
	return {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = true,
		},
	}
end

return CPP
