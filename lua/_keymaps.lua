local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions
local dap = require('dap')
local dapgo = require('dap-go')
local dapui = require('dapui')

-- A typical debug flow consists of:
--
-- Setting breakpoints via :lua require'dap'.toggle_breakpoint().
-- Launching debug sessions and resuming execution via :lua require'dap'.continue().
-- Stepping through code via :lua require'dap'.step_over() and :lua require'dap'.step_into().
-- Inspecting the state via the built-in REPL: :lua require'dap'.repl.open() or using the widget UI (:help dap-widgets)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { silent = true })
vim.keymap.set("n", "<F5>", dap.continue, { silent = true })
vim.keymap.set("n", "<F10>", dap.step_over, { silent = true })
vim.keymap.set("n", "<F11>", dap.step_into, { silent = true })
vim.keymap.set("n", "<F12>", dap.step_out, { silent = true })
vim.keymap.set("n", "<leader>dt", dapgo.debug_test, { silent = true })
vim.keymap.set("n", "<leader>do", dapui.toggle, { silent = true })
vim.keymap.set("n", "<leader>dl", dap.run_last, { silent = true })


-- Telescope
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files({cwd = require("oil").get_current_dir()})
end, {})
vim.keymap.set("n", "<leader>fg", extensions.live_grep_args.live_grep_args, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, {})
vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, {})
vim.keymap.set("n", "<leader>fp", extensions.projects.projects, {})

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })

-- Merge Tool, Diff View
vim.keymap.set("n", "<leader>dv", "<cmd>DiffViewOpen<cr>", { silent = true })

-- Oil
vim.keymap.set("n", "<leader>or", "<cmd>:e .<cr>", { silent = true })
vim.keymap.set("n", "<leader>oc", "<cmd>:e %:p:h<cr>", { silent = true })

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
vim.keymap.set("n", "<leader>got", "<cmd>GoTestFunc -F -v<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { silent = true, noremap = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>e", "<cmd>:Ex<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>c", "<cmd>:Copilot panel<cr>", { silent = true, noremap = true })
