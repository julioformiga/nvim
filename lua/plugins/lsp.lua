return {
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lua",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/hrsh7th/cmp-cmdline",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/jose-elias-alvarez/null-ls.nvim",
    "https://github.com/onsails/lspkind.nvim",
    "https://github.com/RRethy/vim-illuminate",
    {
        "https://github.com/L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
    },
    {
        "https://github.com/julioformiga/norminette42.nvim",
        -- "https://github.com/hardyrafael17/norminette42.nvim",
        lazy = false,
        keys = {
            { "<F1>", "<CMD>Header42<CR>", desc = "Add 42 header" },
        },
        config = function()
            require("norminette").setup()
        end,
    },
    {
        "https://github.com/linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
            "mfussenegger/nvim-dap-python"
        },
        config = function()
            require("venv-selector").setup({
                pdm_path = "."
            })
        end,
        event = "VeryLazy",
        keys = {
            {
                "<leader>vs", "<cmd>:VenvSelect<cr>",
                "<leader>vc", "<cmd>:VenvSelectCached<cr>"
            }
        }
    }
}
