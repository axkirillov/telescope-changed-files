# telescope-changed-files
Telescope picker to browse files that changed between your branch and develop

# install
```
-- add this to your init.lua
require('packer').startup(function(use)
	use { "axkirillov/telescope-changed-files" }
end)

require('telescope').load_extension('changed_files')
```
