local navic = require("nvim-navic")
-- navic.setup {
--     highlight = false
-- }
local breadcrumbs = {
    function()
        return navic.get_location()
    end,
    cond = function()
        return navic.is_available()
    end
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {
                'startify',
                'toggleterm',
                'neo-tree',
            },
            winbar = {
                'startify',
                'toggleterm',
                'neo-tree',
            },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
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
        lualine_a = { 'filename' },
        lualine_b = { breadcrumbs },
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = { 'filename' },
        lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {}
    },
    extensions = { 'toggleterm', 'nvim-dap-ui', 'neo-tree', 'aerial' }
}

require('bufferline').setup {
    options = {
        mode = "buffers",                    -- set to "tabs" to only show tabpages instead
        numbers = "none",                    -- "buffer_id"
        close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
        indicator = {
            icon = '▎',                    -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true,  -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = "coc",
        diagnostics_update_in_insert = false,
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                text_align = "center",
                separator = true
            }
        },
        color_icons = true,              -- whether or not to add the filetype icon highlights
        show_buffer_icons = true,        -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
        persist_buffer_sort = true,   -- whether or not custom sorted buffers should persist
        separator_style = "slant",    -- "slant" | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
        },
        sort_by = 'insert_at_end'
        -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
    }
}

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
        -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    term_colors = false,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.1,
    },
    no_italic = false, -- Force no italic
    no_bold = false,   -- Force no bold
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
-- require('catppuccin-macchiato').load()
vim.cmd.colorscheme "catppuccin-macchiato"

-- Default options
require('nightfox').setup({
    options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = false,               -- Disable setting background
        terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = true,               -- Non focused panes set to alternative background
        module_default = true,             -- Default enable value for modules
        styles = {
            -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "bold",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "italic,bold",
            variables = "NONE",
        },
        inverse = {
            -- Inverse highlight for different types
            match_parent = false,
            visual = false,
            search = false,
        },
        -- modules = {             -- List of various plugins and additional options
        --   -- ...
        -- },
    },
    palettes = {},
    specs = {},
    groups = {},
})

require("monokai-pro").setup({
    transparent_background = false,
    terminal_colors = true,
    devicons = true, -- highlight the icons of `nvim-web-devicons`
    styles = {
        comment = { italic = true },
        keyword = { italic = true },       -- any other keyword
        type = { italic = true },          -- (preferred) int, long, char, etc
        storageclass = { italic = true },  -- static, register, volatile, etc
        structure = { italic = true },     -- struct, union, enum, etc
        parameter = { italic = true },     -- parameter pass in function
        annotation = { italic = true },
        tag_attribute = { italic = true }, -- attribute of tag in reactjs
    },
    filter = "spectrum",                   -- classic | octagon | pro | machine | ristretto | spectrum
    -- Enable this will disable filter option
    day_night = {
        enable = false,            -- turn off by default
        day_filter = "classic",    -- classic | octagon | pro | machine | ristretto | spectrum
        night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
    },
    inc_search = "background",     -- underline | background
    background_clear = {
        -- "float_win",
        "toggleterm",
        "telescope",
        "which-key",
        "renamer"
    }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree"
    plugins = {
        bufferline = {
            underline_selected = false,
            underline_visible = false,
        },
        indent_blankline = {
            context_highlight = "pro", -- default | pro
            context_start_underline = false,
        },
    },
    -- @param c Colorscheme
    -- override = function(c) end,
})

-- require('nightfox').load()
-- require('terafox').load()
-- vim.cmd.colorscheme "terafox"

-- require('onedark').setup {
--     style = 'warmer',
-- }
-- require('onedark').load()

-- vim.cmd.colorscheme "catppuccin-mocha"
-- vim.cmd.colorscheme "onedark_vivid"
-- vim.cmd.colorscheme "onedark_dark"
vim.cmd.colorscheme "nightfox"
-- vim.cmd.colorscheme "terafox"
-- vim.cmd.colorscheme "duskfox"
-- vim.cmd.colorscheme "carbonfox"
-- vim.cmd.colorscheme "vscode"
-- vim.cmd.colorscheme "monokai-pro"
