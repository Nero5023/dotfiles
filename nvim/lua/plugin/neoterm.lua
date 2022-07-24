-- README:
-- Usage:
-- command
-- :SetTaskCommand
-- setting the cmd in `stored_task_command`
-- :TaskPersist
-- run cmd in `stored_task_command`, if not exit show nui input box to input


vim.g.neoterm_size = tostring(0.3 * vim.o.columns)
vim.g.neoterm_default_mod = 'botright vertical'

vim.api.nvim_set_keymap("n", "<leader>ps", ":SetTaskCommand<CR>",{})
vim.api.nvim_set_keymap("n", "<leader>pr", ":TaskPersist<CR>",{})

local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local stored_task_command = nil

-- show nui input box to input command in `stored_task_command`
local trigger_set_command_input = function(callback_fn)
    local input_component = Input({
        position = "50%",
        size = {
            width = 50
        },
        border = {
            style = "single",
            text = {
                top = "Commmand to run:",
                top_align = "center"
            }
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal"
        }
    }, {
        prompt = "> ",
        default_value = "",
        on_submit = function(value)
            stored_task_command = value
            callback_fn();
        end
    })

    input_component:mount()
    input_component:on(event.BufLeave, function()
        input_component:unmount()
    end)
end

-- set task command
vim.api.nvim_create_user_command('SetTaskCommand', function()
    trigger_set_command_input(function()
        -- Don't need to do anything here beyond set it
    end)
end, {})

-- run cmd `stored_task_command`, if not set, then use nui input box to input
vim.api.nvim_create_user_command('TaskPersist', function(input)
    local execute = function(cmd)
        -- clean input and then run command
        vim.api.nvim_command(":1Tclear")
        vim.api.nvim_command(":1T " .. cmd)
    end

    -- run 
    -- :TaskPersist cmd_to_run
    -- it will not reset the stored_task_command
    local one_off_command = input.args

    if one_off_command and string.len(one_off_command) > 0 then
        execute(one_off_command)
    elseif stored_task_command == nil then
        trigger_set_command_input(function()
            execute(stored_task_command)
        end)
    else
        execute(stored_task_command)
    end
end, {
    nargs = '*'
})
