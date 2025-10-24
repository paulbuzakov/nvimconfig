local DOTNET = {}

DOTNET._current_launch = {
	project_root = nil,
	dll = nil,
	env = nil,
	args = nil,
}

----------------------------------------------------------------------------------------------------------------
-- PUBLIC DOTNET.get_dap_adapter(netcoredbg)
----------------------------------------------------------------------------------------------------------------
function DOTNET.get_dap_adapter(netcoredbg)
	netcoredbg = netcoredbg or {}

	local local_path = netcoredbg.local_path
	local mason_path = netcoredbg.mason_path

	if local_path or mason_path then
		return {
			type = "executable",
			command = local_path or mason_path,
			args = { "--interpreter=vscode" },
		}
	else
		vim.notify(
			"netcoredbg not found. Install via Mason (:Mason -> netcoredbg) or set local path.",
			vim.log.levels.ERROR
		)
	end

	return nil
end

----------------------------------------------------------------------------------------------------------------
-- PUBLIC DOTNET.get_dap_configurations()
----------------------------------------------------------------------------------------------------------------
function DOTNET.get_dap_configurations()
	return {
		{
			type = "coreclr",
			name = "launch - netcoredbg",
			request = "launch",
			program = function()
				return DOTNET._try_get_dll_path()
			end,
			args = function()
				return DOTNET._try_get_args()
			end,
			env = function()
				return DOTNET._try_get_env()
			end,
			cwd = function()
				return DOTNET._try_get_cwd()
			end,
		},
	}
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._try_get_dll_path()
----------------------------------------------------------------------------------------------------------------
function DOTNET._try_get_dll_path()
	DOTNET._debug()

	if not DOTNET._current_launch or not DOTNET._current_launch.dll then
		vim.notify("Could not resolve .NET DLL to debug", vim.log.levels.ERROR)
		return nil
	end

	return DOTNET._current_launch.dll
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._try_get_args()
----------------------------------------------------------------------------------------------------------------
function DOTNET._try_get_args()
	if not DOTNET._current_launch or DOTNET._current_launch.args == nil then
		return {}
	end

	vim.notify("Using args: " .. vim.inspect(DOTNET._current_launch.args), vim.log.levels.WARN)

	return DOTNET._current_launch.args or {}
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._try_get_env()
----------------------------------------------------------------------------------------------------------------
function DOTNET._try_get_env()
	if not DOTNET._current_launch or DOTNET._current_launch.env == nil then
		return {}
	end

	vim.notify("Using env: " .. vim.inspect(DOTNET._current_launch.env), vim.log.levels.WARN)

	return DOTNET._current_launch.env or {}
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._try_get_cwd()
----------------------------------------------------------------------------------------------------------------
function DOTNET._try_get_cwd()
	if not DOTNET._current_launch or not DOTNET._current_launch.project_root then
		return vim.fn.getcwd()
	end

	return DOTNET._current_launch.project_root
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._debug()
----------------------------------------------------------------------------------------------------------------
function DOTNET._debug()
	DOTNET._current_launch = {
		project_root = nil,
		dll = nil,
		env = nil,
		args = nil,
	}

	local all_projects = DOTNET._find_all_projects()
	if #all_projects == 0 then
		vim.notify("No .csproj files found under working directory", vim.log.levels.ERROR)
		return nil
	end

	local selected_project = DOTNET._select_project(all_projects)
	if not selected_project or selected_project == "" then
		vim.notify("No project selected, aborting", vim.log.levels.ERROR)
		return nil
	end

	if DOTNET._build(selected_project) == 0 then
		vim.notify("Build failed, aborting debug session", vim.log.levels.ERROR)
		return nil
	end

	local dll = DOTNET._get_dll_path(selected_project)
	if not dll or dll == "" then
		return nil
	end

	local project_root = vim.fn.fnamemodify(selected_project, ":p:h")
	if not project_root or project_root == "" then
		vim.notify("Could not determine project root", vim.log.levels.ERROR)
		return nil
	end

	local profile = DOTNET._select_profile(project_root)

	DOTNET._current_launch = {
		project_root = project_root,
		dll = dll,
		env = profile and profile.env or {},
		args = profile and profile.args or {},
	}

	return nil
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._find_all_projects()
----------------------------------------------------------------------------------------------------------------
function DOTNET._find_all_projects()
	local cwd = vim.fn.getcwd()
	local results = vim.fn.globpath(cwd, "**/*.csproj", true, true) or {}

	for i, p in ipairs(results) do
		results[i] = vim.fn.fnamemodify(p, ":p")
	end

	return results
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._select_project()
----------------------------------------------------------------------------------------------------------------
function DOTNET._select_project(all_projects)
	local cwd = vim.fn.getcwd()
	cwd = cwd:sub(-1) == "/" and cwd or (cwd .. "/")

	local items = {}
	local projects = all_projects or {}
	for _, project in ipairs(projects) do
		table.insert(items, vim.fn.fnamemodify(project, ":t:r"))
	end

	local idx = DOTNET._select_index(items, "Select .NET project:")
	vim.notify("Selected index: " .. tostring(idx), vim.log.levels.INFO)

	if idx and idx >= 1 and idx <= #all_projects then
		local choice = all_projects[idx]
		vim.notify("Selected project: " .. choice, vim.log.levels.INFO)
		return choice
	end

	return nil
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._select_index()
----------------------------------------------------------------------------------------------------------------
function DOTNET._select_index(items, prompt)
	local co = coroutine.running()
	local menu_ui = require("nui.menu")

	local menu_items = {}
	for i, menu_item in ipairs(items) do
		table.insert(menu_items, menu_ui.item(menu_item, { index = i }))
	end

	local menu = menu_ui({
		position = "50%",
		size = {
			width = 70,
			height = #items + 1,
		},
		border = {
			style = "single",
			text = {
				top = prompt,
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = menu_items,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function()
			print("CLOSED")
		end,
		on_submit = function(item)
			coroutine.resume(co, item.index)
		end,
	})

	menu:mount()

	return coroutine.yield()
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._build()
----------------------------------------------------------------------------------------------------------------
function DOTNET._build(csproj)
	if not csproj or csproj == "" then
		return 0
	end
	local build_cmd = { "dotnet", "build", csproj, "-c", "Debug" }
	vim.notify("Building .NET project (Debug): " .. csproj, vim.log.levels.WARN)

	-- Use list form to avoid shell-escaping issues
	local output = vim.fn.system(build_cmd)
	if output and #output > 0 then
		-- Show errors in messages, info otherwise
		local level = vim.v.shell_error ~= 0 and vim.log.levels.ERROR or vim.log.levels.INFO
		vim.notify(output, level)
	end

	if vim.v.shell_error ~= 0 then
		return 0
	end

	return 1
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._get_dll_path()
----------------------------------------------------------------------------------------------------------------
function DOTNET._get_dll_path(selected_csproj)
	local project_root = vim.fn.fnamemodify(selected_csproj, ":p:h")
	vim.notify("Project root: " .. project_root, vim.log.levels.WARN)

	local project_name = vim.fn.fnamemodify(selected_csproj, ":t:r")
	local bin_cfg_path = project_root .. "/bin/Debug"

	local pattern = "**/" .. project_name .. ".dll"
	local candidates = vim.fn.globpath(bin_cfg_path, pattern, true, true) or {}
	if #candidates == 0 then
		vim.notify("No build output DLLs found in " .. bin_cfg_path, vim.log.levels.ERROR)
		return nil
	end

	-- Pick the newest DLL by modification time
	table.sort(candidates, function(a, b)
		local ta = vim.fn.getftime(a) or 0
		local tb = vim.fn.getftime(b) or 0
		return ta > tb
	end)

	local dll_path = candidates[1]
	vim.notify("Launching DLL: " .. dll_path, vim.log.levels.INFO)
	return dll_path
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._select_profile(project_root)
----------------------------------------------------------------------------------------------------------------
function DOTNET._select_profile(project_root)
	local launch = DOTNET._parse_launch_settings(project_root)
	local profiles = launch and launch.profiles or nil

	if type(profiles) ~= "table" or DOTNET._is_table_empty(profiles) then
		vim.notify("No launch profiles found (" .. project_root .. ")", vim.log.levels.INFO)
		return { project_root = project_root, name = nil, env = {}, args = {} }
	end

	local names = {}
	for name, _ in pairs(profiles) do
		table.insert(names, name)
	end

	local idx = DOTNET._select_index(names, "Select launch profile:")
	local chosen_name = idx and names[idx] or nil

	if not chosen_name then
		vim.notify("No profile selected", vim.log.levels.WARN)
		return { project_root = project_root, name = nil, env = {}, args = {} }
	end

	local p = profiles[chosen_name] or {}
	local env = {}
	if type(p.environmentVariables) == "table" then
		for k, v in pairs(p.environmentVariables) do
			env[k] = v
		end
	end

	if type(p.applicationUrl) == "string" and (env.ASPNETCORE_URLS == nil or env.ASPNETCORE_URLS == "") then
		env.ASPNETCORE_URLS = p.applicationUrl
	end

	local args = {}
	if type(p.commandLineArgs) == "string" then
		args = DOTNET._split_cmdline(p.commandLineArgs)
	end

	vim.notify("Selected profile: " .. chosen_name, vim.log.levels.INFO)

	return {
		project_root = project_root,
		name = chosen_name,
		env = env,
		args = args,
	}
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._read_launch_settings(project_root)
----------------------------------------------------------------------------------------------------------------
function DOTNET._parse_launch_settings(project_root)
	local path = project_root .. "/Properties/launchSettings.json"
	if vim.fn.filereadable(path) ~= 1 then
		return nil
	end
	local ok, content = pcall(vim.fn.readfile, path)
	if not ok or not content then
		return nil
	end
	local json = table.concat(content, "\n")
	local decoded
	if vim.json and vim.json.decode then
		local okj, res = pcall(vim.json.decode, json)
		if okj then
			decoded = res
		end
	else
		local okj, res = pcall(vim.fn.json_decode, json)
		if okj then
			decoded = res
		end
	end
	return decoded
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._is_table_empty(t)
----------------------------------------------------------------------------------------------------------------
function DOTNET._is_table_empty(t)
	if type(t) ~= "table" then
		return true
	end
	return next(t) == nil
end

function DOTNET.get_highest_net_folder(bin_debug_path)
	-- Kept for backward compatibility; now unused by default.
	local dirs = vim.fn.glob(bin_debug_path .. "/net*", false, true)
	if type(dirs) ~= "table" or #dirs == 0 then
		vim.notify("No net* folders found in " .. bin_debug_path, vim.log.levels.WARN)
		return nil
	end

	local function parse_ver(path)
		-- Extract something like net8.0 or net48 -> {major, minor}
		local m1, m2 = path:match("net(%d+)%.?(%d*)")
		local major = tonumber(m1) or 0
		local minor = tonumber(m2) or 0
		return major, minor
	end

	table.sort(dirs, function(a, b)
		local amaj, amin = parse_ver(a)
		local bmaj, bmin = parse_ver(b)
		if amaj == bmaj then
			return amin > bmin
		end
		return amaj > bmaj
	end)

	return dirs[1]
end

----------------------------------------------------------------------------------------------------------------
-- PRIVATE DOTNET._split_cmdline()
----------------------------------------------------------------------------------------------------------------
function DOTNET._split_cmdline(str)
	if type(str) ~= "string" or str == "" then
		return {}
	end

	local args, current, in_quote = {}, "", false
	local i, n = 1, #str

	while i <= n do
		local c = str:sub(i, i)
		if c == '"' then
			in_quote = not in_quote
		elseif c == " " and not in_quote then
			if #current > 0 then
				table.insert(args, current)
				current = ""
			end
		else
			current = current .. c
		end
		i = i + 1
	end

	if #current > 0 then
		table.insert(args, current)
	end

	return args
end

return DOTNET
