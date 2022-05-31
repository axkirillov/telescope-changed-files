local has_telescope, telescope = pcall(require, 'telescope')
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local builtin = require("telescope.builtin")
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

if not has_telescope then
  error('This plugin requires nvim-telescope/telescope.nvim')
end

M = {}

M.changed_files = function(opts)
	local base_branch = vim.g.telescope_changed_files_base_branch or "develop"
	local command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )"
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

M.choose_base_branch = function(opts)
  opts = opts or {}
  builtin.git_branches({
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
		vim.g.telescope_changed_files_base_branch = selection.value
		M.base_branch = selection.value
      end)
      return true
    end,
  })
end

return telescope.register_extension {
	exports = {
		changed_files = M.changed_files,
		choose_base_branch = M.choose_base_branch
	},
}
