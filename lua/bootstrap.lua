vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "html",
        "css",
        "scss",
        "vue",
        "json",
        "toml",
        "markdown",
        "javascriptvue",
        "typescriptvue",
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
    },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

vim.g.VM_maps = {
    ["I BS"] = "", -- disable backspace mapping, to resolve incompatibility with multi select
}

-- if not vim.g.neovide then
require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    -- presets = {
    --     bottom_search = false, -- use a classic bottom cmdline for search
    --     command_palette = true, -- position the cmdline and popupmenu together
    --     long_message_to_split = true, -- long messages will be sent to a split
    --     inc_rename = false,   -- enables an input dialog for inc-rename.nvim
    --     lsp_doc_border = false, -- add a border to hover docs and signature help
    -- },
})
-- end

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)  -- REQUIRED - you must specify a snippet engine
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
            menu = {
                path = "[Path]",
                nvim_lua = "[Lua]",
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
                -- luasnip = "[LuaSnip]",
                latex_symbols = "[Latex]",
            },
            -- fields = { "kind", "abbr", "menu" },
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization.
            -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))

            -- before = function (entry, vim_item)
            --     return vim_item
            -- end
        }),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = function(fallback)
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
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
        { name = "path" },
        { name = "nvim_lsp" },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = "luasnip" }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.formatting.taplo,
        -- null_ls.builtins.formatting.yq,
        null_ls.builtins.formatting.beautysh,
        -- null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.blue,
        null_ls.builtins.formatting.ruff.with({
            extra_args = { "--ignore-unused" },
        }),
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.lua_format,
        -- null_ls.builtins.diagnostics.cpplint,
        -- null_ls.builtins.formatting.clang_format,
        -- null_ls.builtins.formatting.astyle,
        -- null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.mdformat,
        -- null_ls.builtins.formatting.eslint_d,
        -- null_ls.builtins.formatting.jq,
        -- null_ls.builtins.diagnostics.vulture,
        null_ls.builtins.hover.dictionary,
        -- null_ls.builtins.diagnostics.mypy.with({
        --     extra_args = { "--ignore-missing-imports" },
        -- }),
        -- null_ls.builtins.diagnostics.pycodestyle,
        -- null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.code_actions.refactoring, -- go, javascript, lua, python, typescript
        -- null_ls.builtins.diagnostics.luacheck,
        -- {
        --     name = 'blackd',
        --     method = null_ls.methods.FORMATTING,
        --     filetypes = { 'python' },
        --     generator = require("null-ls.helpers").formatter_factory {
        --         command = 'blackd-client',
        --         to_stdin = true,
        --     },
        -- }
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})

local navic = require("nvim-navic")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly = false,
}

local lsp_on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    if client.server_capabilities.documentSymbolProvider then
        -- Use only Pyright
        if client.config.name ~= "jedi_language_server" then
            navic.attach(client, bufnr)
        end
    end

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gsh", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)

    -- client.server_capabilities.documentFormattingProvider = false
end

local lsp_flags = {
    debounce_text_changes = 150,
}

-- For C++ in Ubuntu: sudo apt install g++-12
local lspservers = {
    "bashls",
    "awk_ls",
    "lua_ls",
    "pyright",
    "jedi_language_server",
    "ruff_lsp",
    "graphql",
    "yamlls",
    "cmake",
    "clangd",
    "rust_analyzer",
    "marksman",
    "cssmodules_ls",
    "biome",
    "eslint",
    "emmet_language_server",
    "html",
    "tsserver",
    "jsonls",
    "volar",
    "dockerls",
}

for _, lsp in pairs(lspservers) do
    require("lspconfig")[lsp].setup({
        on_attach = lsp_on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
    })
end

require("lspconfig")["arduino_language_server"].setup({
    on_attach = lsp_on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    cmd = {
        HOMEDIR .. "/go/bin/arduino-language-server",
        "-clangd",
        HOMEDIR .. "/.local/share/nvim/mason/bin/clangd",
        "-cli",
        HOMEDIR .. "/bin/arduino-cli",
        "-cli-config",
        HOMEDIR .. "/.arduino15/arduino-cli.yaml",
        -- "-fqbn", "Seeeduino:samd:seeed_XIAO_m0",
        -- "-fqbn", "arduino:avr:uno",
        -- "-fqbn", "rp2040:rp2040:rpipicow",
        "-fqbn",
        "esp8266:esp8266:nodemcuv2",
    },
})

require("lspconfig")["cssls"].setup({
    on_attach = lsp_on_attach,
    capabilities = capabilities,
    settings = {
        validate = true,
        css = {
            lint = { unknownAtRules = "ignore" },
        },
    },
    flags = lsp_flags,
})

require("lspconfig")["tailwindcss"].setup({
    on_attach = function(client, bufnr)
        require("tailwindcss-colors").buf_attach(bufnr)
    end,
    capabilities = capabilities,
    flags = lsp_flags,
})

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ("  %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

require("ufo").setup({
    open_fold_hl_timeout = 250,
    enable_get_fold_virt_text = true,
    close_fold_kinds = { "imports", "comment" },
    preview = {
        win_config = {
            -- border = {'', '─', '', '', '', '─', '', ''},
            border = "rounded",
            winhighlight = "Normal:Folded",
            -- winhighlight = 'Normal:Normal',
            winblend = 12,
            maxheight = 20,
        },
        -- mappings = {
        --     scrollU = "<C-u>",
        --     scrollD = "<C-d>",
        --     jumpTop = "[",
        --     jumpBot = "]",
        -- },
    },
    fold_virt_text_handler = handler,
    provider_selector = function(bufnr, filetype, buftype)
        -- if you prefer treesitter provider rather than lsp,
        -- return ftMap[filetype] or {'treesitter', 'indent'}
        return { "treesitter", "indent" }
        -- return ftMap[filetype]
    end,
})
-- End Folder

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
            return
        end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float(table, {
        scope = "cursor",
        focusable = false,
        close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
            "WinLeave",
        },
    })
end

local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
})
-- require('lspconfig.ui.windows').default_options.border = 'rounded'

vim.cmd([[ let g:startify_custom_header = g:boot_ascii ]])
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

require("gitsigns").setup({
    signs = {
        add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true,   -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },
})

-- local helpers = require("null-ls.helpers")
-- helpers.generator_factory()

-- require("colortils").setup()
-- require("colortils").setup({
--     register = "+", -- Register in which color codes will be copied
--     color_preview = "███ %s", -- Preview for colors, if it contains `%s` this will be replaced with a hex color code of the color
--     -- The default in which colors should be saved
--     -- This can be hex, hsl or rgb
--     default_format = "hex",
--     border = "rounded",                 -- Border for the float
--     mappings = {                        -- Some mappings which are used inside the tools
--         increment = "l",                -- increment values
--         decrement = "h",                -- decrement values
--         increment_big = "L",            -- increment values with bigger steps
--         decrement_big = "H",            -- decrement values with bigger steps
--         min_value = "0",                -- set values to the minimum
--         max_value = "$",                -- set values to the maximum
--         set_register_default_format = "<cr>", -- save the current color in the register specified above with the format specified above
--         set_register_cjoose_format = "g<cr>", -- save the current color in the register specified above with a format you can choose
--         replace_default_format = "<m-cr>", -- replace the color under the cursor with the current color in the format specified above
--         replace_choose_format = "g<m-cr>", -- replace the color under the cursor with the current color in a format you can choose
--         export = "E",                   -- export the current color to a different tool
--         set_value = "c",                -- set the value to a certain number (done by just entering numbers)
--         transparency = "T",             -- toggle transparency
--         choose_background = "B",        -- choose the background (for transparent colors)
--     },
-- })
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
        spacing = 5,
        severity_limit = "Warning",
    },
    update_in_insert = true,
})

require("nvim-treesitter.configs").setup({
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    highlight = {
        enable = true,
        disable = { "" },
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = { "yaml" },
    },
    autotag = {
        enable = true,
    },
})

-- Select Python venv
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
