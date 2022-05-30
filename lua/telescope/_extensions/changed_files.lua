local has_telescope, telescope = pcall(require, 'telescope')
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

if not has_telescope then
  error('This plugin requires nvim-telescope/telescope.nvim')
end

M = {}

M.changed_files = function(opts)
	local command = "git diff --name-only $(git merge-base HEAD develop)"
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()

	local files = {}
	for token in string.gmatch(result, "[^%s]+") do
	   table.insert(files, token)
	end

	opts = opts or {}

	pickers.new(opts, {
		prompt_title = "changed files",
		finder = finders.new_table {
			results = files
		},
		sorter = conf.generic_sorter(opts),
	}):find()
end

return telescope.register_extension {
	exports = {
		changed_files = M.changed_files
	},
}
