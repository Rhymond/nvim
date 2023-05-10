require("lazy").setup({
    -- LSP
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    -- 'williamboman/nvim-lsp-installer',
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        }
    },

    -- Theme Settings
    require("_theme"),
    require("_go"),

    -- AI
    "github/copilot.vim",
    -- "madox2/vim-ai",

    -- Telescope
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "sharkdp/fd",
    "BurntSushi/ripgrep",
    "nvim-telescope/telescope-live-grep-args.nvim",

    -- Misc
    require("_motion"),
    require("_explorer"),
    require("_splitjoin"),
    require("_repl"),
    require("_harpoon"),
    require("_surround"),
    "nvim-tree/nvim-web-devicons",
    "ahmedkhalf/project.nvim",
    "windwp/nvim-ts-autotag",
    "windwp/nvim-autopairs",
    "folke/lsp-trouble.nvim",
    "wakatime/vim-wakatime",
    "numToStr/Comment.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-lualine/lualine.nvim",

    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        }
    },

    -- Git
    "sindrets/diffview.nvim",

    -- Debugger
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",

    -- Markdown
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
    },

    -- Go
    "ray-x/go.nvim",
    "ray-x/guihua.lua",
    "leoluz/nvim-dap-go",
    "ray-x/lsp_signature.nvim",

    -- PHP
    "jwalton512/vim-blade",

    -- Javascript, Typescript
    "leafgarland/typescript-vim",
    "peitalin/vim-jsx-typescript",
    "jose-elias-alvarez/null-ls.nvim",
    "jose-elias-alvarez/nvim-lsp-ts-utils",
})
