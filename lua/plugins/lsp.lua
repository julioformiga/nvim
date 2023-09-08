return {
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lua",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/hrsh7th/cmp-cmdline",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/jose-elias-alvarez/null-ls.nvim",
    "https://github.com/onsails/lspkind.nvim",
    {
        "https://github.com/hardyrafael17/norminette42.nvim",
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "c",
                    "cpp",
                    "arduino",
                },
                callback = function()
                    vim.opt_local.shiftwidth = 4
                    vim.opt_local.tabstop = 4
                    vim.opt_local.softtabstop = 4
                    vim.opt_local.expandtab = false
                end,
            })
            require("norminette").setup()
        end,
    },
    "https://github.com/julioformiga/swenv.nvim",
}
