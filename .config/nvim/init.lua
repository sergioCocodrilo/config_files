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
    {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	},
	{
	  'nvim-tree/nvim-tree.lua',
	  requires = {
	    'nvim-tree/nvim-web-devicons', -- optional, for file icons
	  },
	  tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
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

-- mappings
local function map(mode, key, value)
	vim.keymap.set(mode, key, value, {silent = true})
end
map('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.api.nvim_set_keymap('', '<leader>co', ':call nerdcommenter#Comment(0, "Toggle")<CR>', {noremap = true})
