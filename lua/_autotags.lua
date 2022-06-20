local autotag = require('nvim-ts-autotag')
require('nvim-autopairs').setup{}

autotag.setup({
    check_ts = true,
    enable_check_bracket_line = false,
    enable_moveright = false,
})
