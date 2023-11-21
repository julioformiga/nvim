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
require("lazy").setup("plugins")
vim.cmd([[ let g:boot_ascii = [
\ '',
\ '',
\ '   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ',
\ '   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ',
\ '   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ',
\ '   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ',
\ '   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ',
\ '   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ',
\ '',
\ '']
]])
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
require("base")
require("highlights")
require("maps")
require("bootstrap")
