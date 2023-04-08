local config = function()
    require("telescope").load_extension('harpoon')
    require("harpoon").setup({})
    local ui = require("harpoon.ui")
    local mark = require("harpoon.mark")

    vim.keymap.set("n", "<leader>aa", mark.add_file, {})
    vim.keymap.set("n", "<leader>an", ui.nav_next, { silent = true })
    vim.keymap.set("n", "<leader>ap", ui.nav_prev, { silent = true })
    vim.keymap.set("n", "<leader>at", '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>', { silent = true })
    vim.keymap.set("n", "<leader>a1t", '<cmd>lua require("harpoon.term").gotoTerminal(2)<cr>', { silent = true })
    vim.keymap.set("n", "<leader>a2t", '<cmd>lua require("harpoon.term").gotoTerminal(3)<cr>', { silent = true })
    vim.keymap.set("n", "<leader>a3t", '<cmd>lua require("harpoon.term").gotoTerminal(4)<cr>', { silent = true })
    vim.keymap.set("n", "<leader>af", ui.toggle_quick_menu, { silent = true })
    vim.keymap.set("n", "<leader>fm", "<cmd>Telescope harpoon marks<cr>", { silent = true })
end

return {
    "ThePrimeagen/harpoon",
    config = config,
}
