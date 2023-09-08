return {
    {
        "https://github.com/akinsho/bufferline.nvim",
        dependencies = "https://github.com/nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers", -- set to "tabs" to only show tabpages instead
                    themable = true,
                    numbers = "none", -- "buffer_id"
                    close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
                    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
                    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
                    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
                    indicator = {
                        icon = "▎", -- this should be omitted if indicator style is not 'icon'
                        style = "icon",
                    },
                    buffer_close_icon = "",
                    modified_icon = "●",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    max_name_length = 18,
                    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                    truncate_names = true, -- whether or not tab names should be truncated
                    tab_size = 18,
                    diagnostics = "false",
                    diagnostics_update_in_insert = false,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true,
                        },
                    },
                    color_icons = true, -- whether or not to add the filetype icon highlights
                    show_buffer_icons = true, -- disable filetype icons for buffers
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    separator_style = "slant", -- "slant" | "thick" | "thin" | { 'any', 'any' },
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { "close" },
                    },
                    sort_by = "insert_at_end",
                    -- sort_by = "relative_directory",
                    -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
                },
            })
        end,
    },
    {
        "https://github.com/nvim-lualine/lualine.nvim",
        dependencies = { "https://github.com/nvim-tree/nvim-web-devicons", opt = true },
    },
    {
        "https://github.com/SmiteshP/nvim-navic",
        dependencies = "https://github.com/neovim/nvim-lspconfig",
    },
    {
        "https://github.com/lewis6991/gitsigns.nvim",
        keys = {
            { "<leader>gd", "<CMD>Gitsigns diffthis<CR>", desc = "Git diff" },
        },
    },
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
    {
        "https://github.com/kevinhwang91/nvim-ufo",
        dependencies = "https://github.com/kevinhwang91/promise-async",
    },
    {
        "https://github.com/lewis6991/hover.nvim",
        keys = {
            { "K",  require("hover").hover,        desc = "hover" },
            { "gK", require("hover").hover_select, desc = "hover (select)" },
        },
        config = function()
            require("hover").setup({
                init = function()
                    -- Require providers
                    require("hover.providers.lsp")
                    require("hover.providers.gh")
                    -- require('hover.providers.gh_user')
                    -- require('hover.providers.jira')
                    require("hover.providers.man")
                    require("hover.providers.dictionary")
                end,
                preview_opts = {
                    border = "rounded",
                },
                -- Whether the contents of a currently open hover window should be moved
                -- to a :h preview-window when pressing the hover keymap.
                preview_window = false,
                title = true,
            })
        end,
    },
    {
        "https://github.com/kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    {
        "https://github.com/terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup({
                hook = function()
                    if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
                        require("ts_context_commentstring.internal").update_commentstring()
                    end
                end,
            })
        end,
    },
    "https://github.com/famiu/bufdelete.nvim",
    {
        "https://github.com/folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                window = {
                    backdrop = 0.8,
                    width = 160,
                },
            })
        end,
    },
    "https://github.com/nvim-pack/nvim-spectre",
    "https://github.com/wellle/targets.vim",
    "https://github.com/tpope/vim-repeat",
    "https://github.com/danymat/neogen",
}
