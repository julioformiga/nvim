return {
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lua",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/onsails/lspkind.nvim",
	"https://github.com/RRethy/vim-illuminate",
	{
		"https://github.com/p00f/clangd_extensions.nvim",
		lazy = false,
		config = function()
			require("clangd_extensions").setup()
		end,
	},
	{
		"https://github.com/stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				arduino = { "clang_format" },
				cmake = { "cmake-lint", "cmake-format" },
				cpp = { "clang_format" },
				-- sh = { "beautysh" },
				lua = { "stylua" },
				toml = { "taplo" },
				-- python = { "ruff_fix", "ruff_format" },
				python = { "ruff_format" },
				html = { "prettierd", "biome" },
				vue = { "prettierd" },
				css = { "prettierd", "biome" },
				json = { "prettierd", "biome" },
				jsonc = { "prettierd", "biome" },
				javascript = { "prettierd", "biome" },
				typescript = { "prettierd", "biome" },
				typescriptreact = { "prettierd", "biome" },
			},
			-- formatters = {
			-- 	ruff_fix = { args = { "--ignore-unused" } },
			-- },
			format_on_save = function(bufnr)
				-- Disable autoformat on certain filetypes
				local ignore_filetypes = { "c", "cpp" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end

				return { timeout_ms = 500, lsp_fallback = true }
			end,
		},
	},
	{
		"https://github.com/L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
	},
	-- {
	-- 	"https://github.com/MoulatiMehdi/nvim-norminette",
	-- 	config = function()
	-- 		local norm = require("norminette")
	--
	-- 		norm.setup({
	-- 			header_on_save = true,
	-- 			format_on_save = true,
	-- 		})
	--
	-- 		vim.keymap.set("n", "<leader>nd", function()
	-- 			norm.check_norms()
	-- 		end, { desc = "Update 42norms diagnostics", noremap = true, silent = true })
	--
	-- 		vim.keymap.set("n", "<leader>nf", function()
	-- 			norm.format()
	-- 		end, { desc = "Format buffer on 42norms", noremap = true, silent = true })
	--
	-- 		vim.keymap.set("n", "<F1>", function()
	-- 			norm.stdheader()
	-- 		end, { desc = "Insert 42header", noremap = true, silent = true })
	-- 	end,
	-- },
	{
		"https://github.com/julioformiga/norminette42.nvim",
		-- "https://github.com/hardyrafael17/norminette42.nvim",
		lazy = false,
		-- event = "BufRead",
		keys = {
			{ "<F1>", "<CMD>Header42<CR>", desc = "Add 42 header" },
			{ "<leader>ne", "<CMD>NorminetteEnable<CR>", desc = "Norminette Enable" },
			{ "<leader>nd", "<CMD>NorminetteDisable<CR>", desc = "Norminette Disable" },
		},
		config = function()
			require("norminette").setup({
				runOnSave = true,
				maxErrorsToShow = 10,
				active = true,
			})
			vim.schedule(function()
				vim.cmd("NorminetteDisable")
			end)
		end,
	},
	-- {
	-- 	"https://github.com/MrSloth-dev/42-NorminetteNvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "echasnovski/mini.icons" },
	-- 	-- dir = "~/Projects/42-NorminetteNvim/",
	-- 	config = function()
	-- 		require("norminette").setup({
	-- 			keybind = "<leader>n",
	-- 			diagnost_color = "#00ff00",
	-- 		})
	-- 	end,
	-- },
	{
		"https://github.com/linux-cultist/venv-selector.nvim",
		dependencies = {
			"http://github.com/neovim/nvim-lspconfig",
			"http://github.com/nvim-telescope/telescope.nvim",
			"http://github.com/mfussenegger/nvim-dap-python",
		},
		-- event = "VeryLazy",
		opts = {
			pdm_path = ".",
			stay_on_this_version = true,
		},
		keys = {
			{ "<leader>vs", "<CMD>:VenvSelect<CR>", "Select Venv" },
			{ "<leader>vc", "<CMD>:VenvSelectCached<CR>", "Select Venv Cached" },
		},
	},
	-- "https://github.com/github/copilot.vim",
	{
		"https://github.com/zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = true,
					markdown = true,
					help = false,
					c = true,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {
					trace = "verbose",
					settings = {
						advanced = {
							listCount = 10, -- #completions for panel
							inlineSuggestCount = 5, -- #completions for getCompletions
						},
					},
				},
			})
		end,
	},
	{
		"https://github.com/zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
