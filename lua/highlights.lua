local navic = require("nvim-navic")
navic.setup({
    highlight = false,
})
local breadcrumbs = {
    function()
        return navic.get_location()
    end,
    cond = function()
        return navic.is_available()
    end,
}

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {

            statusline = {
                "startify",
                "toggleterm",
                "neo-tree",
            },
            winbar = {
                "startify",
                "toggleterm",
                "neo-tree",
            },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 4 } },
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_x = { { "swenv", icon = "" }, { "filetype", icon_only = true } },
        -- lualine_x = { { "filetype", icon_only = true } },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        -- lualine_a = {'buffers'},
        -- lualine_b = {'branch'},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {'tabs'}
    },
    winbar = {
        lualine_a = { "filename" },
        lualine_b = { breadcrumbs },
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = { "filename" },
        lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {}
    },
    extensions = { "toggleterm", "nvim-dap-ui", "neo-tree", "aerial" },
})

-- Default options
-- require("nightfox").setup({
--     options = {
--         -- Compiled file's destination location
--         compile_path = vim.fn.stdpath("cache") .. "/nightfox",
--         compile_file_suffix = "_compiled", -- Compiled file suffix
--         transparent = false,         -- Disable setting background
--         terminal_colors = true,      -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
--         dim_inactive = true,         -- Non focused panes set to alternative background
--         module_default = true,       -- Default enable value for modules
--         styles = {
--             -- Style to be applied to different syntax groups
--             comments = "italic", -- Value is any valid attr-list value `:help attr-list`
--             conditionals = "NONE",
--             constants = "NONE",
--             functions = "NONE",
--             keywords = "bold",
--             numbers = "NONE",
--             operators = "NONE",
--             strings = "NONE",
--             types = "italic,bold",
--             variables = "NONE",
--         },
--         inverse = {
--             -- Inverse highlight for different types
--             match_parent = false,
--             visual = false,
--             search = false,
--         },
--         -- modules = {             -- List of various plugins and additional options
--         --   -- ...
--         -- },
--     },
--     palettes = {},
--     specs = {},
--     groups = {},
-- })

-- require("monokai-pro").setup({
--     transparent_background = false,
--     terminal_colors = true,
--     devicons = true, -- highlight the icons of `nvim-web-devicons`
--     styles = {
--         comment = { italic = true },
--         keyword = { italic = true }, -- any other keyword
--         type = { italic = true },    -- (preferred) int, long, char, etc
--         storageclass = { italic = true }, -- static, register, volatile, etc
--         structure = { italic = true }, -- struct, union, enum, etc
--         parameter = { italic = true }, -- parameter pass in function
--         annotation = { italic = true },
--         tag_attribute = { italic = true }, -- attribute of tag in reactjs
--     },
--     -- filter = "spectrum",                   -- classic | octagon | pro | machine | ristretto | spectrum
--     -- Enable this will disable filter option
--     day_night = {
--         enable = true, -- turn off by default
--         -- day_filter = "classic",    -- classic | octagon | pro | machine | ristretto | spectrum
--         -- night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
--     },
--     inc_search = "background", -- underline | background
--     background_clear = {
--         -- "float_win",
--         "toggleterm",
--         "telescope",
--         "which-key",
--         "renamer",
--     }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree"
--     plugins = {
--         bufferline = {
--             underline_selected = false,
--             underline_visible = false,
--         },
--         indent_blankline = {
--             context_highlight = "pro", -- default | pro
--             context_start_underline = false,
--         },
--     },
--     -- @param c Colorscheme
--     -- override = function(c) end,
-- })

-- require('nightfox').load()
-- require('terafox').load()
-- vim.cmd.colorscheme("terafox")

-- vim.cmd.colorscheme("nightfox")
-- vim.cmd.colorscheme("terafox")
-- vim.cmd.colorscheme("duskfox")
-- vim.cmd.colorscheme("carbonfox")
-- vim.cmd.colorscheme("monokai-pro")
-- vim.cmd.colorscheme("monokai-pro-octagon")
