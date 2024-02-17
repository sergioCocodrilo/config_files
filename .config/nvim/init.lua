vim.g.mapleader = " "
vim.g.tokyonight_transparent = vim.g.transparent_enable 

vim.o.clipboard = "unnamedplus"
vim.o.colorcolumn = "80"
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 4
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.wrap = false

-- plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
    "folke/tokyonight.nvim",
	-- "xiyaowong/nvim-transparent",
	"nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "preservim/nerdcommenter",
    --"terrortylor/nvim-comment",
    "tpope/vim-surround",
    "tpope/vim-fugitive",
    --
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
	{
	  'nvim-tree/nvim-tree.lua',
	  dependencies = 'nvim-tree/nvim-web-devicons',
	  tag = 'nightly' -- optional, updated every week. (see issue #1193)
	},
    'kamykn/spelunker.vim',
    'godlygeek/tabular',
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }
})

-- Transparency
-- require("transparent").setup({
--   extra_groups = { -- table/string: additional groups that should be cleared
--     -- In particular, when you set it to 'all', that means all available groups
-- 
--     -- example of akinsho/nvim-bufferline.lua
--     "BufferLineTabClose",
--     "BufferlineBufferSelected",
--     "BufferLineFill",
--     "BufferLineBackground",
--     "BufferLineSeparator",
--     "BufferLineIndicatorSelected",
--   },
--   exclude_groups = {}, -- table: groups you don't want to clear
-- })


vim.cmd[[colorscheme tokyonight]]

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- vim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()
-- require('nvim_comment').setup()


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  --ignore_install = { "javascript" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {enable = true}
}


require("ibl").setup()

------------------------------------------------------------
-- mappings
------------------------------------------------------------
local function map(mode, key, value)
	vim.keymap.set(mode, key, value, {silent = true})
end
map('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.api.nvim_set_keymap('', '<leader>co', ':call nerdcommenter#Comment(0, "Toggle")<CR>', {noremap = true})


