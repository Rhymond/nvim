local lsp = require "lspconfig"
local null_ls = require "null-ls"
local util = require "vim.lsp.util"
local configs = require "lspconfig/configs"

local formatting_callback = function(client, bufnr)
    vim.keymap.set('n', '<space>f', function()
        local params = util.make_formatting_params({})
        client.request('textDocument/formatting', params, nil, bufnr)
    end, { buffer = bufnr })
end

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

    require('lsp_signature').on_attach({
        bind = true,
        timer_interval = 50,
        hint_enable = false
    })
end

local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true
local capabilities = require('cmp_nvim_lsp').default_capabilities(cap)

-- lsp.yamlls.setup({
--     capabilities = capabilities,
--     on_attach = function(client, bufnr)
--         formatting_callback(client, bufnr)
--         on_attach(client, bufnr)
--     end,
--     settings = {
--         yaml = {
--             schemas = {
--                 ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "/*"
--             }
--         }
--     }
-- })

lsp.cssls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
        on_attach(client, bufnr)
    end
})

lsp.dockerls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
        on_attach(client, bufnr)
    end
})

lsp.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { silent = true }
        on_attach(client, bufnr)
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', opts)
    end,
})

lsp.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
        on_attach(client, bufnr)
    end,
})


lsp.gopls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
        on_attach(client, bufnr)
    end,
    settings = {
        gopls = {
            analyses = {
                staticcheck = true,
            }
        }
    }
})

lsp.marksman.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- formatting_callback(client, bufnr)
        on_attach(client, bufnr)
    end
})

lsp.intelephense.setup({
    settings = {
        intelephense = {
            stubs = {
                "grpc",
                "apache",
                "bcmath",
                "bz2",
                "calendar",
                "com_dotnet",
                "Core",
                "ctype",
                "curl",
                "date",
                "dba",
                "dom",
                "enchant",
                "exif",
                "FFI",
                "fileinfo",
                "filter",
                "fpm",
                "ftp",
                "gd",
                "gettext",
                "gmp",
                "hash",
                "iconv",
                "imap",
                "intl",
                "json",
                "ldap",
                "libxml",
                "mbstring",
                "meta",
                "mysqli",
                "oci8",
                "odbc",
                "openssl",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_ibm",
                "pdo_mysql",
                "pdo_pgsql",
                "pdo_sqlite",
                "pgsql",
                "Phar",
                "posix",
                "pspell",
                "readline",
                "Reflection",
                "session",
                "shmop",
                "SimpleXML",
                "snmp",
                "soap",
                "sockets",
                "sodium",
                "SPL",
                "sqlite3",
                "standard",
                "superglobals",
                "sysvmsg",
                "sysvsem",
                "sysvshm",
                "tidy",
                "tokenizer",
                "xml",
                "xmlreader",
                "xmlrpc",
                "xmlwriter",
                "xsl",
                "Zend OPcache",
                "zip",
                "zlib",
                "gettext"
            }
        }
    },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
        on_attach(client, bufnr)
    end,
})

lsp.html.setup({
    capabilities = capabilities,
    filetypes = { "html", "blade" },
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
        on_attach(client, bufnr)
    end,
})

lsp.sqlls.setup({
    capabilities = capabilities,
    -- filetypes = { "sql", "go" },
    on_attach = function(client, bufnr)
        require('sqlls').on_attach(client, bufnr)
        on_attach(client, bufnr)
    end
})

lsp.spectral.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end,
}

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier,
    },
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
        on_attach(client, bufnr)
    end,
})
