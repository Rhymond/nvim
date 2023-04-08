local ok, telescope = pcall(require, "telescope")
local actions = require "telescope.actions"
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
        prompt_prefix = "  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "flex",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
    pickers = {
        find_files= {
            hidden = true,
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
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
            fuzzy = true,              -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case",  -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})

require("telescope").load_extension("live_grep_args")
require('telescope').load_extension('fzf')
