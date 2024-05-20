return {
	{
		"https://github.com/catppuccin/nvim",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = {
					light = "latte",
					dark = "mocha",
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
				color_overrides = {
					-- mocha = {
					--     base = "#161621",
					--     mantle = "#161621",
					--     crust = "#161621",
					-- },
				},
				custom_highlights = {},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = false,
					telescope = true,
					notify = false,
					mini = false,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
			-- require("catppuccin").load()
			-- vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"https://github.com/rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				-- colors = { -- add/modify theme and palette colors
				-- 	palette = {},
				-- 	theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				-- },
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
				colors = {
					palette = {
						-- change all usages of these colors
						-- sumiInk0 = "#000000",
						fujiWhite = "#FFFFFF",
					},
					theme = {
						-- change specific usages for a certain theme, or for all of them
						wave = {
							ui = {
								float = {
									bg = "none",
								},
							},
						},
						dragon = {
							syn = {
								parameter = "yellow",
							},
						},
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
			})

			-- require("kanagawa").load()
			-- vim.cmd("colorscheme kanagawa-dragon")
			-- vim.cmd("colorscheme kanagawa-wave")
		end,
	},
	{
		"https://github.com/EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				options = {
					-- Compiled file's destination location
					compile_path = vim.fn.stdpath("cache") .. "/nightfox",
					compile_file_suffix = "_compiled", -- Compiled file suffix
					transparent = false, -- Disable setting background
					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
					dim_inactive = true, -- Non focused panes set to alternative background
					module_default = true, -- Default enable value for modules
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
			require("nightfox").load()
			-- vim.cmd.colorscheme("nightfox")
			-- vim.cmd.colorscheme("carbonfox")
			vim.cmd.colorscheme("duskfox")
		end,
	},
	{
		"https://github.com/loctvl842/monokai-pro.nvim",
		config = function()
			require("monokai-pro").setup({
				transparent_background = false,
				terminal_colors = true,
				devicons = true, -- highlight the icons of `nvim-web-devicons`
				styles = {
					comment = { italic = true },
					keyword = { italic = true }, -- any other keyword
					type = { italic = true }, -- (preferred) int, long, char, etc
					storageclass = { italic = true }, -- static, register, volatile, etc
					structure = { italic = true }, -- struct, union, enum, etc
					parameter = { italic = true }, -- parameter pass in function
					annotation = { italic = true },
					tag_attribute = { italic = true }, -- attribute of tag in reactjs
				},
				-- filter = "spectrum",                   -- classic | octagon | pro | machine | ristretto | spectrum
				-- Enable this will disable filter option
				day_night = {
					enable = true, -- turn off by default
					-- day_filter = "classic",    -- classic | octagon | pro | machine | ristretto | spectrum
					-- night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
				},
				inc_search = "background", -- underline | background
				background_clear = {
					-- "float_win",
					"toggleterm",
					"telescope",
					"which-key",
				}, -- "float_win", "toggleterm", "telescope", "which-key", "neo-tree"
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
			-- require("monokai-pro").load()
			-- vim.cmd.colorscheme("monokai-pro")
		end,
	},
}
