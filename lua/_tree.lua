local function custom_callback(callback_name)
    return string.format(":lua require('_treeutils').%s()<CR>", callback_name)
end

-- this is passed in the call to setup

require 'nvim-tree'.setup {
    view = {
        mappings = {
            list = {
              { key = "<leader>ff", cb = custom_callback "launch_find_files" },
              { key = "<leader>fg", cb = custom_callback "launch_live_grep" },
            }
        }
    }
}

