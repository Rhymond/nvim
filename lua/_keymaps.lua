local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions
local opts = { noremap = true, silent = true }

-- Telescope
vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files({ cwd = require("oil").get_current_dir() })
end, opts)
vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep({ cwd = require("oil").get_current_dir() })
end, opts)
-- vim.keymap.set('n', '/', builtin.current_buffer_fuzzy_find, {noremap = true, silent = true})
vim.keymap.set("n", "<leader>fg", extensions.live_grep_args.live_grep_args, {})
vim.keymap.set("n", "<leader>fd", builtin.git_status, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, {})
vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, {})

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })

-- Merge Tool, Diff View
vim.keymap.set("n", "<leader>dv", "<cmd>DiffViewOpen<cr>", { silent = true })

-- Oil
vim.keymap.set("n", "<leader>or", "<cmd>:Oil --float .<cr>", { silent = true })
vim.keymap.set("n", "<leader>oc", "<cmd>:Oil --float %:p:h<cr>", { silent = true })

-- LSP
vim.keymap.set("n", "<leader>lr", "<cmd>:LspRestart", { silent = true })

-- Aerial
vim.keymap.set("n", "<leader>at", "<cmd>:AerialToggle<cr>", { silent = true })

-- nnoremap <c-s> :update!<cr>
-- inoremap <c-s> <esc>:update!<cr>
-- inoremap <c-v> <c-r>*
--
-- :tnoremap <A-h> <C-\><C-N><C-w>h
-- :tnoremap <A-j> <C-\><C-N><C-w>j
-- :tnoremap <A-k> <C-\><C-N><C-w>k
-- :tnoremap <A-l> <C-\><C-N><C-w>l
-- :inoremap <A-h> <C-\><C-N><C-w>h
-- :inoremap <A-j> <C-\><C-N><C-w>j
-- :inoremap <A-k> <C-\><C-N><C-w>k
-- :inoremap <A-l> <C-\><C-N><C-w>l
-- :nnoremap <A-h> <C-w>h
-- :nnoremap <A-j> <C-w>j
-- :nnoremap <A-k> <C-w>k
-- :nnoremap <A-l> <C-w>l

--
-- nnoremap <leader>s :SymbolsOutline<cr>
--
-- nnoremap <silent>gs :Lspsaga signature_help<CR>
-- nnoremap <silent>gr :Lspsaga rename<CR>
-- nnoremap <silent><leader>ca :Lspsaga code_action<CR>
--
-- nnoremap <leader>xx <cmd>TroubleToggle<cr>
-- nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
-- nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
-- nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
-- nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
--
-- nnoremap <leader>tsi :TSLspImportAll<cr>
-- nnoremap <leader>tso :TSLspOrganize<cr>

vim.keymap.set("n", "<leader>goi", "<cmd>GoImport<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gr", "<cmd>GoRename<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gof", "<cmd>GoFillStruct<cr>", { silent = true, noremap = true })
vim.keymap.set("i", "<leader>gof", "<cmd>GoFillStruct<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>rt", neotest.run.run, { silent = true, noremap = true })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { silent = true, noremap = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>e", "<cmd>:Ex<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>cp", "<cmd>:Copilot panel<cr>", { silent = true, noremap = true })
