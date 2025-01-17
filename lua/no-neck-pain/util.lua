local options = require("no-neck-pain.config").options
local M = {}

-- print only if debug is true
function M.print(...)
    if options.debug then
        print("[" .. os.time() .. "] --> ", ...)
    end
end

-- print table only if debug is true
function M.tprint(table, indent)
    if not options.debug then
        return
    end

    if not indent then
        indent = 0
    end

    for k, v in pairs(table) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            M.tprint(v, indent + 1)
        elseif type(v) == "boolean" then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

-- returns size of a map
function M.tsize(map)
    local count = 0

    for _ in pairs(map) do
        count = count + 1
    end

    return count
end

function M.isRelativeWindow(scope, win)
    win = win or vim.api.nvim_get_current_win()

    if
        vim.api.nvim_win_get_config(0).relative ~= ""
        or vim.api.nvim_win_get_config(win).relative ~= ""
    then
        M.print(scope, "float window detected")

        return true
    end
end

return M
