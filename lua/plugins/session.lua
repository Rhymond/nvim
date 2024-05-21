local M = { "folke/persistence.nvim" }

M.config = function()
    vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})

    require("persistence").setup()
end

return M
