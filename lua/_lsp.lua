local lsp = require "lspconfig"
local null_ls = require "null-ls"

local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    require('lsp_signature').on_attach({
        bind = true,
        timer_interval = 50,
        hint_enable = false
    })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { silent=true }
        on_attach(client, bufnr)

        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', opts)
    end,
})


lsp.gopls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end,
})

lsp.tailwindcss.setup({
    capabilities = capabilities,
    cmd = { "tailwindcss-language-server", "--stdio" },
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end,
})

-- lsp.eslint.setup({
--     on_attach = function(client, bufnr)
--         on_attach(client, bufnr)
--     end,
-- })

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint_d.with({
            only_local = "node_modules/.bin",
        }),
        null_ls.builtins.code_actions.eslint_d.with({
            only_local = "node_modules/.bin",
        }),
        null_ls.builtins.formatting.prettierd,
    },
    on_attach = on_attach,
})

