local M = {}

local git_config = require("packages.git")
local git_prefix = "^(https?://|ssh://|git@)"

local function prepend_git_prefix(spec)
	if type(spec) == "string" then
		if not spec:match(git_prefix) then

			return string.format(git_config.url_format, spec)
		end
	elseif type(spec) == "table" then
		if vim.isarray(spec) then
			return vim.tbl_map(
				prepend_git_prefix, spec
			)
		end

		if spec.src == nil or type(spec.src) ~= "string" then
			error("Expected either array or spec.src to be string")
		end

		spec.src = prepend_git_prefix(spec.src)

		return spec
	end
end

M.add = function(spec, opts)
	spec = prepend_git_prefix(spec)

	if not vim.isarray(spec) then
		spec = { spec }
	end

	vim.pack.add(spec, opts)
end

local plugins_augroup = vim.api.nvim_create_augroup("plugins", { clear = true })

M.run_on_event = function(event_types, command_data)
	local cmd_config = { group = plugins_augroup }
	for k, v in pairs(command_data) do
		cmd_config[k] = v
	end

	vim.api.nvim_create_autocmd(event_types, cmd_config )
end

return M
