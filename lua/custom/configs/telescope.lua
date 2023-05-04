local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "build",
      "android",
      "ios",
      "package-lock.json",
      "yarn.lock",
      "*.png",
      "*.svg",
    },
    mappings = {
      i = {
        -- press ; to close popup
        [";"] = actions.close,
      },
    },
  },
}
