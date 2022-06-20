call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'projekt0n/github-nvim-theme'

" signature
Plug 'ray-x/lsp_signature.nvim'

" clipboard
Plug 'AckslD/nvim-neoclip.lua'

" autoclose
Plug 'windwp/nvim-ts-autotag'
Plug 'windwp/nvim-autopairs'

" jsx and ts
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" abolish
Plug 'tpope/vim-abolish'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'sharkdp/fd'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope-file-browser.nvim'

" surround
Plug 'tpope/vim-surround'

" lsp errors, trouble
Plug 'folke/lsp-trouble.nvim'

" typescript
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" go
Plug 'ray-x/go.nvim'

" motion
Plug 'ggandor/lightspeed.nvim'

" wakatime
Plug 'wakatime/vim-wakatime'

" comment
" Plug 'terrortylor/nvim-comment'
" Plug 'tpope/vim-commentary'
Plug 'numToStr/Comment.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

" lsp colors
Plug 'folke/lsp-colors.nvim'

" symbols
Plug 'simrat39/symbols-outline.nvim'

" explorer
Plug 'kyazdani42/nvim-tree.lua'

" lsp saga
Plug 'glepnir/lspsaga.nvim'

" spell check
Plug 'lewis6991/spellsitter.nvim'

" cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" git
Plug 'lewis6991/gitsigns.nvim'
Plug 'kdheepak/lazygit.nvim'

" fugitive
Plug 'tpope/vim-fugitive'

" statusline
Plug 'nvim-lualine/lualine.nvim'
call plug#end()

" colorscheme evening
colorscheme github_dark_default

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
" set spell spelllang=en_us
" set cc=80                   " set an 80 column border for good coding style
" set smartindent
" filetype indent plugin on
autocmd Filetype typescriptreact setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamed       " using system clipboard
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set nohlsearch
set splitright
set splitbelow
set laststatus=3
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list
set wrap
set inccommand=nosplit
set number relativenumber
" set completeopt=menu,menuone,noselect

lua require('_telescope')
lua require('_statusline')
lua require('_gitsigns')
lua require('_treesitter')
lua require('_cmp')
lua require('_lsp')
lua require('_go')
lua require('_comment')
lua require('_tree')
lua require('_trouble')
lua require('_spellsitter')
lua require('_autotags')
lua require('_luasnip')
lua require('_neoclip')
lua require('_signature')

" shortcuts
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope file_browser<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fc <cmd>Telescope neoclip unnamed<cr>
nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
nnoremap <leader>gi <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>

" nnoremap <leader>ga <cmd>Git add .<cr>
" nnoremap <leader>gc <cmd>Git commit<cr>
" nnoremap <leader>gp <cmd>Git push<cr>

tnoremap <ESC> <C-\><C-n>

nnoremap <c-s> :update<cr>
inoremap <c-s> <esc>:update<cr>

nnoremap <C-n> :NvimTreeToggle<cr>
nnoremap <leader>r :NvimTreeRefresh<cr>
nnoremap <leader>n :NvimTreeFindFile<cr>

nnoremap <leader>s :SymbolsOutline<cr>

nnoremap <silent>gs :Lspsaga signature_help<CR>
nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>

nnoremap <leader>tsi :TSLspImportAll<cr>
nnoremap <leader>tso :TSLspOrganize<cr>

nnoremap <leader>goi :GoImport<cr>
nnoremap <leader>gor :GoRename<cr>
nnoremap <leader>got :GoTestFunc<cr>
nnoremap <leader>gof :GoFillStruct<cr>

nnoremap <silent> <leader>gg :LazyGit<CR>
