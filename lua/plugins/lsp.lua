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
        keys = {
            { "<F1>", "<CMD>Header42<CR>", desc = "Add 42 header" },
        },
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
    {
        "https://github.com/julioformiga/swenv.nvim",
        keys = {
            { "<leader>ve", "<CMD>lua require('swenv.api').pick_venv()<CR>", desc = "Select virtualenv" },
        },
        config = function()
            require("swenv").setup({
                -- Should return a list of tables with a `name` and a `path` entry each.
                -- Gets the argument `venvs_path` set below.
                -- By default just lists the entries in `venvs_path`.
                get_venvs = function(venvs_path)
                    return require("swenv.api").get_venvs(venvs_path)
                end,
                -- Path passed to `get_venvs`.
                venvs_path = vim.fn.expand("~/.cache/pypoetry/virtualenvs"),
                -- venvs_path = vim.fn.expand("~/dev/python/estudo/pdmproject"),
                -- venvs_path = vim.fn.expand("~/.local/share/pdm/venvs"),
                -- Something to do after setting an environment, for example call vim.cmd.LspRestart
                -- post_set_venv = nil,
                post_set_venv = vim.cmd.LspRestart,
            })
        end,
    },
}
