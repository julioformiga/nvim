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
			winbar = {
				"startify",
				"toggleterm",
				"neo-tree",
				"dap-repl",
				"dapui_console",
				-- "dapui_watches",
				-- "dapui_stacks",
				-- "dapui_breakpoints",
				-- "dapui_scopes",
				"Avante",
				"AvanteInput",
			},
			statusline = {
				"startify",
				"toggleterm",
				"neo-tree",
				"dap-repl",
				-- "dapui_console",
				"dapui_watches",
				"dapui_stacks",
				"dapui_breakpoints",
				"dapui_scopes",
				"Avante",
				"AvanteInput",
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
		lualine_c = { { require("NeoComposer.ui").status_recording }, { "filename", path = 4 } },
		lualine_x = {
			{
				"venv-selector",
				cond = function()
					return vim.tbl_contains({ "python", "toml" }, vim.bo.filetype)
				end,
			},
			{
				"Auto_compile_status()",
				cond = function()
					return vim.tbl_contains({ "c", "cpp", "make" }, vim.bo.filetype)
				end,
			},
			{ "filetype", icon_only = false },
			"encoding",
		},
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
