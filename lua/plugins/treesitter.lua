local M = { "nvim-treesitter/nvim-treesitter" }

M.build = ":TSUpdate"

M.dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring"
}

M.main = "nvim-treesitter.configs"
M.opts = {
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    autopairs = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = "<CR>",
    --     scope_incremental = "<CR>",
    --     node_incremental = "<TAB>",
    --     node_decremental = "<S-TAB>",
    --   },
    -- },
    indent = {
        enable = true,
        disable = function(lang, buf)
            if lang == "php" or lang == "yaml" or lang == "javascript" then
                return false
            end
            return true
        end,
    },
    textobjects = {
        -- select = {
        --   enable = true,
        --   lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim.
        --   keymaps = {
        --     -- You can use the capture groups defined in textobjects.scm.
        --     ['af'] = '@function.outer',
        --     ['if'] = '@function.inner',
        --     ['ac'] = '@class.outer',
        --     ['ic'] = '@class.inner',
        --   },
        -- },
        -- move = {
        --   enable = true,
        --   set_jumps = true, -- whether to set jumps in the jumplist
        --   goto_next_start = {
        --     [']m'] = '@function.outer',
        --     [']]'] = '@class.outer',
        --   },
        --   goto_next_end = {
        --     [']M'] = '@function.outer',
        --     [']['] = '@class.outer',
        --   },
        --   goto_previous_start = {
        --     ['[m'] = '@function.outer',
        --     ['[['] = '@class.outer',
        --   },
        --   goto_previous_end = {
        --     ['[M'] = '@function.outer',
        --     ['[]'] = '@class.outer',
        --   },
        -- },
    },
}

return M
