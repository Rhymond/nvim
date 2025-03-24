local M = { "ray-x/lsp_signature.nvim" }

M.config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if vim.tbl_contains({ 'null-ls' }, client.name) then -- blacklist lsp
                return
            end
            require("lsp_signature").on_attach({
                bind = true,
                -- timer_interval = 50,
                floating_window = true,
                hint_enable = true,
            }, bufnr)
        end,
    })
end

return M
