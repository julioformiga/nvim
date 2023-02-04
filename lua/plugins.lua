--[[ local status, packer = pcall(require, "packer")
if not status then
    print("Packer is not installed")
    return
end
--]]

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

-- Reloads Neovim after whenever you save useins.lua
vim.cmd([[
    augroup packer_user_config
      autocmd!
     autocmd BufWritePost useins.lua source <afile> | PackerSync
  augroup END
]])

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('https://github.com/wbthomason/packer.nvim')

    --  Navigation
    use('https://github.com/mhinz/vim-startify')
    use('https://github.com/nvim-telescope/telescope.nvim')
    -- use('https://github.com/nvim-telescope/telescope-project.nvim')
    use('https://github.com/preservim/tagbar') --  Tagbar for code navigation Alt-O
    use('https://github.com/folke/trouble.nvim')

    -- LSP -------
    use('https://github.com/williamboman/mason.nvim')
    use('https://github.com/williamboman/mason-lspconfig.nvim')
    use('https://github.com/neovim/nvim-lspconfig')
    use('https://github.com/hrsh7th/nvim-cmp')
    use('https://github.com/hrsh7th/cmp-nvim-lua')
    use('https://github.com/hrsh7th/cmp-nvim-lsp')
    use('https://github.com/hrsh7th/cmp-buffer')
    use('https://github.com/hrsh7th/cmp-path')
    -- use({"https://github.com/L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
    use('https://github.com/saadparwaiz1/cmp_luasnip')
    use('https://github.com/onsails/lspkind.nvim')
    use('https://github.com/themaxmarchuk/tailwindcss-colors.nvim')
    -- use('https://github.com/SmiteshP/nvim-navic')
    use {
        "https://github.com/SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }

    -- COC --------
    -- use('https://github.com/neoclide/coc.nvim')
    -- use('https://github.com/github/copilot.vim')
    -- use('https://github.com/tpope/vim-fugitive') --  GIT
    use('https://github.com/lewis6991/gitsigns.nvim') --  GIT
    --  use('https://github.com/nvim-treesitter/nvim-treesitter'), {'do': ':TSUpdate'}
    use('https://github.com/nvim-treesitter/nvim-treesitter')
    use('https://github.com/nvim-treesitter/nvim-treesitter-textobjects')
    use('https://github.com/JoosepAlviste/nvim-ts-context-commentstring')
    use('https://github.com/nvim-lua/plenary.nvim')
    use('https://github.com/MunifTanjim/nui.nvim')
    use('https://github.com/nvim-neo-tree/neo-tree.nvim')
    use('https://github.com/kdheepak/lazygit.nvim')
    use('https://github.com/akinsho/toggleterm.nvim')
    use {
        'https://github.com/stevearc/aerial.nvim',
        config = function() require('aerial').setup() end
    }
    --  Visual
    -- use('https://github.com/Shatur/neovim-ayu')
    use('https://github.com/nvim-tree/nvim-web-devicons')
    use('https://github.com/catppuccin/nvim')
    -- use('https://github.com/folke/tokyonight.nvim')
    use('https://github.com/EdenEast/nightfox.nvim')
    use('https://github.com/navarasu/onedark.nvim')
    use {
        'https://github.com/akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'https://github.com/nvim-tree/nvim-web-devicons'}
    -- use('https://github.com/vim-airline/vim-airline')  --  Status bar
    -- use('https://github.com/vim-airline/vim-airline-themes')  --  Status bar
    use {
        'https://github.com/nvim-lualine/lualine.nvim',
        requires = { 'https://github.com/kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
        'https://github.com/anuvyklack/pretty-fold.nvim',
        config = function()
            require('pretty-fold').setup()
        end
    }

    --  Focus + Editor
    -- use('https://github.com/tpope/vim-surround') --  Surrounding ysw)
    use('https://github.com/kylechui/nvim-surround')
    use('https://github.com/terrortylor/nvim-comment')
    use('https://github.com/tpope/vim-repeat')
    use('https://github.com/wellle/targets.vim') --  Target.vim
    use('https://github.com/leafOfTree/vim-matchtag') --  Target.vim
    use('https://github.com/famiu/bufdelete.nvim')
    --  use('https://github.com/xiyaowong/nvim-cursorword')
    use('https://github.com/mg979/vim-visual-multi') --, {'branch': 'master'}
    use('https://github.com/ap/vim-css-color') --  CSS Color Preview
    -- use('https://github.com/max397574/colortils.nvim') -- CSS Color Picker
    use('https://github.com/ziontee113/color-picker.nvim') -- CSS Color Picker
    use('https://github.com/folke/zen-mode.nvim')
    --  use('https://github.com/folke/twilight.nvim') " Destack and highlight lines in ZenMode
    use('https://github.com/lukas-reineke/indent-blankline.nvim')
    use('https://github.com/windwp/nvim-autopairs')
    use('https://github.com/windwp/nvim-ts-autotag')
    use('https://github.com/farmergreg/vim-lastplace') --  Cursor in last edit position
    use('https://github.com/turbio/bracey.vim') --, {'do': 'npm install --prefix server'} --  Live server
    --  use('https://github.com/manzeloth/live-server')
    use('https://github.com/pangloss/vim-javascript')  --  Syntax highlight for JSX
    use('https://github.com/MaxMEllon/vim-jsx-pretty') --  Syntax highlight for JSX

    if packer_bootstrap then
        packer.sync()
    end
end)
