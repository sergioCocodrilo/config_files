set nocompatible

filetype plugin indent on

" Finding files
set path+=**
set wildmenu
command! MakeTags !ctags -R *



set laststatus=2
if version >= 700
	au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
	au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"======================= New configs
" indentation
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set smartindent
set number relativenumber
set nu rnu

set encoding=utf-8
set clipboard=unnamedplus

syntax enable

"set nowrap
"set exrc  " to have a .vimrc on some project folder
"set spell spelllang=en_us

" VIM-PLUG github.com/junegunn/vim-plug
call plug#begin()
	Plug 'arcticicestudio/nord-vim'
	Plug 'preservim/nerdtree'
call plug#end()
colorscheme nord
