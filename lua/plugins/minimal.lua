return {
	"https://github.com/mhinz/vim-startify",
	"https://github.com/stevearc/dressing.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	{
		"https://github.com/folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
	},
	{
		"https://github.com/williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"https://github.com/williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
		end,
	},
	{
		"https://github.com/nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"https://github.com/nvim-lua/plenary.nvim",
			"https://github.com/nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"https://github.com/MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<C-Space>", "<cmd>Neotree left toggle<cr>", desc = "Filesystem Lateral" },
			{ "<A-e>", "<cmd>Neotree float toggle<cr>", desc = "Filesystem Float" },
		},
		config = function()
			require("neo-tree").setup({
				filesystem = {
					window = {
						mappings = {
							["o"] = "system_open",
						},
					},
					commands = {
						system_open = function(state)
							local node = state.tree:get_node()
							local path = node:get_id()
							-- macOs: open file in default application in the background.
							-- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
							vim.api.nvim_command("silent !open -g " .. path)
							-- Linux: open file in default application
							vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
						end,
					},
				},
			})
		end,
	},
	{
		"https://github.com/nvim-telescope/telescope.nvim",
		lazy = false,
		keys = {
			{ "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find files" },
			{ "<leader>fg", "<CMD>Telescope live_grep<CR>", desc = "Find in files" },
			{ "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fh", "<CMD>Telescope help_tags<CR>", desc = "Help tags" },
			{ "<leader>tr", "<cmd>Telescope registers<cr>", desc = "Registers" },
			-- { "<leader>tc", "<cmd>Telescope colorscheme<cr>", desc = "Color Schemes" },
			{ "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = { ["<A-q>"] = require("telescope.actions").close },
						n = { ["<A-q>"] = require("telescope.actions").close },
					},
				},
			})
		end,
	},
	{
		"https://github.com/folke/neoconf.nvim",
		cmd = "Neoconf",
	},
	{
		"https://github.com/preservim/tagbar",
		keys = {
			{ "<leader>o", "<CMD>TagbarOpenAutoClose<CR>", desc = "Tagbar" },
		},
	},
	{
		"https://github.com/folke/noice.nvim",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"https://github.com/MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"https://github.com/rcarriga/nvim-notify",
		},
		config = function()
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
		end,
	},
	{
		"https://github.com/rcarriga/nvim-notify",
		opts = {
			render = "compact",
			top_down = false,
			timeout = 2000,
		},
	},
	{
		"https://github.com/kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>gg", "<CMD>LazyGitCurrentFile<CR>", desc = "Lazygit" },
		},
	},
	{
		"https://github.com/akinsho/toggleterm.nvim",
		event = "BufEnter",
		keys = {
			{ "<A-1>", "<CMD>1ToggleTerm direction=float<CR>", desc = "Terminal float" },
			{ "<A-2>", "<CMD>2ToggleTerm direction=horizontal<CR>", desc = "Terminal horizontal" },
			{ "<A-3>", "<CMD>3ToggleTerm direction=float<CR>", desc = "Terminal 2 float" },
		},
		config = function()
			require("toggleterm").setup({
				-- shading_factor = 1,
				shade_terminals = false,
				float_opts = {
					border = "curved",
				},
				highlights = {
					Normal = {
						guibg = "#0d0d0d",
						guifg = "#4CB013",
						-- guifg = "#A4FF4F",
					},
					NormalFloat = {
						guibg = "#0d0d0d",
						guifg = "#4CB013",
						-- guifg = "#A4FF4F",
					},
				},
				persist_mode = false,
				winbar = {
					enable = true,
				},
			})
		end,
	},
	{
		"https://github.com/stevearc/aerial.nvim",
		keys = {
			{ "<leader>a", "<CMD>AerialToggle float<cr>", desc = "Aerial float" },
		},
		config = function()
			require("aerial").setup({
				autojump = true,
				close_on_select = true,
			})
		end,
	},
	{
		"https://github.com/ellisonleao/glow.nvim",
		config = function()
			require("glow").setup()
		end,
	},
	{
		"https://github.com/ziontee113/icon-picker.nvim",
		keys = {
			{ "<leader>i", "<cmd>IconPickerInsert emoji<cr>", desc = "Select icon" },
		},
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true,
			})
		end,
	},
}
