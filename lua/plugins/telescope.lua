local M = {
    "nvim-telescope/telescope.nvim",
}

M.dependencies = {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    },
    "nvim-lua/plenary.nvim",
    "sharkdp/fd",
    "BurntSushi/ripgrep",
    "nvim-telescope/telescope-live-grep-args.nvim",
}

M.config = function()
    local ok, telescope = pcall(require, "telescope")
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"

    if not ok then
        return
    end

    telescope.setup({
        defaults = {
            path_display = { "smart" },
            vimgrep_arguments = {
                "rg",
                "--with-filename",
                "--no-heading",
                "--line-number",
                "--column",
                "--smart-case",
            },
        },
        pickers = {
            find_files = {
                hidden = true,
                -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                on_input_filter_cb = function(prompt)
                    local find_colon = string.find(prompt, ":")
                    if find_colon then
                        local ret = string.sub(prompt, 1, find_colon - 1)
                        vim.schedule(function()
                            local prompt_bufnr = vim.api.nvim_get_current_buf()
                            local picker = action_state.get_current_picker(prompt_bufnr)
                            local lnum = tonumber(prompt:sub(find_colon + 1))
                            if type(lnum) == "number" then
                                local win = picker.previewer.state.winid
                                local bufnr = picker.previewer.state.bufnr
                                local line_count = vim.api.nvim_buf_line_count(bufnr)
                                vim.api.nvim_win_set_cursor(win, { math.max(1, math.min(lnum, line_count)), 0 })
                            end
                        end)
                        return { prompt = ret }
                    end
                end,
                attach_mappings = function()
                    actions.select_default:enhance {
                        post = function()
                            -- if we found something, go to line
                            local prompt = action_state.get_current_line()
                            local find_colon = string.find(prompt, ":")
                            if find_colon then
                                local lnum = tonumber(prompt:sub(find_colon + 1))
                                vim.api.nvim_win_set_cursor(0, { lnum, 0 })
                            end
                        end,
                    }
                    return true
                end,
            },
            buffers = {
                mappings = {
                    i = {
                        ["<c-d>"] = actions.delete_buffer,
                    },
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    })

    telescope.load_extension("live_grep_args")
    telescope.load_extension('fzf')
end

return M
