return {
	"https://github.com/luckasRanarison/tailwind-tools.nvim",
	"https://github.com/themaxmarchuk/tailwindcss-colors.nvim",
	"https://github.com/ap/vim-css-color",
	"https://github.com/turbio/bracey.vim",
	{
		"https://github.com/ziontee113/color-picker.nvim",
		keys = {
			{ "<A-c>", "<cmd>PickColor<cr>", desc = "Color picker" },
		},
		config = function()
			require("color-picker").setup()
		end,
	},
	{
		"https://github.com/windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"https://github.com/toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
}
