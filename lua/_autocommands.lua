-- Example for a project-specific action
local group = vim.api.nvim_create_augroup("ProjectAutocommands", { clear = true })

local function gomod_path()
    local go_mod_path = vim.fn.findfile('go.mod', vim.fn.expand('%:p:h') .. ';')
    if go_mod_path == '' then
        return false
    end
    return vim.fn.fnamemodify(go_mod_path, ":h")
end

local function is_sqlc_project()
    local go_mod_path = vim.fn.findfile('go.mod', vim.fn.expand('%:p:h') .. ';')
    if go_mod_path == '' then
        return false
    end
    local project_root = vim.fn.fnamemodify(go_mod_path, ":h")
    local sqlc_config_path = project_root .. '/sqlc.yaml'
    return vim.fn.filereadable(sqlc_config_path) == 1
end

local function open_temporary_window_with_content(content_lines)
    -- Create a new buffer that's not listed and is disposable
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    -- Fill the buffer with your content
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content_lines)

    -- Determine the window size based on the content length
    local height = vim.o.lines
    local width = math.floor(vim.o.columns / 2)

    -- Create a floating window for this buffer
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor(vim.o.columns - width),
        row = 0,
        style = 'minimal',
        border = 'rounded',
    })

    -- Make the window's buffer content read-only
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)

    -- Optionally, set mappings to close the window easily, e.g., with 'q'
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', {
        noremap = true,
        silent = true,
        callback = function()
            vim.api.nvim_win_close(win, true)
        end,
    })
end

-- local debounce_timer = nil
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.go",
--     callback = function()
--         if debounce_timer then
--             vim.fn.timer_stop(debounce_timer)
--         end
--
--         debounce_timer = vim.fn.timer_start(500, function()
--             local path = vim.fn.expand("%:p")
--             if not string.match(path, "gearjot/go/.*/e2e") then
--                 return
--             end
--
--             local line_num = vim.api.nvim_win_get_cursor(0)[1]
--             local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--             local testName = nil
--
--             -- Search backwards for the test function name
--             for i = line_num, 1, -1 do
--                 if string.match(lines[i], "^func%s+(Test%w+)") then
--                     testName = string.match(lines[i], "^func%s+(Test%w+)")
--                     break
--                 end
--             end
--
--             if testName ~= "" then
--                 local cmd =
--                     "cd /Users/raimondaskazlauskas/Projects/gearjot && docker-compose exec -it testrunner gotestsum ./pkg/rest/app/e2e/... -- -run ^" ..
--                     testName
--                 local output = {}
--                 vim.fn.jobstart(cmd, {
--                     on_stdout = function(id, data, event)
--                         vim.list_extend(output, data)
--                     end,
--                     on_stderr = function(id, data, event)
--                         vim.list_extend(output, data)
--                     end,
--                     on_exit = function(id, exit_code, event)
--                         -- local bufnr = find_or_create_output_buffer()
--                         -- if exit_code == 0 then
--                         --     vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Test Passed: " .. testName, unpack(output) })
--                         -- else
--                         --     vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Test Failed: " .. testName, unpack(output) })
--                         -- end
--                         print("printing")
--                         print(id)
--                         open_temporary_window_with_content(output)
--                     end,
--                     stdout_buffered = true,
--                     stderr_buffered = true,
--                 })
--             end
--         end, { ["repeat"] = 1 })
--     end,
--     group = group,
-- })

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.go",
--     callback = function()
--         local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--         for _, line in ipairs(lines) do
--             if line:find("counterfeiter") then
--                 local file = vim.api.nvim_buf_get_name(0)
--                 vim.fn.jobstart({ "go", "generate", file }, { detach = true })
--                 return
--             end
--         end
--     end,
--     group = group,
-- })

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.yml",
    callback = function()
        local first_line = vim.fn.getline(1)
        if first_line:match("^openapi") then
            local filepath = vim.fn.expand('%:p')
            local output_dir = vim.fn.expand('%:p:h') .. "/../openapi"
            local command = string.format(
                "openapi-generator-cli generate -i %s -g go-server -o %s --additional-properties=onlyInterfaces=true,outputAsLibrary=true,router=chi",
                filepath, output_dir)
            vim.fn.system(command)
            vim.fn.system("gofmt -s -w " .. output_dir)
            vim.fn.system("goimports -w  " .. output_dir)
            vim.cmd("silent LspRestart gopls")
        end
    end,
    group = group,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.sql",
    callback = function()
        if is_sqlc_project() then
            local root_path = gomod_path()
            local output = vim.fn.system('docker run --rm -v ' .. root_path .. ':/src -w /src sqlc/sqlc:1.18.0 generate')
            if vim.v.shell_error ~= 0 then
                print(output)
            end

            vim.cmd("silent LspRestart gopls")
        end
    end,
    group = group,
})
