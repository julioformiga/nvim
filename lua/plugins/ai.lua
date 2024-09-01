return {
	{
		"https://github.com/yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		opts = {
			-- add any opts here
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "copilot",
			-- claude = {
			-- 	endpoint = "https://api.anthropic.com",
			-- 	model = "claude-3-5-sonnet-20240620",
			-- 	temperature = 0,
			-- 	max_tokens = 4096,
			-- },
			mappings = {
				--- @class AvanteConflictMappings
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
			},
			hints = { enabled = true },
			windows = {
				wrap = true, -- similar to vim.o.wrap
				width = 30, -- default % based on available width
				sidebar_header = {
					align = "center", -- left, center, right for title
					rounded = true,
				},
			},
			highlights = {
				---@type AvanteConflictHighlights
				diff = {
					current = "DiffText",
					incoming = "DiffAdd",
				},
			},
			--- @class AvanteConflictUserConfig
			diff = {
				autojump = true,
				---@type string | fun(): any
				list_opener = "copen",
			},
		},
		build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
		dependencies = {
			"https://github.com/stevearc/dressing.nvim",
			"https://github.com/nvim-lua/plenary.nvim",
			"https://github.com/MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"https://github.com/nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"https://github.com/zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"https://github.com/HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to setup it properly if you have lazy=true
				"https://github.com/MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}
