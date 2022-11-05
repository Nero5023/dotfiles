
local actions = require "telescope.actions"
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.close,
            },
            n = {
                ["<C-j>"] = actions.close,
            },
        }
    }
}