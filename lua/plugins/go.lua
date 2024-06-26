local M = { "ray-x/go.nvim" }

M.ft = { "go", 'gomod' }

M.dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
}

M.config = function()
    require('go').setup({
        luasnip = true,
        lsp_cfg = false,
        lsp_inlay_hints = {
            enable = false,
        }
    })

    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
            require('go.format').goimport()
        end,
        group = format_sync_grp,
    })
end


M.build = ':lua require("go.install").update_all_sync()'

return M
