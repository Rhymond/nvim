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
}

M.config = function()
    local ok, telescope = pcall(require, "telescope")

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
            file_ignore_patterns = {
                "node_modules"
            }
        },
        pickers = {
            find_files = {
                hidden = true,
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

    -- telescope.load_extension("live_grep_args")
    telescope.load_extension('fzf')
end

return M
