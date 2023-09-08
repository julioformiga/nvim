return {
    "https://github.com/mhinz/vim-startify",
    "https://github.com/folke/neodev.nvim",
    "https://github.com/folke/which-key.nvim",
    {
        "https://github.com/williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "https://github.com/williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    {
        "https://github.com/nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "https://github.com/MunifTanjim/nui.nvim",
        },
        keys = {
            { "<C-Space>", "<cmd>Neotree toggle<cr>",       desc = "Filesystem Lateral" },
            { "<A-e>",     "<cmd>Neotree float toggle<cr>", desc = "Filesystem Float" },
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    window = {
                        mappings = {
                            ["o"] = "system_open",
                        },
                    },
                    commands = {
                        system_open = function(state)
                            local node = state.tree:get_node()
                            local path = node:get_id()
                            -- macOs: open file in default application in the background.
                            -- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
                            vim.api.nvim_command("silent !open -g " .. path)
                            -- Linux: open file in default application
                            vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
                        end,
                    },
                },
            })
        end,
    },
    {
        "https://github.com/nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = { ["<A-q>"] = require("telescope.actions").close },
                        n = { ["<A-q>"] = require("telescope.actions").close },
                    },
                },
            })
        end,
    },
    {
        "https://github.com/folke/neoconf.nvim",
        cmd = "Neoconf",
    },
    {
        "https://github.com/preservim/tagbar",
        keys = {
            { "<leader>o", "<CMD>TagbarOpenAutoClose<CR>", desc = "Tagbar" },
        },
    },
    {
        "https://github.com/folke/noice.nvim",
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "https://github.com/MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "https://github.com/rcarriga/nvim-notify",
        },
    },
    { "https://github.com/stevearc/dressing.nvim" },
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    {
        "https://github.com/kdheepak/lazygit.nvim",
        keys = {
            { "<leader>gg", "<CMD>LazyGitCurrentFile<CR>", desc = "Lazygit" },
        },
    },
    {
        "https://github.com/akinsho/toggleterm.nvim",
        keys = {
            { "<A-1>", "<ESC><CMD>1ToggleTerm direction=float<CR>",      desc = "Terminal float" },
            { "<A-2>", "<ESC><CMD>2ToggleTerm direction=horizontal<CR>", desc = "Terminal horizontal" },
            { "<A-3>", "<ESC><CMD>3ToggleTerm direction=float<CR>",      desc = "Terminal 2 float" },
        },
        config = function()
            require("toggleterm").setup({
                -- shading_factor = 1,
                shade_terminals = false,
                float_opts = {
                    border = "curved",
                },
                highlights = {
                    Normal = {
                        guibg = "#0F151E",
                        guifg = "#69AD43",
                        -- guifg = "#A4FF4F",
                    },
                    NormalFloat = {
                        guibg = "#0F151E",
                        guifg = "#69AD43",
                        -- guifg = "#A4FF4F",
                    },
                },
                persist_mode = false,
                winbar = {
                    enable = true,
                },
            })
        end,
    },
    {
        "https://github.com/stevearc/aerial.nvim",
        keys = {
            { "<leader>a", "<CMD>AerialToggle float<cr>", desc = "Aerial float" },
        },
        config = function()
            require("aerial").setup({
                autojump = true,
                close_on_select = true,
            })
        end,
    },
    {
        "https://github.com/ellisonleao/glow.nvim",
        config = function()
            require("glow").setup()
        end,
    },
    "https://github.com/nvim-tree/nvim-web-devicons",
    {
        "https://github.com/ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true,
            })
        end,
    },

    {
        "https://github.com/catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato", -- latte, frappe, macchiato, mocha
                background = {
                    light = "latte",
                    dark = "macchiato",
                },
                transparent_background = false,
                term_colors = true,
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.1,
                },
                no_italic = false, -- Force no italic
                no_bold = false, -- Force no bold
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = { "bold" },
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = { "italic,bold" },
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    notify = false,
                    mini = false,
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })
            require("catppuccin").load()
            vim.cmd.colorscheme("catppuccin-macchiato")
        end,
    },
}
