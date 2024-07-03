HOMEDIR = os.getenv("HOME")
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local function command_exists(cmd)
	return vim.fn.executable(cmd) == 1
end

local boot_ascii = {
	"╭─────────────────────────────────────────────────────────────────────────────────---- -- -",
}
if command_exists("neofetch") then
	local function remove_ansi_codes(str)
		local patterns = {
			"\27%[[%d;]*m",
			"\27%[%?25l",
			"\27%[%?7l",
			"\27%[%?25h",
			"\27%[%?7h",
			"\27%[19A",
			"\27%[9999999D",
			"\27%[41C",
			"\27%[17A",
		}
		for _, pattern in ipairs(patterns) do
			str = str:gsub(pattern, "")
		end
		return str
	end

	local output1 = vim.fn.system("neofetch -L --color_blocks off")
	local output2 = vim.fn.system("neofetch --stdout --disable gpu --disable memory --gtk2 off --gtk3 off")

	output1 = remove_ansi_codes(output1)
	local lines1 = vim.split(output1, "\n")
	local lines2 = vim.split(output2, "\n")
	local handle = io.popen("ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}'")
	local result = handle:read("*a")
	handle:close()
	local ip = result:match("%S+")
	table.insert(lines2, "IP internal: " .. ip)
	table.insert(lines2, "IP external: " .. vim.fn.system("curl -s ifconfig.me"))
	nvim_lua_version = vim.fn.execute("version"):match("NVIM v(%d+.%d+.%d+)")
	nvim_lua_version = nvim_lua_version .. " - Lua: " .. _VERSION
	table.insert(lines2, "Neovim: " .. nvim_lua_version)

	local longest_line_length = 0
	for _, line in ipairs(lines1) do
		if #line > longest_line_length then
			longest_line_length = #line
		end
	end

	for i = 1, #lines2 do
		local line1 = lines1[i] or ""
		local line2 = lines2[i] or ""
		local padding = longest_line_length - #line1
		if padding > 0 then
			line1 = line1 .. string.rep(" ", padding)
		end
		if #line2 > 0 then
			local combined_line = line1 .. "      " .. line2
			table.insert(boot_ascii, "│   " .. combined_line:gsub("'", "`"))
		end
	end
else
	table.insert(boot_ascii, "│")
	local output1 = vim.fn.system("cat " .. HOMEDIR .. "/.config/nvim/assets/boot_ascii.txt")
	local lines1 = vim.split(output1, "\n")
	for i = 1, #lines1 do
		table.insert(boot_ascii, "│   " .. lines1[i])
	end
end
table.insert(
	boot_ascii,
	"╰─────────────────────────────────────────────────────────────────────────────────---- -- -"
)
local boot_ascii_str = table.concat(boot_ascii, "',\n\\ '")

vim.cmd("let g:boot_ascii = ['" .. boot_ascii_str .. "']")
vim.cmd([[ let g:startify_custom_header = g:boot_ascii ]])
vim.cmd([[ let g:startify_session_autoload = 1 ]])
vim.cmd([[ let g:startify_session_persistence = 1 ]])
vim.cmd([[ let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'files',     'header': ['   MRU']            },
    \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'commands',  'header': ['   Commands']       },
\ ]
]])
require("lazy").setup("plugins")
require("base")
require("highlights")
require("maps")
require("bootstrap")
