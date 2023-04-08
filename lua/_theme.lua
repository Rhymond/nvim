local config = function()
    require('github-theme').setup({
        theme_style = "dark_default"
    })
end

return {
    "projekt0n/github-nvim-theme",
    branch = "0.0.x",
    lazy = false,
    priority = 1000,
    config = config
}
