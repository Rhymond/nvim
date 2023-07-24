local M = { "nvim-neotest/neotest" }

M.dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
}

M.config = function()
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                local message =
                    diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                return message
            end,
        },
    }, neotest_ns)
    require("neotest").setup({
        adapters = {
            require("neotest-go")({
                experimental = {
                    test_table = true,
                },
                args = { "-count=1", "-timeout=60s" }
            })
        },
    })
end


return M
