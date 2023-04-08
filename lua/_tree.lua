local config = function()
    require("neo-tree").setup({
        window = {
            width = 30,
            mappings = {
                ["p"] = function(state)
                    local node = state.tree:get_node()
                    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
                end,
            }
        },
        source_selector = {
            winbar = true,
            statusline = true
        },
        default_component_configs = {
            filesystem = {
                hide_dotfiles = false,
                hide_by_name = {
                    -- "node_modules",
                    -- "vendor",
                }
            }
        }
    })
end

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = config,
}
