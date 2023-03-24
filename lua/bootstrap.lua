vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "html", "css", "scss", "vue", "json",
        "javascriptvue", "typescriptvue",
        "typescript", "typescriptreact",
        "javascript", "javascriptreact"
    },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end
})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*"},
    command = [[%s/\s\+$//e]]
})

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    filetype_exclude = { "dashboard" }
}

require("mason").setup()
require("mason-lspconfig").setup()

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args) -- REQUIRED - you must specify a snippet engine
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
            menu = ({
                path = "[Path]",
                nvim_lua = "[Lua]",
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
                -- luasnip = "[LuaSnip]",
                latex_symbols = "[Latex]",
            }),
            -- fields = { "kind", "abbr", "menu" },
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization.
            -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))

            -- before = function (entry, vim_item)
            --     return vim_item
            -- end
        })
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
local lsp_flags = {
    debounce_text_changes = 250,
}

-- Backend -------------
require("lspconfig")["pyright"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
}
require("lspconfig")["graphql"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
}
require("lspconfig")["ruff_lsp"].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
}
require("lspconfig")["arduino_language_server"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    cmd = {
        "/home/julio/go/bin/arduino-language-server",
        "-clangd", "/usr/bin/clangd",
        "-cli", "/usr/local/bin/arduino-cli",
        "-cli-config", "/home/julio/.arduino15/arduino-cli.yaml",
        -- "-fqbn", "Seeeduino:samd:seeed_XIAO_m0",
        -- "-fqbn", "arduino:avr:uno",
        "-fqbn", "rp2040:rp2040:rpipicow",
    }
}
require("lspconfig")["clangd"].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
}

-- Frontend -------------
require("lspconfig")["marksman"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
})
require("lspconfig")["cssls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
})
require("lspconfig")["cssmodules_ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
})
require("lspconfig")["rome"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
})
require("lspconfig")["eslint"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
})
require("lspconfig")["emmet_ls"].setup({
    capabilities = capabilities,
    flags = lsp_flags
})
require("lspconfig")["tsserver"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
})
require("lspconfig")["volar"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
})
require("lspconfig")["tailwindcss"].setup({
    on_attach = function(client, bufnr)
        require("tailwindcss-colors").buf_attach(bufnr)
    end,
    capabilities = capabilities,
    flags = lsp_flags
})
local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
require("nvim-autopairs").setup()
require('nvim-ts-autotag').setup()

require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

require('codicons').setup()

-- require("dap").setup()
-- local dap = require('dap')
-- dap.configurations.python = {
--   {
--     type = 'python';
--     request = 'launch';
--     name = "Launch file";
--     program = "${file}";
--     pythonPath = function()
--       return '/usr/bin/python'
--     end;
--   },
-- }
require('dap-python').setup('.venv/bin/python')
require("nvim-dap-virtual-text").setup()
require("dapui").setup()
-- require("dapui").open()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

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

-- require("colortils").setup()
-- require("colortils").setup({
--     register = "+", -- Register in which color codes will be copied
--     color_preview =  "███ %s", -- Preview for colors, if it contains `%s` this will be replaced with a hex color code of the color
--     -- The default in which colors should be saved
--     -- This can be hex, hsl or rgb
--     default_format = "hex",
--     border = "rounded", -- Border for the float
--     mappings = { -- Some mappings which are used inside the tools
--         increment = "l", -- increment values
--         decrement = "h", -- decrement values
--         increment_big = "L", -- increment values with bigger steps
--         decrement_big = "H", -- decrement values with bigger steps
--         min_value = "0", -- set values to the minimum
--         max_value = "$", -- set values to the maximum
--         set_register_default_format = "<cr>", -- save the current color in the register specified above with the format specified above
--         set_register_cjoose_format = "g<cr>", -- save the current color in the register specified above with a format you can choose
--         replace_default_format = "<m-cr>", -- replace the color under the cursor with the current color in the format specified above
--         replace_choose_format = "g<m-cr>", -- replace the color under the cursor with the current color in a format you can choose
--         export = "E", -- export the current color to a different tool
--         set_value = "c", -- set the value to a certain number (done by just entering numbers)
--         transparency = "T", -- toggle transparency
--         choose_background = "B", -- choose the background (for transparent colors)
--     }
-- })
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
        },
        update_in_insert = true,
    }
)
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
    },
    autotag = {
        enable = true
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
    },
    winbar = {
        enable = true
    }
}
require("color-picker").setup()
