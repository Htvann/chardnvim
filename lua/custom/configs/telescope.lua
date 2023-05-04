-- Load extension
require("telescope").load_extension "file_browser"
require('telescope').load_extension('media_files')
-- keymap
local actions = require('telescope.actions')
require("telescope").load_extension "file_browser"
require("telescope").setup {
  defaults = {
    file_ignore_patterns = { "node_modules", "build", "android", "ios", "package-lock.json", "yarn.lock", "*.png",
      "*.svg" },
    mappings = {
      i = {
        -- press ; to close popup
        [";"] = actions.close
      }
    }
  },
}
    mappings = {
      i = {
        -- press ; to close popup
        [";"] = actions.close,
      },
    },
  },
}
