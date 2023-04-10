vim.g.mapleader = " "
vim.g.tokyonight_transparent = vim.g.transparent_enable 
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 4
vim.o.wrap = false
vim.o.clipboard = "unnamedplus"
vim.o.colorcolumn = "80"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- packer
require('packer-plugins')

-- transparent
require("transparent").setup({
  enable = true, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude = {}, -- table: groups you don't want to clear
})

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


require('nvim_comment').setup()

-- mappings
local function map(mode, key, value)
	vim.keymap.set(mode, key, value, {silent = true})
end
map('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.api.nvim_set_keymap('', '<leader>co', ':call NERDComment(0, "Toggle")<CR>', {noremap = true})
