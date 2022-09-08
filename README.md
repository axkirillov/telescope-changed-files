## BEFORE YOU PROCEED
# check out [easypick.nvim](https://github.com/axkirillov/easypick.nvim) the changed files functionality is included in its default config

# telescope-changed-files
Telescope picker to browse files that changed between your branch and develop.

Underneath the picker just runs this git command:

```
git diff --name-only $(git merge-base HEAD base_branch) 
```
The base_branch defaults to "develop" but you can change it to be any branch you want (see #use section).

# install
Add this to your init.lua:
```
require('packer').startup(function(use)
	use { "axkirillov/telescope-changed-files" }
end)

require('telescope').load_extension('changed_files')
```
# use
Now you should have the `changed_files` picker available in telescope.
You can then map it to whatever key you like.
```
map <leader>cf :Telescope changed_files <cr>
```

To change the base_branch run `:Telescope changed_files choose_base_branch`.
This will open a builtin git branches picker. The branch you pick will then be saved for the duration of your vim session.

Alternatively you can just set it using this global var:

```
vim.g.telescope_changed_files_base_branch = your_branch
```

Put it somewhere in your project specific config.
