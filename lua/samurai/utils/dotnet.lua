local M = {}

-- Find the root directory of a .NET project by searching for .csproj files
function M.find_project_root_by_csproj(start_path)
	local Path = require("plenary.path")
	local path = Path:new(start_path)

	while true do
		local csproj_files = vim.fn.glob(path:absolute() .. "/*.csproj", false, true)
		if #csproj_files > 0 then
			return path:absolute()
		end

		local parent = path:parent()
		if parent:absolute() == path:absolute() then
			return nil
		end

		path = parent
	end
end

-- Find the highest version of the netX.Y folder within a given path.
function M.get_highest_net_folder(bin_debug_path)
	local dirs = vim.fn.glob(bin_debug_path .. "/net*", false, true) -- Get all folders starting with 'net' in bin_debug_path

	if dirs == 0 then
		error("No netX.Y folders found in " .. bin_debug_path)
	end

	table.sort(dirs, function(a, b) -- Sort the directories based on their version numbers
		local ver_a = tonumber(a:match("net(%d+)%.%d+"))
		local ver_b = tonumber(b:match("net(%d+)%.%d+"))
		return ver_a > ver_b
	end)

	return dirs[1]
end

-- Prompt user to select a .csproj when multiple exist
function M.select_project(project_root, csproj_files)
	-- If a previously selected project is stored and still exists, reuse it
	local stored = vim.g.dotnet_selected_csproj
	if stored and vim.loop.fs_stat(stored) then
		return stored
	end

	if #csproj_files == 1 then
		vim.g.dotnet_selected_csproj = csproj_files[1]
		return csproj_files[1]
	end

	-- Use vim.ui.select for better UX if available
	local choice
	local display = {}
	for _, p in ipairs(csproj_files) do
		table.insert(display, vim.fn.fnamemodify(p, ":t"))
	end

	local co = coroutine.running()
	if co then
		vim.ui.select(display, { prompt = "Select .NET project:" }, function(item)
			if item then
				for i, d in ipairs(display) do
					if d == item then
						choice = csproj_files[i]
						break
					end
				end
			end
			coroutine.resume(co)
		end)
		coroutine.yield()
	else
		-- Fallback synchronous selection via inputlist
		local lines = { "Select .NET project:" }
		for i, d in ipairs(display) do
			lines[#lines + 1] = string.format("%d. %s", i, d)
		end
		local idx = vim.fn.inputlist(lines)
		if idx >= 1 and idx <= #csproj_files then
			choice = csproj_files[idx]
		end
	end

	if not choice then
		error("No project selected")
	end

	vim.g.dotnet_selected_csproj = choice
	return choice
end

-- Recursively gather all .csproj files under current working directory
function M.find_all_csproj_in_cwd(max_depth)
	local cwd = vim.fn.getcwd()
	local scandir = require('plenary.scandir')
	local depth = max_depth or 10
	local results = scandir.scan_dir(cwd, {
		respect_gitignore = true,
		add_dirs = false,
		depth = depth,
		search_pattern = '.*%.csproj$'
	})
	return results
end

-- User command to (re)select project from all csproj under CWD
vim.api.nvim_create_user_command("DotnetSelectProject", function(opts)
	local list = M.find_all_csproj_in_cwd()
	if #list == 0 then
		vim.notify("No .csproj files found under CWD", vim.log.levels.ERROR)
		return
	end
	vim.g.dotnet_selected_csproj = nil -- clear previous selection
	local selected = M.select_project(nil, list)
	vim.notify("Selected project: " .. vim.fn.fnamemodify(selected, ":t"), vim.log.levels.INFO)
end, { desc = "Select .NET project (searches recursively from CWD)" })

-- Build and return the full path to the .dll file for debugging.
function M.build_dll_path()
	-- If a previously selected project exists and is valid, use it
	local cached = vim.g.dotnet_selected_csproj
	local csproj
	if cached and vim.loop.fs_stat(cached) then
		csproj = cached
	else
		-- Collect all csproj files under CWD
		local all = M.find_all_csproj_in_cwd()
		if #all == 0 then
			error("No .csproj files found under working directory")
		end
		csproj = M.select_project(nil, all)
	end

	-- Resolve project root from selected csproj path
	local project_root = vim.fn.fnamemodify(csproj, ':p:h')

	-- Build configuration (allow override via global variable)
	local build_config = vim.g.dotnet_build_config or "Debug"

	-- Execute build synchronously so the DLL exists before debugging
	local build_cmd = { "dotnet", "build", csproj, "-c", build_config }
	vim.notify("Building .NET project (" .. build_config .. "): " .. csproj, vim.log.levels.INFO)
	local output = vim.fn.system(table.concat(build_cmd, " "))
	if vim.v.shell_error ~= 0 then
		vim.notify(output, vim.log.levels.ERROR)
		error("dotnet build failed (see message above)")
	end

	-- Derive DLL path
	local project_name = vim.fn.fnamemodify(csproj, ":t:r")
	local bin_cfg_path = project_root .. "/bin/" .. build_config
	local highest_net_folder = M.get_highest_net_folder(bin_cfg_path)
	local dll_path = highest_net_folder .. "/" .. project_name .. ".dll"

	vim.notify("Launching DLL: " .. dll_path, vim.log.levels.INFO)
	return dll_path
end

return M
