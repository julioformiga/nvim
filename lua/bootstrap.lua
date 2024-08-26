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

vim.api.nvim_create_autocmd("FileType", {
	desc = "Auto select virtualenv Nvim open",
	pattern = { "python", "toml" },
	callback = function()
		local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
		if venv ~= "" then
			require("venv-selector").retrieve_from_cache()
		end
	end,
	once = true,
})

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

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

vim.g.VM_maps = {
	["I BS"] = "", -- disable backspace mapping, to resolve incompatibility with multi select
}

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local has_words_before_copilot = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

lspkind.init({
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-- require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

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
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
			symbol_map = { Copilot = "" },
			menu = {
				path = "[Path]",
				nvim_lua = "[Lua]",
				nvim_lsp = "[LSP]",
				buffer = "[Buffer]",
				luasnip = "[LuaSnip]",
				latex_symbols = "[Latex]",
			},
			before = require("tailwind-tools.cmp").lspkind_format,
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
	-- mapping = cmp.mapping.preset.insert({
	-- remove default mappings (like arrows)
	mapping = cmp.mapping({
		["<Tab>"] = function(fallback)
			if cmp.visible() and has_words_before_copilot() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif cmp.visible() then
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
		-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "copilot" },
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = true,
	lineFoldingOnly = false,
}

local navic = require("nvim-navic")
local lsp_on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

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
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("v", "<leader>r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	client.server_capabilities.documentFormattingProvider = false
end

local lsp_flags = {
	debounce_text_changes = 500,
}

-- For C++ in Ubuntu: sudo apt install g++-12
local lspservers = {
	"bashls",
	"awk_ls",
	"lua_ls",
	"pyright",
	"ruff_lsp",
	"cmake",
	-- "cpptools",
	"rust_analyzer",
	"marksman",
	"biome",
	"emmet_language_server",
	"tsserver",
	"eslint",
	"volar",
	"dockerls",
	"html",
	"graphql",
	"jsonls",
	"yamlls",
	"jqls",
}

for _, lsp in pairs(lspservers) do
	require("lspconfig")[lsp].setup({
		on_attach = lsp_on_attach,
		capabilities = capabilities,
		flags = lsp_flags,
	})
end

require("lspconfig")["clangd"].setup({
	on_attach = lsp_on_attach,
	capabilities = capabilities,
	flags = lsp_flags,
	cmd = {
		-- "clangd",
		"/usr/bin/clangd",
		"--offset-encoding=utf-16",
	},
})

require("lspconfig")["arduino_language_server"].setup({
	on_attach = lsp_on_attach,
	capabilities = capabilities,
	flags = lsp_flags,
	cmd = {
		HOMEDIR .. "/.local/share/nvim/mason/bin/arduino-language-server",
		"-clangd",
		HOMEDIR .. "/.local/share/nvim/mason/bin/clangd",
		"-cli",
		"/usr/bin/arduino-cli",
		"-cli-config",
		HOMEDIR .. "/.arduino15/arduino-cli.yaml",
		-- "-fqbn", "Seeeduino:samd:seeed_XIAO_m0",
		"-fqbn",
		-- "arduino:avr:uno",
		"arduino:avr:mega",
		-- "-fqbn", "rp2040:rp2040:rpipicow",
		-- "-fqbn", "esp8266:esp8266:nodemcuv2",
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

require("gitsigns").setup({
	-- signs = {
	-- 	add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	-- 	change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	-- 	delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
	-- 	topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
	-- 	changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	-- 	untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	-- },
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
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
	-- yadm = {
	-- 	enable = false,
	-- },
})

-- local helpers = require("null-ls.helpers")
-- helpers.generator_factory()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	-- virtual_text = false,
	virtual_text = {
		spacing = 5,
		prefix = "",
		severity = "Error",
		-- min_severity = "Error"
	},
	update_in_insert = true,
})
require("telescope").load_extension("macros")
