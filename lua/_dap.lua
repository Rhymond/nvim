require('dap-go').setup()
require("dapui").setup({
    expand_lines = true,
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
    },
})
