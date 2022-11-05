
local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local nnoremap = bind("n")

nnoremap("<leader>t", function() require("harpoon.mark").add_file() end,{})
nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end,{})

 nnoremap("<leader>1", function() require("harpoon.ui").nav_file(1) end, {})
 nnoremap("<leader>2", function() require("harpoon.ui").nav_file(2) end, {})
 nnoremap("<leader>3", function() require("harpoon.ui").nav_file(3) end, {})
 nnoremap("<leader>4", function() require("harpoon.ui").nav_file(4) end, {})
-- leader 1 navigage 1
-- leader 2 navigage 2
-- leader 3 navigage 3
-- leader 4 navigage 4
