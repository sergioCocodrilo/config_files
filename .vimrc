set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set smartindent
set number relativenumber
set nu rnu

set encoding=utf-8

set clipboard=unnamedplus

set noerrorbells
"syntax enable

set nowrap
set incsearch
set scrolloff=8

set colorcolumn=80

set nohlsearch

" Pathogen installed plugins:
"   vim-airline
"   vim-airline-themes
"   nerdcommenter
"   nerdtree

" pathogen Tpope plugin
execute pathogen#infect()
syntax enable
filetype plugin indent on

set background=dark
colorscheme solarized

"airline
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" splits
set splitbelow splitright

let mapleader = " "
nmap <leader>co <Plug>NERDCommenterToggle
vmap <leader>co <Plug>NERDCommenterToggle<CR>gv

nmap <F2> :NERDTreeToggle<CR>
