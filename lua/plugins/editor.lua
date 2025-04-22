return {
	"https://github.com/nvim-pack/nvim-spectre",
	"https://github.com/farmergreg/vim-lastplace",
	"https://github.com/tpope/vim-repeat",
	{
		"https://github.com/nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					disable = { "" },
					additional_vim_regex_highlighting = true,
				},
				indent = {
					enable = true,
					disable = { "yaml" },
				},
			})
		end,
	},
	{
		"https://github.com/DreamMaoMao/yazi.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},

		keys = {
			{ "<leader>yy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
		},
	},
	-- {
	-- 	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	-- 	config = function()
	-- 		require("treesitter-context").setup({
	-- 			enable = true,
	-- 			max_lines = 0,
	-- 			mode = "topline",
	-- 		})
	-- 	end,
	-- },
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	-- {
	-- 	"https://github.com/lewis6991/satellite.nvim",
	-- 	opts = {
	-- 		current_only = false,
	-- 		winblend = 50,
	-- 		zindex = 40,
	-- 		excluded_filetypes = {},
	-- 		width = 2,
	-- 		handlers = {
	-- 			search = { enable = false },
	-- 			diagnostic = { enable = false },
	-- 			gitsigns = { enable = false },
	-- 			marks = { enable = false },
	-- 		},
	-- 	},
	-- 	enabled = true, -- This line disables the plugin
	-- },
	{
		"https://github.com/gorbit99/codewindow.nvim",
		config = function()
			local codewindow = require("codewindow")
			codewindow.setup()
			codewindow.apply_default_keybinds()
		end,
	},
	{
		"https://github.com/shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				line_num = {
					enable = true,
					exclude_filetype = { startify = false },
				},
				chunk = { enable = true, exclude_filetype = { startify = false } },
				indent = { enable = true, exclude_filetype = { startify = false } },
				-- blank = { exclude_filetype = { startify = false } },
			})
		end,
	},
	-- {
	-- 	"https://github.com/lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = {
	-- 		scope = {
	-- 			enabled = true,
	-- 			show_start = true,
	-- 			show_end = true,
	-- 			highlight = { "Function", "Label" },
	-- 		},
	-- 		indent = {
	-- 			-- char = { "." },
	-- 			tab_char = { "▎" },
	-- 			smart_indent_cap = true,
	-- 			-- highlight = { "Function", "Label" },
	-- 			priority = 2,
	-- 		},
	-- 		-- whitespace = {
	-- 		--     highlight = { "Function", "Label" },
	-- 		--     remove_blankline_trail = true,
	-- 		-- },
	-- 		exclude = { filetypes = { "startify" } },
	-- 	},
	-- },
	{
		"https://github.com/windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	"https://github.com/danymat/neogen",
	{
		"https://github.com/akinsho/bufferline.nvim",
		dependencies = "https://github.com/nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- set to "tabs" to only show tabpages instead
					themable = true,
					numbers = "none", -- buffer_id, none
					close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
					right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
					left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
					middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "underline",
					},
					buffer_close_icon = "",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					max_name_length = 18,
					max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
					truncate_names = true, -- whether or not tab names should be truncated
					tab_size = 18,
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local s = " "
						for e, n in pairs(diagnostics_dict) do
							local sym = e == "error" and " " or (e == "warning" and " " or " ")
							s = s .. sym .. n .. " "
						end
						return s
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},
					color_icons = true, -- whether or not to add the filetype icon highlights
					show_buffer_icons = true, -- disable filetype icons for buffers
					show_buffer_close_icons = true,
					show_close_icon = true,
					show_tab_indicators = true,
					show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
					persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
					separator_style = "slant", -- "slant" | "thick" | "thin" | { 'any', 'any' },
					enforce_regular_tabs = false,
					always_show_bufferline = true,
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
					sort_by = "insert_at_end",
					-- sort_by = "relative_directory",
					-- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
				},
			})
		end,
	},
	-- { "https://github.com/echasnovski/mini.nvim", version = "*" },
	{
		"https://github.com/AndrewRadev/sideways.vim",
	},
	{
		"https://github.com/nvim-lualine/lualine.nvim",
		dependencies = { "https://github.com/nvim-tree/nvim-web-devicons", opt = true },
	},
	{
		"https://github.com/SmiteshP/nvim-navic",
		dependencies = "https://github.com/neovim/nvim-lspconfig",
	},
	{
		"https://github.com/lewis6991/gitsigns.nvim",
		keys = {
			{ "<leader>gd", "<CMD>Gitsigns diffthis<CR>", desc = "Git diff" },
		},
	},
	{
		"https://github.com/kevinhwang91/nvim-ufo",
		dependencies = {
			"https://github.com/kevinhwang91/promise-async",
			{
				"https://github.com/luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
		event = "VeryLazy",
		-- event = "BufReadPost",
		opts = {
			-- INFO: Uncomment to use treeitter as fold provider, otherwise nvim lsp is used
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
			open_fold_hl_timeout = 150,
			close_fold_kinds_of_ft = { "imports", "comment" },
			enable_get_fold_virt_text = true,
			preview = {
				win_config = {
					-- border = { "", "─", "", "", "", "─", "", "" },
					border = "rounded",
					winhighlight = "Normal:Folded",
					winblend = 12,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
				maxheight = 10,
			},
		},
		config = function(_, opts)
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local totalLines = vim.api.nvim_buf_line_count(0)
				local foldedLines = endLnum - lnum
				local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
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
				local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
				suffix = (" "):rep(rAlignAppndx) .. suffix
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end
			opts["fold_virt_text_handler"] = handler
			require("ufo").setup(opts)
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
			vim.keymap.set("n", "K", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
					vim.cmd([[ Lspsaga hover_doc ]])
				end
			end)
		end,
	},
	{
		"https://github.com/lewis6991/hover.nvim",
		keys = {
			{ "K", "<cmd>lua require('hover').hover()<cr>", desc = "hover" },
			{ "gK", "<cmd>lua require('hover').hover_select()<cr>", desc = "hover (select)" },
		},
		config = function()
			require("hover").setup({
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					require("hover.providers.gh")
					require("hover.providers.gh_user")
					-- require('hover.providers.jira')
					require("hover.providers.man")
					require("hover.providers.dictionary")
				end,
				preview_opts = {
					border = "rounded",
				},
				-- Whether the contents of a currently open hover window should be moved
				-- to a :h preview-window when pressing the hover keymap.
				preview_window = false,
				title = true,
			})
		end,
	},
	{
		"https://github.com/kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"https://github.com/numToStr/Comment.nvim",
		lazy = false,
		opts = {},
	},
	"https://github.com/famiu/bufdelete.nvim",
	{
		"https://github.com/folke/zen-mode.nvim",
		keys = {
			{ "<A-z>", "<cmd>ZenMode<cr>", desc = "Zen mode" },
		},
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.8,
					width = 160,
				},
			})
		end,
	},
	{
		"https://github.com/ecthelionvi/NeoComposer.nvim",
		dependencies = { "https://github.com/kkharji/sqlite.lua" },
		opts = { keymaps = { toggle_macro_menu = "<leader>q" } },
	},
	{
		"https://github.com/mg979/vim-visual-multi",
		name = "Visual MultiCursor",
		event = "BufEnter",
		branch = "master",
	},
	-- {
	-- 	"https://github.com/folke/flash.nvim",
	-- 	event = "VeryLazy",
	-- 	---@type Flash.Config
	-- 	opts = {},
	--        -- stylua: ignore
	--        keys = {
	--            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	--            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	--            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	--            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	--            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	--        },
	-- },
}
