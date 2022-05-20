# telescope-changed-files
Telescope picker to browse files that changed between your branch and develop

underneath the picker just runs this git command

```
git diff --name-only $(git merge-base HEAD develop) 
```

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
