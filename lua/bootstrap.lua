vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "html", "css", "vue",
        "typescript", "typescriptreact",
        "javascript", "javascriptreact"
    },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end
})

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    filetype_exclude = { "dashboard" }
}

vim.cmd([[ let g:coc_global_extensions = [ 'coc-svg', 'coc-pyright' ] ]])
vim.cmd([[ inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>" ]])
vim.cmd([[ inoremap <silent><expr> <c-space> coc#refresh() ]])
vim.cmd([[ function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])

vim.cmd([[ inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR><c-r>=coc#on_enter()\<CR>" ]])
vim.cmd([[ inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ coc#expandableOrJumpable() ?
    \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ CheckBackspace() ? "\<TAB>" :
    \ coc#refresh()
]])


-- vim.g.startify_custom_header = 'startify#pad("as")'
vim.cmd([[ let g:ascii = [
\ '',
\ '',
\ '   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ',
\ '   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ',
\ '   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ',
\ '   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ',
\ '   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ',
\ '   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ',
\ '',
\ '']
]])
vim.cmd([[ let g:startify_custom_header = g:ascii ]])
vim.cmd([[ let g:startify_session_autoload = 1 ]])
vim.cmd([[ let g:startify_session_persistence = 1 ]])
vim.cmd([[ let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'files',     'header': ['   MRU']            },
    \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'commands',  'header': ['   Commands']       },
\ ]
]])

require('aerial').setup()

require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

require("colortils").setup()
require("colortils").setup({
    register = "+", -- Register in which color codes will be copied
    color_preview =  "███ %s", -- Preview for colors, if it contains `%s` this will be replaced with a hex color code of the color
    -- The default in which colors should be saved
    -- This can be hex, hsl or rgb
    default_format = "hex",
    border = "rounded", -- Border for the float
    mappings = { -- Some mappings which are used inside the tools
        increment = "l", -- increment values
        decrement = "h", -- decrement values
        increment_big = "L", -- increment values with bigger steps
        decrement_big = "H", -- decrement values with bigger steps
        min_value = "0", -- set values to the minimum
        max_value = "$", -- set values to the maximum
        set_register_default_format = "<cr>", -- save the current color in the register specified above with the format specified above
        set_register_cjoose_format = "g<cr>", -- save the current color in the register specified above with a format you can choose
        replace_default_format = "<m-cr>", -- replace the color under the cursor with the current color in the format specified above
        replace_choose_format = "g<m-cr>", -- replace the color under the cursor with the current color in a format you can choose
        export = "E", -- export the current color to a different tool
        set_value = "c", -- set the value to a certain number (done by just entering numbers)
        transparency = "T", -- toggle transparency
        choose_background = "B", -- choose the background (for transparent colors)
    }
})

require('zen-mode').setup({
    window = {
        backdrop = 0.8,
        width = 160,
    }
})

require('nvim-treesitter.configs').setup({
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    }
})

require('nvim_comment').setup({
    hook = function()
        if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
            require("ts_context_commentstring.internal").update_commentstring()
        end
    end
})

require('nvim_comment').setup()
require("nvim-surround").setup()
require("toggleterm").setup{
    -- shading_factor = 1,
    shade_terminals = false,
    float_opts = {
        border = 'curved'
    },
    highlights = {
        Normal = {
            guibg = "#070C11",
        },
        NormalFloat = {
            guibg = "#070C11",
        }
    }
}
