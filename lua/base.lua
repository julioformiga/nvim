local g = vim.g
local o = vim.o
local wo = vim.wo
local opt = vim.opt

-- syntax on                     -- syntax highlighting, see :help syntax
o.number = true
o.noswapfile = true                   -- disable use of swap files
o.wildmenu = true                     -- completion menu
o.backspace = 'indent,eol,start'      -- ensure proper backspace functionality
o.undodir = '/home/julio/.cache/nvim/undo'  -- undo ability will persist after exiting file
o.undofile = true                     -- see :help undodir and :help undofile
o.incsearch = true                    -- see results while search is being typed, see :help incsearch
o.smartindent = false                  -- auto indent on new lines, see :help smartindent
o.showmatch = true                    -- display matching bracket or parenthesis
o.ic = true                           -- ignore case when searching
o.hlsearch = true
o.incsearch = true                    -- highlight all pervious search pattern with incsearch
o.expandtab = true
o.autoindent = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smarttab = true
o.mouse = 'a'
wo.colorcolumn = '80'
o.clipboard = 'unnamedplus'
o.encoding = 'UTF-8'
o.cursorline = true
o.list = true
o.shell = '/home/julio/.local/bin/xonsh'
opt.termguicolors = true
opt.iskeyword:append("-") -- Add '-' in command 'w' to select word
-- opt.guifont = {"JetBrainsMono Nerd Font Mono", ":h14"}
opt.guifont = {"Hack Nerd Font Mono", ":h12"}
-- opt.guifont = {"SauceCodePro Nerd Font", ":h14"}
-- opt.guifont = {"RobotoMono Nerd Font Mono", ":h13"}
-- opt.guifont = {"UbuntuMono Nerd Font Mono", ":h16"}
-- opt.guifont = {"VictorMono Nerd Font Mono, Medium", ":h12"}
-- opt.spell = true
-- opt.spelllang = {"en", "pt"}
-- opt.completeopt = {'menu', 'menuone'}
-- opt.completeopt = {'menu','noinsert','noselect'}
opt.completeopt = {'menu','menuone','noselect'}

-- Disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
   "tutor",
   "rplugin",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end
