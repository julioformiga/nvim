local Menu = require("nui.menu")
local Path = require("plenary.path")

-- Function to check if a Makefile exists in the current directory
local function has_makefile()
	local makefile_path = vim.fn.getcwd() .. "/Makefile"
	local f = io.open(makefile_path, "r")
	if f then
		f:close()
		return true
	end
	return false
end

-- Function to parse a Makefile and extract targets
local function parse_makefile()
	if not has_makefile() then
		return {}
	end

	local makefile_path = vim.fn.getcwd() .. "/Makefile"
	local f = io.open(makefile_path, "r")
	if not f then
		return {}
	end

	local content = f:read("*all")
	f:close()

	local targets = {}

	-- Find all targets (lines that end with a colon and are not indented)
	for line in content:gmatch("[^\r\n]+") do
		-- Match lines that contain a target (ending with colon and not starting with whitespace)
		local target = line:match("^([%w%._%-]+):")
		if target and not target:match("^%s") and target ~= ".PHONY" then
			-- Skip internal/special targets
			if not target:match("^%.") then
				table.insert(targets, target)
			end
		end
	end

	return targets
end

-- Create a makefile menu with targets
local function create_makefile_menu()
	local targets = parse_makefile()

	if #targets == 0 then
		vim.notify("No Makefile found or no targets available in the current directory.", vim.log.levels.WARN)
		return
	end

	local menu_items = {}

	for _, target in ipairs(targets) do
		table.insert(menu_items, Menu.item(target))
	end

	local menu = Menu({
		position = "50%",
		size = {
			width = 40,
			height = math.min(#targets + 2, 15), -- Adjust height based on number of targets
		},
		border = {
			style = "single",
			text = {
				top = "[Makefile Targets]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = menu_items,
		max_width = 35,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "q" },
			submit = { "<CR>", "<Space>", "l" },
		},
		on_submit = function(item)
			-- Execute the selected target using a terminal
			local command = "make " .. item.text
			vim.cmd('2TermExec cmd="' .. command .. '" direction=horizontal')
			vim.notify("🛠️ Executing: make " .. item.text, vim.log.levels.INFO)
		end,
	})

	menu:mount()
end

-- Register command
vim.api.nvim_create_user_command("MakefileMenu", function()
	create_makefile_menu()
end, {})

-- Export for use in other modules
return {
	create_makefile_menu = create_makefile_menu,
	has_makefile = has_makefile,
}
