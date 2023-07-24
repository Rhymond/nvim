local M = { "folke/flash.nvim" }

M.event = "VeryLazy"

M.opts = {}

M.keys = {
    {
        "s",
        mode = { "n", "x", "o" },
        function()
            -- default options: exact mode, multi window, all directions, with a backdrop
            require("flash").jump()
        end,
        desc = "Flash",
    }
}

return M
