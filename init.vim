lua require('_lazy')
lua require('_plugins')
lua require('_keymaps')

set termguicolors

syntax enable

set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h15

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
set shortmess+=I 
set scrolloff=10

" set spell spelllang=en_us
" set cc=80                   " set an 80 column border for good coding style
" set smartindent
" filetype indent plugin on
autocmd Filetype typescriptreact setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
" autocmd Filetype php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" autocmd BufRead,BufNewFile ~/Projects/php/gearjot/frontend/views/** set filetype=blade

syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamed       " using system clipboard
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set hlsearch
set splitright
set splitbelow
set laststatus=3
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list
set wrap
set inccommand=nosplit
set number relativenumber
set cmdheight=0
set scrolloff=999

nnoremap <c-s> :update!<cr>
inoremap <c-s> <esc>:update!<cr>
