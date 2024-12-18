local g = vim.g
local o = vim.o
local wo = vim.wo
local opt = vim.opt

-- syntax on                     -- syntax highlighting, see :help syntax
wo.number = true
wo.relativenumber = true
wo.wrap = true
-- o.noswapfile = true -- disable use of swap files
o.wildmenu = true -- completion menu
o.backspace = "indent,eol,start" -- ensure proper backspace functionality
o.undodir = HOMEDIR .. "/.cache/nvim/undo" -- undo ability will persist after exiting file
o.undofile = true -- see :help undodir and :help undofile
o.ignorecase = true -- ignore case when searching
o.incsearch = true -- see results while search is being typed, see :help incsearch
o.showmatch = true -- display matching bracket or parenthesis
o.hlsearch = true
o.nrformats = "bin,hex,alpha"
o.autoread = true
o.incsearch = true -- highlight all pervious search pattern with incsearch
o.expandtab = true
o.autoindent = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = false -- auto indent on new lines, see :help smartindent
o.smarttab = true
o.updatetime = 1000
o.mouse = "a"
-- wo.colorcolumn = '80'
o.clipboard = [[unnamed,unnamedplus]]
o.encoding = "UTF-8"
o.cursorline = true
-- opt.guicursor = {
-- 	"n-v-c-sm:block-blinkwait700-blinkoff400-blinkon250",
-- 	"i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250",
-- 	"r-cr-o:hor20-blinkwait700-blinkoff400-blinkon250",
-- }
-- g.neovide_cursor_smooth_blink = true -- High CPU usage

g.neovide_padding_top = 0
g.neovide_padding_bottom = 0
g.neovide_padding_right = 0
g.neovide_padding_left = 0
-- g.neovide_cursor_vfx_mode = "railgun"
-- g.neovide_cursor_vfx_mode = "torpedo"
-- g.neovide_cursor_vfx_mode = "pixiedust"
-- g.neovide_cursor_vfx_mode = "sonicboom"
-- g.neovide_cursor_vfx_mode = "ripple"
-- g.neovide_cursor_vfx_mode = "wireframe"
-- g.neovide_scale_factor = 1
g.neovide_cursor_animate_in_insert_mode = false
g.neovide_remember_window_size = true
-- g.neovide_cursor_antialiasing = true
-- g.neovide_cursor_unfocused_outline_width = 0.125
-- g.neovide_scroll_animation_length = 0.3
g.neovide_refresh_rate = 60
-- g.neovide_refresh_rate_idle = 5
-- g.neovide_transparency = 0.95
-- g.transparency = 1
-- Helper function for transparency formatting
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
-- local alpha = function()
--     return string.format("%x", math.floor((255 * g.transparency) or 0.8))
-- end
-- g.neovide_transparency = 0.8
-- g.transparency = 0.8
-- g.neovide_background_color = "#0f1117" .. alpha()
-- g.neovide_window_floating_blur = 0.8
-- g.neovide_floating_blur_amount_x = 2.0
-- g.neovide_floating_blur_amount_y = 2.0

o.list = true
-- o.shell = HOMEDIR .. '/.local/bin/xonsh'
-- o.shell = "/usr/bin/bash"
o.shell = "/usr/bin/zsh"
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
-- o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
o.foldcolumn = "2" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.termguicolors = true
opt.linespace = -1
opt.iskeyword:append("-") -- Add '-' in command 'w' to select word
-- opt.guifont = "JetBrains Mono NL Thin:h10.8"
-- opt.guifont = "MesloLGS Nerd Font Mono:h10"
-- opt.guifont = "Hack Nerd Font Mono:h10"
opt.guifont = "JetBrainsMonoNL Nerd Font Mono:h12"
-- opt.guifont = "JetBrainsMonoNL Nerd Font Mono:h10.8"
-- opt.guifont = "JetBrainsMono Nerd Font Mono:h10.8"
opt.spell = false
opt.spelllang = { "en", "pt" }
-- opt.completeopt = {'menu', 'menuone'}
-- opt.completeopt = {'menu','noinsert','noselect'}
-- opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
o.completeopt = [[menuone,noinsert,noselect]]

-- Disable builtin plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	-- "gzip",
	"logipat",
	-- "netrw",
	-- "netrwPlugin",
	-- "netrwSettings",
	-- "netrwFileHandlers",
	"matchit",
	-- "tar",
	"tarPlugin",
	"rrhelper",
	-- "spellfile_plugin",
	"vimball",
	"vimballPlugin",
	-- "zip",
	"zipPlugin",
	"tutor",
	-- "rplugin",
	-- "synmenu",
	-- "optwin",
	-- "compiler",
	-- "bugreport",
	"ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end
