return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        float = {
            padding = 10,
            win_options = {
                winblend = 0,
            }
        }
    },
    cmd = "Oil",
    keys = {
        {
            "<leader>e",
            "<CMD>lua require('oil').open_float()<CR>",
            desc = "File Explorer Root (Oil)",
        },
    },
}
