local Menu = require("nui.menu")

local norminette_enabled = true

local function create_user_menu()
	local menu = Menu({
		position = "50%",
		size = {
			width = 25,
			height = 5,
		},
		border = {
			style = "single",
			text = {
				top = "[Choose an option]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = {
			Menu.item("󱂈󱎦󰫵 - C/C++ inlay hints", { shortcut = "i" }),
			Menu.item("󰫮󰫰 - Auto Compile", { shortcut = "a" }),
			Menu.item("󰫻 - Norminette", { shortcut = "n" }),
		},
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "q" },
			submit = { "<CR>", "<Space>" },
		},
		on_submit = function(item)
			if item.text == "Exit" then
				return
			elseif item.text == "󱂈󱎦󰫵 - C/C++ inlay hints" then
				require("clangd_extensions.inlay_hints").toggle_inlay_hints()
			elseif item.text == "󰫮󰫰 - Auto compile" then
				vim.api.nvim_command("AutoCompile")
			elseif item.text == "󰫻 - Norminette" then
				norminette_enabled = not norminette_enabled
				if norminette_enabled then
					vim.api.nvim_command("NorminetteEnable")
					print("Norminette enabled")
				else
					vim.api.nvim_command("NorminetteDisable")
					print("Norminette disabled")
				end
			end
		end,
	})

	menu:mount()
end

vim.api.nvim_create_user_command("UserMenu", create_user_menu, {})

local file_was_modified = false
local auto_compile_enabled = false

function Setup_auto_compile()
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = { "*.c", "*.cpp" },
		callback = function()
			file_was_modified = vim.bo.modified
		end,
		desc = "Verifica se o arquivo foi modificado antes de salvar",
	})
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "*.c", "*.cpp" },
		callback = function()
			if auto_compile_enabled and string.match(vim.fn.getcwd(), "ursus") and file_was_modified then
				require("neotest").summary.open()
				os.execute("make all tests > /dev/null 2>&1")
				vim.notify("☑️ Successful compilation!", vim.log.levels.INFO)
				require("neotest").run.run(vim.fn.getcwd() .. "/test")
			end
		end,
	})
end

Setup_auto_compile()

vim.api.nvim_create_user_command("AutoCompile", function()
	auto_compile_enabled = not auto_compile_enabled
end, {})

function Auto_compile_status()
	return auto_compile_enabled and "󰫮󰫰" or ""
end
