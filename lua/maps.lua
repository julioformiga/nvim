local function map(mode, lhs, rhs, options)
    options = options or { noremap = true, silent = true }
    -- vim.keymap.set(m, k, v, o)
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"python"},
    callback = function()
        map('n', '<A-CR>', '<CMD>1TermExec cmd="python %" direction=float<CR>')
    end
})

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<ESC>', [[<C-\><C-n><CMD>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-q>', [[<C-\><C-n><CMD>ToggleTerm<CR>]], opts)
    vim.keymap.set('t', '<A-q>', [[<C-\><C-n><CMD>ToggleTerm<CR>]], opts)
    vim.keymap.set('t', '<C-h>', [[<CMD>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<CMD>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<CMD>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<CMD>wincmd l<CR>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

vim.g.neovide_scale_factor=0.9
function ChangeScaleFactor(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
map('n', '<C-=>', ":lua ChangeScaleFactor(1.1)<CR>")
map('n', '<C-->', ":lua ChangeScaleFactor(1/1.1)<CR>")

local Terminal  = require('toggleterm.terminal').Terminal
-- local lazygit = Terminal:new({
--     cmd = "lazygit",
--     dir = "git_dir",
--     direction = "float",
--     float_opts = {
--         border = "double",
--     },
--     on_open = function(term)
--         vim.cmd("startinsert!")
--         vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
--     end,
--     on_close = function(term)
--         vim.cmd("startinsert!")
--     end,
-- })
--
-- function _lazygit_toggle()
--     lazygit:toggle()
-- end
M = {}
M.HandleURL = function()
  local url = string.match(vim.fn.getline("."), "[a-z]*://[^ >,;]*")
  if url ~= "" then
    vim.cmd('exec "!xdg-open ' .. url .. '"')
  else
    vim.cmd('echo "No URI found in line."')
  end
end

map("n", "gf", '<Cmd>lua M.HandleURL()<CR>')

vim.g.mapleader = ' '

-- Find files using Telescope command-line sugar.
map('n', '<leader>ff',  '<CMD>Telescope find_files<cr>')
map('n', '<leader>fg',  '<CMD>Telescope live_grep<cr>')
map('n', '<leader>fb',  '<CMD>Telescope buffers<cr>')
map('n', '<leader>fh',  '<CMD>Telescope help_tags<cr>')
map('n', '<leader>gg',   '<CMD>LazyGitCurrentFile<CR>', {noremap = true, silent = true})
map('n', '<A-e>',   '<CMD>NeoTreeFloatToggle<CR>', {noremap = true, silent = true})
map('n', '<leader>r', ':so %<CR><CMD>echo "Settings reload!"<CR>')  -- Reload configuration without restart nvim
map('n', '<leader>e', '<CMD>TroubleToggle<CR>')
map('n', '<leader>u', '<CMD>PackerUpdate<CR><CMD>Mason<CR>')
map('n', '<A-1>', '<ESC><CMD>1ToggleTerm direction=float<CR>')
-- map('n', ';', ':<Down>')
map('n', '<A-2>', '<ESC><CMD>2ToggleTerm direction=horizontal<CR>')
-- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
map('n', '<A-o>', "<CMD>TagbarOpenAutoClose<CR>")
map('n', '<A-z>', "<CMD>ZenMode<CR>")

-- Windows and Tabs
map('n', '<C-tab>', '<C-w>w') -- Alternate
map('n', '<C-S-Up>', "<C-w><Up>")
map('n', '<C-S-Down>', "<C-w><Down>")
map('n', '<C-S-Left>', "<C-w><Left>")
map('n', '<C-S-Right>', "<C-w><Right>")
map('n', '<C-S-H>', "<CMD>vertical resize +4<CR>")
map('n', '<C-S-J>', "<CMD>horizontal resize +4<CR>")
map('n', '<C-S-K>', "<CMD>horizontal resize -4<CR>")
map('n', '<C-S-L>', "<CMD>vertical resize -4<CR>")
map('n', '<C-S-PageUp>', "<CMD>BufferLineMovePrev<CR>")
map('n', '<C-S-PageDown>', "<CMD>BufferLineMoveNext<CR>")

-- map('"', '<C-d>', '<CMD>call CocActionAsync('jumpDefinition')<CR>')
map('n', '<C-d>', 'dd')
map('i', '<C-d>', '<ESC>ddi')
map('n', '<C-s>', '<CMD>w<CR>')
map('n', '<A-s>', '<CMD>w<CR>')
map('i', '<A-s>', '<ESC><CMD>w<CR>')
map('i', '<C-s>', '<ESC><CMD>w<CR>')
map('v', '<C-s>', '<ESC><CMD>w<CR>')
map('s', '<C-s>', '<ESC><CMD>w<CR>')
map('n', '<C-z>', '<CMD>undo<CR>')
map('n', '<S-u>', '<CMD>redo<CR>')
map('n', '<C-Space>', '<CMD>NeoTreeFocusToggle<CR>')
map('n', '<A-q>', '<CMD>SClose<CR>')
map('n', '<S-j>', '<S-j>x')
-- map('n', '<A-q>', '<CMD>NeoTreeClose<CR><CMD>SClose<CR>')

map('i', '<S-Del>', '<ESC><CMD>delete<CR>i')
map('n', '<S-Del>', '<CMD>delete<CR>')

map('i', '<A-/>', '<ESC><CMD>CommentToggle<CR>i<Right>')
map('n', '<A-/>', '<S-V><ESC><CMD>\'<,\'>CommentToggle<CR>gv<ESC>')
map('v', '<A-/>', '<ESC><CMD>\'<,\'>CommentToggle<CR>gv<ESC>')

map('i', '<C-PageDown>', '<ESC><CMD>bnext<CR>')
map('i', '<C-PageUp>', '<ESC><CMD>bprevious<CR>')
map('n', '<C-PageDown>', '<CMD>bnext<CR>')
map('n', '<C-PageUp>', '<CMD>bprevious<CR>')
map('n', '<A-a>', 'ggVGo')
map('i', '<A-d>', '<ESC>yypi')
map('n', '<A-d>', 'yyp')
map('v', '<A-d>', 'ygv<ESC>p')
-- map('v', '<A-d>', 'y}O<ESC>p')

-- Move lines up and down
map('i', '<A-Up>', '<ESC><CMD>m .-2<CR>==gi')
map('n', '<A-Up>', '<CMD>m .-2<CR>==')
map('v', '<A-Up>', "<ESC><CMD>'<,'>m '<-2<CR>gv")
map('i', '<A-Down>', '<ESC><CMD>m .+1<CR>==gi')
map('n', '<A-Down>', '<CMD>m .+1<CR>==')
map('v', '<A-Down>', "<ESC><CMD>'<,'>m '>+1<CR>gv=gv")

-- Normal and Visual mode
map('n', '<CR>', 'i')
map('n', '<A-j>', '<CMD>m .+1<CR>==')
map('v', '<A-j>', "<ESC><CMD>'<,'>m '>+1<CR>gv=gv")
map('n', '<A-k>', '<CMD>m .-2<CR>==')
map('v', '<A-k>', "<ESC><CMD>'<,'>m '<-2<CR>gv=gv")
map('n', '<A-h>', 'b')
map('n', '<A-l>', 'w')
map('n', '<A-[>', 'ysiw', { noremap = false, silent = true })
map('n', '<A-]>', 'ds', { noremap = false, silent = true })
map('n', '<A-9>', 'ysiwb', { noremap = false, silent = false })
map('n', '<A-0>', 'dsb', { noremap = false, silent = false })
map('n', '<A-,>', 'ysiwt', { noremap = false, silent = false })
map('n', '<A-.>', 'dst', { noremap = false, silent = false })
-- map('i', '<A-,>', '<Right>, ""<Left>')
map('i', '<A-,>', '<ESC>lylli, <ESC>ppi')
map('v', '<A-,>', 'ST', { noremap = false, silent = false })
-- map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<CMD>bprevious<CR>')
map('n', '<C-k>', '<CMD>bnext<CR>')
-- map('n', '<C-l>', '<C-w>l')
map('n', '<C-\\>', '<CMD>vsplit<CR><C-w>l<CR>:bnext<CR>')
map('n', '<C-/>', '<CMD>split<CR><C-w>j<CR>:bnext<CR>')
map('n', '<C-q>', '<C-w>q')
map('n', '<A-Home>', '<CMD>vertical resize -2<CR>')
map('n', '<A-End>', '<CMD>vertical resize +2<CR>')

-- Insert mode
map('i', '<A-i>', '<ESC><Right>')
-- map('i', '<A-CR>', '<ESC>')
-- map('n', '<A-CR>', '<ESC>o')
map('n', '<A-m>', '<ESC>o')
map('i', '<A-j>', '<Down>')
map('i', '<A-k>', '<Up>')
map('i', '<A-h>', '<Left>')
map('i', '<A-l>', '<Right>')
map('i', '<A-z>', '<Backspace>')
map('i', '<A-x>', '<Del>')
map('i', '<A-g>', '<Home>')
map('i', '<A-;>', '<End>')

map('n', '<A-Left>', '<C-w>h')
map('i', '<A-Left>', '<ESC><C-w>h')
map('n', '<A-Right>', '<C-w>l')
map('i', '<A-Right>', '<ESC><C-w>l')
map('n', '<A-PageDown>', '<CMD>bnext<CR>')
map('i', '<A-PageDown>', '<ESC><CMD>bnext<CR>')
map('n', '<A-PageUp>', '<CMD>bprevious<CR>')
map('i', '<A-PageUp>', '<ESC><CMD>bprevious<CR>')
map('i', '<A-w>', '<ESC><CMD>Bdelete<CR>')
map('n', '<A-w>', '<CMD>Bdelete<CR>')
map('n', '<A-t>', 'cstt')

-- retab
map('n', '<Tab>', '>>_')
map('n', '<S-Tab>', '<<_')
map('i', '<S-Tab>', '<C-D>')
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')

-- Select with shift + arrows
map('i', '<S-Left>','<Left><C-o>v')
map('i', '<S-Right>', '<C-o>v')
map('i', '<S-Up>', '<Left><C-o>v<Up><Right>')
map('i', '<S-Down>', '<C-o>v<Down><Left>')
map('i', '<C-S-Left>', '<S-Left><C-Left>')
map('i', '<C-S-Right>', '<S-Right><C-Right>')
map('v', '<S-Left>', '<Left>')
map('v', '<S-Right>', '<Right>')
map('v', '<S-Up>', '<Up>')
map('v', '<S-Down>', '<Down>')
map('n', '<S-Down>', 'V<Down>')
map('n', '<S-Up>', 'V<Up>')

-- Auto unselect when not holding shift
map('v', '<Left>', '<Esc>')
map('v', '<Right>', '<Esc><Right>')
map('v', '<Up>', '<Esc><Up>')
map('v', '<Down>', '<Esc><Down>')

-- Keybind to clear search
map('n', '<leader>c', '<CMD>nohl<CR><CMD>echo "Search Cleared"<CR>')

map('n', '<C-c>', '<CMD>PickColor<CR>', {noremap=true,silent=true})
map('i', '<C-c>', '<CMD>PickColorInsert<CR>', {noremap=true,silent=true})
