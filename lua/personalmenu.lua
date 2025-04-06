local Menu = require("nui.menu")

local norminette_enabled = true
local auto_compile_enabled = false
local file_was_modified = false

vim.api.nvim_create_user_command("AutoCompile", function()
	auto_compile_enabled = not auto_compile_enabled
end, {})

function Auto_compile_status()
	return auto_compile_enabled and "󰫮󰫰" or ""
end

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

	-- Adiciona integração com o menu de Makefile
	-- Carrega o módulo de menu de Makefile apenas quando necessário
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function()
			local makefile_menu = require("makefilemenu")
			if makefile_menu.has_makefile() then
				-- O menu de Makefile estará disponível através do atalho <leader>mk
				vim.notify("Makefile detectado - use <leader>mk para acessar o menu de targets", vim.log.levels.INFO, {
					title = "Makefile Menu",
					timeout = 3000,
				})
			end
		end,
		once = true, -- Executa apenas uma vez por sessão para evitar notificações repetidas
	})
end

Setup_auto_compile()

local function create_user_menu()
	local itens = {
		"󰫻 - Norminette",
		"󰫮󰫰 - Auto compile",
		"󱂈󱎦󰫵 - LSP inlay hints",
	}
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
			Menu.item(itens[1], { shortcut = "n" }),
			Menu.item(itens[2], { shortcut = "a" }),
			Menu.item(itens[3], { shortcut = "i" }),
		},
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "q" },
			submit = { "<CR>", "<Space>", "l" },
		},
		on_submit = function(item)
			if item.text == "Exit" then
				return
			elseif item.text == itens[3] then
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			elseif item.text == itens[2] then
				vim.api.nvim_command("AutoCompile")
			elseif item.text == itens[1] then
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

vim.api.nvim_create_user_command("PersonalMenu", create_user_menu, {})
