return {
	{
		"https://github.com/yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		opts = {
			-- add any opts here
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			-- provider = "gemini",
			-- provider = "openai",
			provider = "copilot",
			-- provider = "claude",
			-- provider = "deepseek",
			auto_suggestions_provider = "copilot",
			copilot = {
				endpoint = "https://api.githubcopilot.com",
				model = "claude-3.5-sonnet",
				-- model = "gpt-4o-2024-08-06",
				temperature = 0,
				max_tokens = 8000,
			},
			gemini = {
				api_key_name = "cmd:pass GEMINI_API_KEY",
				model = "gpt-4o-2024-08-06",
			},
			claude = {
				-- endpoint = "https://api.anthropic.com",
				endpoint = "https://api.githubcopilot.com",
				-- model = "claude-3-5-sonnet-20241022",
				model = "claude-3.5-sonnet",
				temperature = 0,
				max_tokens = 8000,
				-- api_key_name = "cmd:pass ANTHROPIC_API_KEY",
			},
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o-mini",
				api_key_name = "cmd:pass OPENAI_API_KEY",
			},
			vendors = {
				deepseek = {
					__inherited_from = "openai",
					endpoint = "https://api.deepseek.com",
					model = "deepseek-coder",
					api_key_name = "cmd:pass DEEPSEEK_API_KEY",
				},
			},
			behaviour = {
				auto_suggestions = false, -- Experimental stage
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = false,
			},
			mappings = {
				--- @class AvanteConflictMappings
				ask = "<leader>/",
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
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
				---@type "right" | "left" | "top" | "bottom"
				position = "right",
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
		build = "make", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
		-- build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
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
	-- {
	-- 	"https://github.com/olimorris/codecompanion.nvim",
	-- 	dependencies = {
	-- 		"https://github.com/nvim-lua/plenary.nvim",
	-- 		"https://github.com/nvim-treesitter/nvim-treesitter",
	-- 		"https://github.com/hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
	-- 		"https://github.com/nvim-telescope/telescope.nvim", -- Optional: For using slash commands
	-- 		{ "https://github.com/stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
	-- 	},
	-- 	opts = {
	-- 		strategies = {
	-- 			inline = {
	-- 				adapter = "copilot",
	-- 			},
	-- 			agent = {
	-- 				adapter = "anthropic",
	-- 			},
	-- 		},
	-- 	},
	-- 	config = true,
	-- },
}
