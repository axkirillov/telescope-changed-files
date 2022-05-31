# telescope-changed-files
Telescope picker to browse files that changed between your branch and develop

underneath the picker just runs this git command

```
git diff --name-only $(git merge-base HEAD base_branch) 
```
the base_branch defaults to "develop" but you can change it to be any branch you want (see #usage section)

# install
add this to your init.lua
```
require('packer').startup(function(use)
	use { "axkirillov/telescope-changed-files" }
end)

require('telescope').load_extension('changed_files')
```
this adds a changed_files picker to telescope
you can then map this to whatever key you like
```
map <leader>cf :Telescope changed_files <cr>
```

to change the base_branch run `:Telescope changed_files choose_base_branch`
which will open a builtin git branches picker
the branch will then be saved for the duration of your vim session

alternatively you can jsut set it using this global var

```
vim.g.telescope_changed_files_base_branch = your_branch
```

put it somewhere in your project specific config
