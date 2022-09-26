require('go').setup({
    luasnip = true,
    trouble = true,
})

vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

