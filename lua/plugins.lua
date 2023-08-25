-- Install packer.nvim the first time
local status, packer = pcall(require, "packer")
if not status then
    print("Packer is not installed")
    return
end
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
ensure_packer()

-- Reloads Neovim after whenever you save plugins.lua
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup END
]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("https://github.com/wbthomason/packer.nvim")
    -- use('https://github.com/github/copilot.vim')

    --  Navigation
    use("https://github.com/mhinz/vim-startify")
    use("https://github.com/nvim-telescope/telescope.nvim")
    -- use('https://github.com/nvim-telescope/telescope-project.nvim')
    use("https://github.com/preservim/tagbar") --  Tagbar for code navigation Alt-O
    use("https://github.com/folke/trouble.nvim")
    -- use('https://github.com/rcarriga/nvim-notify')
    use({
        "https://github.com/folke/noice.nvim",
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "https://github.com/MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "https://github.com/rcarriga/nvim-notify",
        },
    })
    use({ "https://github.com/stevearc/dressing.nvim" })
    -- LSP -------
    use("https://github.com/williamboman/mason.nvim")
    use("https://github.com/williamboman/mason-lspconfig.nvim")
    use("https://github.com/neovim/nvim-lspconfig")
    use("https://github.com/hrsh7th/nvim-cmp")
    use("https://github.com/hrsh7th/cmp-nvim-lua")
    use("https://github.com/hrsh7th/cmp-nvim-lsp")
    use("https://github.com/hrsh7th/cmp-buffer")
    use("https://github.com/hrsh7th/cmp-path")
    use("https://github.com/hrsh7th/cmp-cmdline")

    use({
        "https://github.com/nvim-neotest/neotest",
        requires = {
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/nvim-treesitter/nvim-treesitter",
            "https://github.com/antoinemadec/FixCursorHold.nvim",
            "https://github.com/nvim-neotest/neotest-python",
            "https://github.com/nvim-neotest/neotest-plenary",
            "https://github.com/marilari88/neotest-vitest",
        },
    })

    -- SNIPPETS ------------------
    -- use('https://github.com/hrsh7th/cmp-vsnip')
    -- use('https://github.com/hrsh7th/vim-vsnip')

    use("https://github.com/L3MON4D3/LuaSnip")
    use("https://github.com/saadparwaiz1/cmp_luasnip")

    -- use('https://github.com/hrsh7th/cmp-vsnip')
    -- use('https://github.com/hrsh7th/vim-vsnip')

    -- use('https://github.com/dcampos/nvim-snippy')
    -- use('https://github.com/dcampos/cmp-snippy')
    use("https://github.com/rafamadriz/friendly-snippets")
    -- use({
    --     "https://github.com/jose-elias-alvarez/null-ls.nvim",
    --     -- config = function()
    --     --    require("null-ls").setup()
    --     -- end,
    --     requires = { "nvim-lua/plenary.nvim" },
    -- })
    use("https://github.com/jose-elias-alvarez/null-ls.nvim")
    -------------------------------

    use("https://github.com/onsails/lspkind.nvim")
    use("https://github.com/themaxmarchuk/tailwindcss-colors.nvim")
    use({
        "https://github.com/SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
    })
    use("https://github.com/lewis6991/gitsigns.nvim") --  GIT
    use("https://github.com/nvim-treesitter/nvim-treesitter")
    use("https://github.com/nvim-treesitter/nvim-treesitter-textobjects")
    use("https://github.com/JoosepAlviste/nvim-ts-context-commentstring")
    use("https://github.com/nvim-lua/plenary.nvim")
    use("https://github.com/MunifTanjim/nui.nvim")
    use({
        "https://github.com/nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    })
    use("https://github.com/kdheepak/lazygit.nvim")
    use("https://github.com/akinsho/toggleterm.nvim")
    use("https://github.com/stevearc/aerial.nvim")

    --  === Visual ===
    -- use('https://github.com/Shatur/neovim-ayu')
    use({
        "https://github.com/ellisonleao/glow.nvim",
        config = function()
            require("glow").setup()
        end,
    })
    use("https://github.com/nvim-tree/nvim-web-devicons")
    -- use('https://github.com/kyazdani42/nvim-web-devicons')
    use("https://github.com/nvim-pack/nvim-spectre")
    use({
        "https://github.com/ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true,
            })
        end,
    })

    -- ===== Themes =====
    use("https://github.com/catppuccin/nvim")
    -- use('https://github.com/folke/tokyonight.nvim')
    use("https://github.com/EdenEast/nightfox.nvim")
    use("https://github.com/loctvl842/monokai-pro.nvim")

    use({
        "https://github.com/akinsho/bufferline.nvim",
        tag = "*",
        requires = "https://github.com/nvim-tree/nvim-web-devicons",
    })
    use({
        "https://github.com/nvim-lualine/lualine.nvim",
        requires = { "https://github.com/kyazdani42/nvim-web-devicons", opt = true },
    })
    use({ "https://github.com/kevinhwang91/nvim-ufo", requires = "https://github.com/kevinhwang91/promise-async" })
    use("https://github.com/lewis6991/hover.nvim")
    -- 42
    use({ "https://github.com/hardyrafael17/norminette42.nvim" })

    -- DEBUG
    use("https://github.com/folke/neodev.nvim")
    use({ "https://github.com/rcarriga/nvim-dap-ui", requires = { "https://github.com/mfussenegger/nvim-dap" } })
    use("https://github.com/mfussenegger/nvim-dap-python")
    use("https://github.com/theHamsta/nvim-dap-virtual-text")
    use("https://github.com/mortepau/codicons.nvim")

    --  Focus + Editor
    -- use("https://github.com/AckslD/swenv.nvim")
    use("https://github.com/julioformiga/swenv.nvim")
    use({
        "https://github.com/kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    })
    use("https://github.com/filipdutescu/renamer.nvim")
    use("https://github.com/terrortylor/nvim-comment")
    use("https://github.com/tpope/vim-repeat")
    use("https://github.com/wellle/targets.vim") --  Target.vim
    -- use('https://github.com/leafOfTree/vim-matchtag') --  Target.vim
    use("https://github.com/famiu/bufdelete.nvim")
    --  use('https://github.com/xiyaowong/nvim-cursorword')
    use("https://github.com/mg979/vim-visual-multi")    --, {'branch': 'master'}
    use("https://github.com/ap/vim-css-color")          --  CSS Color Preview
    -- use('https://github.com/max397574/colortils.nvim') -- CSS Color Picker
    use("https://github.com/ziontee113/color-picker.nvim") -- CSS Color Picker
    use("https://github.com/folke/zen-mode.nvim")
    --  use('https://github.com/folke/twilight.nvim') " Destack and highlight lines in ZenMode
    use("https://github.com/lukas-reineke/indent-blankline.nvim")
    use("https://github.com/windwp/nvim-autopairs")
    use("https://github.com/windwp/nvim-ts-autotag")
    use("https://github.com/farmergreg/vim-lastplace") --  Cursor in last edit position
    use("https://github.com/turbio/bracey.vim")     --, {'do': 'npm install --prefix server'} --  Live server
    --  use('https://github.com/manzeloth/live-server')
    use("https://github.com/pangloss/vim-javascript") --  Syntax highlight for JSX
    use("https://github.com/MaxMEllon/vim-jsx-pretty") --  Syntax highlight for JSX

    if packer_bootstrap then
        packer.sync()
    end
end)
