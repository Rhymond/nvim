local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "ray-x/lsp_signature.nvim",
    "simrat39/rust-tools.nvim",
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
    },
    "jwalton512/vim-blade",
    "jose-elias-alvarez/null-ls.nvim",
    "jose-elias-alvarez/nvim-lsp-ts-utils",
}

M.config = function()
    local lsp = require("lspconfig")
    local null_ls = require("null-ls")
    local util = require("vim.lsp.util")
    local rusttools = require("rust-tools")
    local signature = require('lsp_signature')
    local cmplsp = require("cmp_nvim_lsp")

    require("mason").setup()
    require("mason-lspconfig").setup()

    local cap = vim.lsp.protocol.make_client_capabilities()
    cap.textDocument.completion.completionItem.snippetSupport = true
    local capabilities = cmplsp.default_capabilities(cap)

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

        signature.on_attach({
            bind = true,
            timer_interval = 50,
            hint_enable = false
        })
    end

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

    -- local cfg = require'go.lsp'.config()
    -- cfg.on_attach = function(client, bufnr)
    --     formatting_callback(client, bufnr)
    --     on_attach(client, bufnr)
    --     cfg.on_attach(client, bufnr)
    -- end
    -- cfg.capabilities = capabilities
    -- lsp.gopls.setup(cfg)

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
                stubs = { "grpc", "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date",
                    "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext", "gmp",
                    "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli", "oci8",
                    "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite",
                    "pgsql", "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML",
                    "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg",
                    "sysvsem", "sysvshm", "tidy", "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl",
                    "Zend OPcache", "zip", "zlib", "gettext" }
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

    rusttools.setup({
        tools = {
            runnables = {
                use_telescope = true,
            },
            inlay_hints = {
                auto = true,
                show_parameter_hints = false,
                parameter_hints_prefix = "",
                other_hints_prefix = "",
            },
        },

        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
        server = {
            -- on_attach is a callback called when the language server attachs to the buffer
            on_attach = function(client, bufnr)
                formatting_callback(client, bufnr)
                on_attach(client, bufnr)
            end,
        },
    })

    local sources = {
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.diagnostics.revive,
        null_ls.builtins.formatting.golines.with({
            extra_args = {
                "--max-len=180",
                "--base-formatter=gofumpt",
            },
        })
    }

    -- for go.nvim
    -- local gotest = require("go.null_ls").gotest()
    -- table.insert(sources, gotest)
    --
    -- local gotest_codeaction = require("go.null_ls").gotest_action()
    -- table.insert(sources, gotest_codeaction)

    -- local golangci_lint = require("go.null_ls").golangci_lint()
    -- table.insert(sources, golangci_lint)
    null_ls.setup({
        sources = sources,
        debounce = 1000,
        default_timeout = 5000,
        on_attach = function(client, bufnr)
            formatting_callback(client, bufnr)
            on_attach(client, bufnr)
        end,
    })
end

return M
