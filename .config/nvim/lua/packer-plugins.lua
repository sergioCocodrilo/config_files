return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use 'xiyaowong/nvim-transparent'
	use "nvim-lua/plenary.nvim"
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
	  'nvim-tree/nvim-tree.lua',
	  requires = {
	    'nvim-tree/nvim-web-devicons', -- optional, for file icons
	  },
	  tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
    use "terrortylor/nvim-comment"
    use 'tpope/vim-dadbod'
    use 'yamatsum/nvim-cursorline'
end)
