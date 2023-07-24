local M = { "catppuccin/nvim" }

M.name = "catppuccin"
M.lazy = false
M.priority = 1000

M.config = function()
    require("catppuccin").setup({
        dim_inactive = {
            enabled = true
        },
        color_overrides = {
            mocha = {
                base = "#0d1116",
                mantle = "#0d1116",
                crust = "#0d1116",
            },
        }
    })
    vim.cmd("colorscheme catppuccin-mocha")
end

return M
