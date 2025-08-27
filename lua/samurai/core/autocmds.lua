-- Autocommands for Samurai Neovim configuration
-- Adds autosave and auto-format on leaving Insert mode.

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("SamuraiAutoFormatSave", { clear = true })

-- Helper to decide whether we should attempt format & save
local function should_format_save(buf)
	if vim.api.nvim_buf_get_option(buf, "buftype") ~= "" then
		return false
	end -- skip special buffers
	if not vim.api.nvim_buf_get_option(buf, "modifiable") then
		return false
	end
	if vim.api.nvim_buf_get_option(buf, "readonly") then
		return false
	end
	if vim.api.nvim_buf_get_name(buf) == "" then
		return false
	end -- unnamed buffer
	return true
end

autocmd("InsertLeave", {
	group = group,
	callback = function(args)
		local buf = args.buf
		if not should_format_save(buf) then
			return
		end

		-- Only act if buffer changed since last write
		if not vim.api.nvim_buf_get_option(buf, "modified") then
			return
		end

		-- Try formatting (synchronous so that changes are included in write)
		local ok, conform = pcall(require, "conform")
		if ok then
			-- Protect against formatter errors
			local ok_format, err = pcall(function()
				conform.format({ async = false, lsp_fallback = true, bufnr = buf })
			end)
			if not ok_format and err then
				vim.notify("Format failed: " .. err, vim.log.levels.WARN)
			end
		end

		-- Write buffer silently (only if still modified)
		if vim.api.nvim_buf_get_option(buf, "modified") then
			vim.cmd("silent write")
			vim.notify("Auto-saved " .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t"), vim.log.levels.INFO)
		end
	end,
	desc = "Auto format & save on leaving Insert mode",
})
