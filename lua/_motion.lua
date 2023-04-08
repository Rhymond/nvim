local config = function()
    require('leap').add_default_mappings()
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })
end

return {
    "ggandor/leap.nvim",
    config = config,
}
