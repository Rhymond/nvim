local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "simrat39/rust-tools.nvim",
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
    },
    "jwalton512/vim-blade",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
    "nanotee/sqls.nvim",
}

M.config = function()
    local lsp = require("lspconfig")
    local null_ls = require("null-ls")
    local util = require("vim.lsp.util")
    local rusttools = require("rust-tools")
    local cmplsp = require("cmp_nvim_lsp")
    local formattingKey = "<space>f"

    require("mason").setup()
    require("mason-lspconfig").setup {
        automatic_installation = true
    }

    local cap = vim.lsp.protocol.make_client_capabilities()
    cap.textDocument.completion.completionItem.snippetSupport = true
    local capabilities = cmplsp.default_capabilities(cap)

    local formatting_callback = function(client, bufnr)
        vim.keymap.set('n', formattingKey, function()
            local params = util.make_formatting_params({})
            client.request('textDocument/formatting', params, nil, bufnr)
            -- vim.lsp.buf.format({
            --     bufnr = bufnr,
            --     filter = function(client)
            --         return client.name == "null-ls"
            --     end,
            -- })
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
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dd', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
    end

    -- lsp.cssmodules_ls.setup({
    --     capabilities = capabilities,
    --     on_attach = function(client, bufnr)
    --         formatting_callback(client, bufnr)
    --         on_attach(client, bufnr)
    --     end
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

    local function organize_imports()
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = ""
        }
        vim.lsp.buf.execute_command(params)
    end

    lsp.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            local opts = { silent = true }
            on_attach(client, bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'tsi', '<cmd>:OrganizeImports<CR>', opts)
        end,
        commands = {
            OrganizeImports = {
                organize_imports,
                description = "Organize Imports"
            }
        }
    })

    lsp.yamlls.setup({
        yaml = {
            schemaStore = {
                enable = true
            }
        }
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

    lsp.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
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

    lsp.terraformls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            -- formatting_callback(client, bufnr)
            on_attach(client, bufnr)
        end,
    })

    lsp.shopify_theme_ls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            -- formatting_callback(client, bufnr)
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
                },
                hints = {
                    constantValues = true,
                    functionTypeParameters = true,
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

    lsp.volar.setup({
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

    -- lsp.sqlls.setup({
    --     capabilities = capabilities,
    --     cmd = { "sql-language-server", "up", "--method", "stdio" },
    --     filetypes = { "sql", "mysql" },
    --     root_dir = function() return vim.loop.cwd() end,
    --     on_attach = function(client, bufnr)
    --         on_attach(client, bufnr)
    --     end,
    --     settings = {
    --         connections = {
    --             {
    --                 driver = 'mysql',
    --                 name = 'Local Gearjot',
    --                 database = 'GearJot',
    --                 user = 'root',
    --                 password = 'root',
    --                 host = '127.0.0.1',
    --                 port = 3306
    --             },
    --         }
    --     }
    -- })


    -- lsp.sqls.setup({
    -- settings = {
    --     sqls = {
    --         connections = {
    --             {
    --                 driver = 'mysql',
    --                 dataSourceName = 'root:root@tcp(127.0.0.1:3306)/GearJot',
    --             },
    --         },
    --     },
    -- },
    -- })
    lsp.sqls.setup {
        on_attach = function(client, bufnr)
            require('sqls').on_attach(client, bufnr) -- require sqls.nvim
        end,
        settings = {
            sqls = {
                connections = {
                    {
                        driver = 'mysql',
                        dataSourceName = 'root:root@tcp(127.0.0.1:3306)/GearJot',
                    },
                },
            },
        },
    }

    lsp.spectral.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
        end,
    })

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
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.code_actions.eslint_d"),
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.prettier.with({
        --     filetypes = { "javascript", "typescript", "css", "html", "json", "yaml", "markdown", "liquid" }
        -- }),
        -- require("none-ls.formatting.prettierd"),
        -- null_ls.builtins.diagnostics.revive,
        -- null_ls.builtins.formatting.golines.with({
        --     extra_args = {
        --         "--max-len=180",
        --         "--base-formatter=gofumpt",
        --     },
        -- })
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
