" Dont know if the following are needed :P
"set nocompatible
"
"filetype plugin indent on
"
"set foldmethod=indent
"set foldlevel=99
"nnoremap <space> za

"======================= configs
" indentation
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set smartindent
set number relativenumber
set nu rnu

set encoding=utf-8
"set clipboard=unnamedplus
"
" NVIM specific clipboard
set clipboard+=unnamedplus

set noerrorbells
set guicursor=
syntax enable

set nowrap
set incsearch
set scrolloff=8

set colorcolumn=80

" avoid the search to remain hightlighted
set nohlsearch

"set spell spelllang=en_us
"set exrc  " to have a .vimrc on some project folder




"======================= plugins
" VIM-PLUG github.com/junegunn/vim-plug
call plug#begin()
	Plug 'arcticicestudio/nord-vim'
	Plug 'preservim/nerdtree'
    "Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdcommenter'
call plug#end()

colorscheme nord


"======================= mapping functions
let mapleader = " "
nmap <leader>co <Plug>NERDCommenterToggle
vmap <leader>co <Plug>NERDCommenterToggle<CR>gv

nmap <F2> :NERDTreeToggle<CR>
