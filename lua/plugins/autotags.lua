local M = { "windwp/nvim-ts-autotag" }

M.config = function()
    require('nvim-ts-autotag').setup({
        aliases = {
            ["liquid"] = "html",
        },
        opts = {
            -- Defaults
            enable_close = true,          -- Auto close tags
            enable_rename = true,         -- Auto rename pairs of tags
            enable_close_on_slash = false -- Auto close on trailing </
        },
    })
end

return M
