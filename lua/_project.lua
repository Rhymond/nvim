require("project_nvim").setup({
    exclude_dirs = {
        "~/Projects/gopath/src/github.com/rhymond/piksel/*",
        "~/Projects/php/gearjot/*",
        "~/Projects/piksel-landing/*"
    },
})
require('telescope').load_extension('projects')
