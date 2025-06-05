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

--======================================== plugins manager
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

--======================================== plugins
require("lazy").setup({

    -- support for Neovim and other plugs
	"nvim-lua/plenary.nvim",    
    { "echasnovski/mini.nvim", version = false },


    -- completition
    --{"neoclide/coc.nvim",
        --branch= 'release'
    --},
    --"neovim/nvim-lspconfig",

    -- syntax
    "nvim-treesitter/nvim-treesitter",

    -- search
    {
    "nvim-telescope/telescope.nvim", tag = "0.1.4",
      dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- file explorer
	{ 
	  "nvim-tree/nvim-tree.lua",
	  dependencies = "nvim-tree/nvim-web-devicons",
	},
    "kamykn/spelunker.vim", -- spelling
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- indent guides
    "sindrets/diffview.nvim",

    -- word highlights
    "RRethy/vim-illuminate",

    "preservim/nerdcommenter",
    "tpope/vim-surround",
    "tpope/vim-fugitive",

    -- databases
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",


    -- COLOR THEMES
    --"folke/tokyonight.nvim",
    {
      "sainnhe/edge",
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.edge_enable_italic = true
        vim.cmd.colorscheme("edge")
      end
    },

})

vim.opt.background = "light"
--vim.cmd[[colorscheme tokyonight]]
--vim.cmd[[colorscheme edge]]
--vim.cmd.colorscheme "catppuccin"

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- vim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()



require"nvim-treesitter.configs".setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
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

--======================================== MAPPINGS

local function map(mode, key, value)
	vim.keymap.set(mode, key, value, {silent = true})
end
map("n", "<C-n>", ":NvimTreeToggle<CR>")
vim.api.nvim_set_keymap("", "<leader>co", ":call nerdcommenter#Comment(0, 'Toggle')<CR>", {noremap = true})

vim.g.dbs = {
    { name = 'dev', url = 'postgresql://postgres:sesergio@localhost:5432/s12' },
}


--==================== HIGHLIGHT WORD UNDER CURSOR
vim.api.nvim_set_keymap("", "<F5>", ":IlluminateToggle<CR>", {noremap = true})
vim.api.nvim_set_keymap("", "<F6>", ":set hls! <CR>", {noremap = true}) -- toggle search highlights

vim.keymap.set('n', 'z/', function()
    if AutoHighlightToggle() then
        vim.opt.hlsearch = true
    end
end, { noremap = true, silent = true })

-- Función de alternar resaltado
function AutoHighlightToggle()
    vim.fn.setreg('/', '')
  
    if vim.fn.exists('#auto_highlight') == 1 then
        vim.api.nvim_del_augroup_by_name('auto_highlight')
        vim.opt.updatetime = 4000
        print('Highlight current word: off')
        return false
    else
        local augroup = vim.api.nvim_create_augroup('auto_highlight', { clear = true })
        vim.api.nvim_create_autocmd('CursorHold', {
            group = augroup,
            callback = function()
                vim.fn.setreg('/', '\\V\\<' .. vim.fn.escape(vim.fn.expand('<cword>'), '\\') .. '\\>')
            end
        })
        vim.opt.updatetime = 100
        print('Highlight current word: ON')
        return true
    end
end



require("mini.align").setup()
