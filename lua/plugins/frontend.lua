return {
    "https://github.com/themaxmarchuk/tailwindcss-colors.nvim",
    "https://github.com/ap/vim-css-color",
    "https://github.com/mg979/vim-visual-multi",
    {
        "https://github.com/ziontee113/color-picker.nvim",
        config = function()
            require("color-picker").setup()
        end,
    },
    {
        "https://github.com/lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                space_char_blankline = " ",
                show_current_context = true,
                filetype_exclude = { "dashboard" },
            })
        end,
    },
    {
        "https://github.com/filipdutescu/renamer.nvim",
        config = function()
            require("renamer").setup()
        end,
    },
    {
        "https://github.com/windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "https://github.com/windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    "https://github.com/farmergreg/vim-lastplace",
    "https://github.com/turbio/bracey.vim",
    "https://github.com/pangloss/vim-javascript",
    "https://github.com/MaxMEllon/vim-jsx-pretty",
}
