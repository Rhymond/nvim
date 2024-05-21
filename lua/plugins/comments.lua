local M = { "numToStr/Comment.nvim" }

M.dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring"
}

M.config = function()
    local tscontextcomment = require('ts_context_commentstring.integrations.comment_nvim')

    require("Comment").setup({
        pre_hook = tscontextcomment.create_pre_hook(),
    })
end

return M
