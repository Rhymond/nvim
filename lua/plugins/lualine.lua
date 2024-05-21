local M = { "nvim-lualine/lualine.nvim" }

M.opts = {
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { {
            "filename", path = 1
        } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
}

return M
