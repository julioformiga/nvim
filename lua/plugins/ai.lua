return {
	{
		"https://github.com/yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		opts = {
			-- add any opts here
			mode = "legacy",
			-- mode = "agentic",
			-- selector = {
			-- 	exclude_auto_select = { "NvimTree" },
			-- },
			cursor_applying_provider = nil, -- The provider used in the applying phase of Cursor Planning Mode, defaults to nil, when nil uses Config.provider as the provider for the applying phase
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			-- provider = "gemini",
			-- provider = "openai",
			provider = "copilot",
			-- provider = "claude",
			-- provider = "deepseek",
			auto_suggestions_provider = "copilot",
			providers = {
				copilot = {
					endpoint = "https://api.githubcopilot.com",
					model = "claude-sonnet-4",
					-- model = "claude-3.7-sonnet",
					-- model = "gpt-4o-2024-08-06",
					timeout = 30000,
					disable_tools = true,
					extra_request_body = {
						temperature = 0,
						max_tokens = 8192,
					},
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
					extra_request_body = {
						temperature = 0,
						max_tokens = 8000,
					},
					-- api_key_name = "cmd:pass ANTHROPIC_API_KEY",
				},
				openai = {
					endpoint = "https://api.openai.com/v1",
					model = "gpt-4o-mini",
					api_key_name = "cmd:pass OPENAI_API_KEY",
				},
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
				minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
				enable_token_counting = true, -- Whether to enable token counting. Default to true.
			},
			mappings = {
				ask = "<leader>/",
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
				suggestion = {
					accept = "<M-m>",
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
				cancel = {
					normal = { "<C-c>", "<Esc>", "q" },
					insert = { "<C-c>" },
				},
				sidebar = {
					apply_all = "A",
					apply_cursor = "a",
					retry_user_request = "r",
					edit_user_request = "e",
					switch_windows = "<Tab>",
					reverse_switch_windows = "<S-Tab>",
					remove_file = "d",
					add_file = "@",
					close = { "<Esc>", "q" },
					close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
				},
			},
			hints = { enabled = true },
			windows = {
				---@type "right" | "left" | "top" | "bottom"
				position = "right", -- the position of the sidebar
				wrap = true, -- similar to vim.o.wrap
				width = 30, -- default % based on available width
				sidebar_header = {
					enabled = true, -- true, false to enable/disable the header
					align = "center", -- left, center, right for title
					rounded = true,
				},
				input = {
					prefix = "> ",
					height = 8, -- Height of the input window in vertical layout
				},
				edit = {
					border = "rounded",
					start_insert = true, -- Start insert mode when opening the edit window
				},
				ask = {
					floating = false, -- Open the 'AvanteAsk' prompt in a floating window
					start_insert = true, -- Start insert mode when opening the ask window
					border = "rounded",
					---@type "ours" | "theirs"
					focus_on_apply = "ours", -- which diff to focus after applying
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
				--- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
				--- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
				--- Disable by setting to -1.
				override_timeoutlen = 500,
			},
			suggestion = {
				debounce = 600,
				throttle = 600,
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
						-- use_absolute_path = false,
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
