local function map(mode, lhs, rhs, options)
    options = options or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local aucmd_dict = {
    FileType = {
        {
            pattern = { "arduino" },
            callback = function()
                map("n", "<leader>vf", "va{V")
                map(
                    "n",
                    "<leader><cr>",
                    '<esc><cmd>2TermExec cmd="arduino-cli compile --fqbn esp8266:esp8266:nodemcuv2 && arduino-cli upload -v -p /dev/ttyACM0 --fqbn esp8266:esp8266:nodemcuv2:baud=3000000 && arduino-cli monitor -p /dev/ttyACM0 -c baudrate=115200" direction=float<cr>'
                )
            end,
        },
        {
            pattern = { "sh" },
            callback = function()
                map("n", "<leader><cr>", '<esc><cmd>2TermExec cmd="bash %" direction=horizontal<cr>')
                map("n", "<leader><cr><cr>", '<esc><cmd>2TermExec cmd="bash %" direction=horizontal<cr><C-w>j')
            end,
        },
        {
            pattern = { "c", "cpp" },
            callback = function()
                map("n", "<leader>vf", "va{V")
                map(
                    "n",
                    "<leader><cr>",
                    '<cmd>2TermExec cmd="cc % -Wall -Wextra -Werror -g -o main && ./main" direction=horizontal<cr>'
                )
                -- map(
                --     "n",
                --     "<leader><cr><cr>",
                --     '<esc><cmd>2TermExec cmd="cc % -Wall -Wextra -Werror -g -o main && ./main" direction=horizontal<cr><C-w><C-w>'
                -- )
            end,
        },
        {
            pattern = { "rs", "rust" },
            callback = function()
                map("n", "<leader>vf", "va{V")
                map("n", "<leader><cr>", '<esc><cmd>2TermExec cmd="cargo run" direction=horizontal<cr>')
                -- map('n', '<leader><cr>', '<esc><cmd>3TermExec cmd="cargo run" direction=horizontal<cr><C-w>j')
            end,
        },
        {
            pattern = { "markdown" },
            callback = function()
                map("n", "<leader><cr>", "<esc><cmd>Glow %<cr>")
            end,
        },
        {
            pattern = { "python" },
            callback = function()
                map("n", "<leader>vf", "[[V]M")
                map("n", "<leader><cr>", '<esc><cmd>2TermExec cmd="python %" direction=horizontal<cr>')
            end,
        },
    },
}
map("n", "<leader>S", '<cmd>lua require("spectre").open()<cr>', {
    desc = "Open Spectre",
})
map("n", "<leader>Sw", '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', {
    desc = "Search current word",
})
map("v", "<leader>Sw", '<esc><cmd>lua require("spectre").open_visual()<cr>', {
    desc = "Search current word",
})
map("n", "<leader>Sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<cr>', {
    desc = "Search on current file",
})
for event, opt_tbls in pairs(aucmd_dict) do
    for _, opt_tbl in pairs(opt_tbls) do
        vim.api.nvim_create_autocmd(event, opt_tbl)
    end
end

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n><cmd>wincmd k<cr>]], opts)
    vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<A-q>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<A-1>", [[<C-\><C-n><cmd>ToggleTerm<cr>]], opts)
    vim.keymap.set("t", "<A-2>", [[<C-\><C-n><cmd>ToggleTerm<cr>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
vim.cmd("autocmd! TermEnter term://* set nospell")

function ChangeScaleFactor(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

map("n", "<C-=>", ":lua ChangeScaleFactor(1.1)<cr>")
map("n", "<C-->", ":lua ChangeScaleFactor(0.9)<cr>")

-- Go to URL in current line
M = {}
M.HandleURL = function()
    local url = string.match(vim.fn.getline("."), "%f[%a]([a-zA-Z]+://[^%s,;\"'<>%(%)]*)")
    if url ~= "" then
        vim.cmd("exec '!xdg-open " .. url .. "'")
    else
        vim.cmd('echo "No URI found in line."')
    end
end
map("n", "gf", "<Cmd>lua M.HandleURL()<cr>")

map("n", "<leader>r", ':so %<cr><cmd>echo "Settings reload!"<cr>', { desc = "Reload settings" })
map("n", "<A-cr>", ":", { noremap = true, silent = false })
map("", "<leader>s", "<cmd>set spell!<cr>", { desc = "Spell Toggle" })

-- Not rewrite clipboard
-- map('n', 'd', '"_d')
map("", "s", '"_s')
map("", "x", '"_x')
map("", "X", '"_X')
map("", "<Del>", '"_x')
map("", "<S-Del>", '"_dd')
map("i", "<S-Del>", '<esc>"_dd')
-- Edit words with copy and paste
-- map('n', '<A-cr>', 'b"_ce')
-- map('i', '<A-cr>', '<esc>b"_ce')
map("n", "<A-i>", 'b"_ce')
map("n", "<A-p>", 'b"_ce<esc>p')
-- map('i', '<A-p>', '<esc>b"_ce<esc>pi')
map("n", "<A-y>", "byew")
map("i", "<A-y>", "<esc>byew")

map("n", "<F2>", '<cmd>lua require("renamer").rename()<cr>')
map("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>')
map("v", "<F2>", '<cmd>lua require("renamer").rename()<cr>')

-- Debugger
-- map("n", "<F7>", "<cmd>DapToggleBreakpoint<cr>")
-- map("n", "<F8>", "<cmd>DapContinue<cr>")
-- map("n", "<F9>", "<cmd>DapStepInto<cr>")
-- map("n", "<F10>", "<cmd>DapTerminate<cr>")
-- map("n", "<F12>", '<cmd>lua require("dapui").toggle()<cr>')

-- Windows and Tabs
map("", "<leader><Tab>", "<C-w>w", { desc = "Next window" })
map("n", "<C-S-Up>", "<C-w><Up>")
map("n", "<C-S-Down>", "<C-w><Down>")
map("n", "<C-S-Left>", "<C-w><Left>")
map("n", "<C-S-Right>", "<C-w><Right>")
map("n", "<leader>wh", "<cmd>vertical resize -4<cr>")
map("n", "<leader>wj", "<cmd>horizontal resize +4<cr>")
map("n", "<leader>wk", "<cmd>horizontal resize -4<cr>")
map("n", "<leader>wl", "<cmd>vertical resize +4<cr>")
map("n", "<C-S-PageUp>", "<cmd>BufferLineMovePrev<cr>")
map("n", "<C-S-PageDown>", "<cmd>BufferLineMoveNext<cr>")

-- map("n", "<A-->", '"_dd')
-- map("i", "<A-->", '<esc>"_ddi')
-- map("n", "<C-d>", '"_dd')
-- map("i", "<C-d>", '<esc>"_ddi')
map("n", "<A-d>", "yyp")
map("i", "<A-d>", "<esc>yypi")
map("v", "<A-d>", "ygv<esc>pgv")
map("n", "<C-s>", "<cmd>w<cr>")
map("n", "<A-s>", "<cmd>w<cr>")
map("i", "<A-s>", "<esc><cmd>w<cr>")
map("v", "<A-s>", "<esc><cmd>w<cr>")
map("i", "<C-s>", "<esc><cmd>w<cr>")
map("v", "<C-s>", "<esc><cmd>w<cr>")
map("s", "<C-s>", "<esc><cmd>w<cr>")
map("n", "<C-z>", "<cmd>undo<cr>")
map("n", "<S-u>", "<cmd>redo<cr>")
map("n", "<A-q>", '<cmd>lua require("dapui").close()<cr><cmd>SClose<cr>')

map("i", "<A-/>", "<esc><cmd>CommentToggle<cr>i<Right>")
map("n", "<A-/>", "<S-V><esc><cmd>'<,'>CommentToggle<cr>gv<esc>")
map("v", "<A-/>", "<esc><cmd>'<,'>CommentToggle<cr>gv<esc>")
map("i", "<A-u>", "<esc><cmd>CommentToggle<cr>i<Right>")
map("n", "<A-u>", "<S-V><esc><cmd>'<,'>CommentToggle<cr>gv<esc>")
map("v", "<A-u>", "<esc><cmd>'<,'>CommentToggle<cr>gv<esc>")

map("i", "<C-PageDown>", "<esc><cmd>bnext<cr>")
map("i", "<C-PageUp>", "<esc><cmd>bprevious<cr>")
map("n", "<C-PageDown>", "<cmd>bnext<cr>")
map("n", "<C-PageUp>", "<cmd>bprevious<cr>")
map("n", "<A-a>", "ggVGo")

-- Move lines up and down
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi")
map("n", "<A-Up>", "<cmd>m .-2<cr>==")
map("v", "<A-Up>", "<esc><cmd>'<,'>m '<-2<cr>gv")
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi")
map("n", "<A-Down>", "<cmd>m .+1<cr>==")
map("v", "<A-Down>", "<esc><cmd>'<,'>m '>+1<cr>gv=gv")

-- Normal and Visual mode
map("n", "<cr>", "i")
map("n", "<C-i>", "<C-I>")
map("n", "<leader>tr", "<cmd>Telescope registers<cr>")
map("n", "<A-l>", "w")
map("n", "<A-[>", "ysiw", { noremap = false, silent = true })
map("n", "<A-]>", "ds", { noremap = false, silent = true })
map("n", "<A-9>", "ysiwb", { noremap = false, silent = false })
map("n", "<A-0>", "dsb", { noremap = false, silent = false })
map("n", "<A-,>", "ysiwt", { noremap = false, silent = false })
map("n", "<A-.>", "dst", { noremap = false, silent = false })
map("v", "<A-,>", "ST", { noremap = false, silent = false })
map("n", "<C-\\>", "<cmd>vsplit<cr><C-w>l<cr>:bnext<cr>")
map("n", "<C-/>", "<cmd>split<cr><C-w>j<cr>:bnext<cr>")
map("n", "<C-q>", "<C-w>q")
map("n", "<A-Home>", "<cmd>vertical resize -2<cr>")
map("n", "<A-End>", "<cmd>vertical resize +2<cr>")
map("n", "<A-Del>", "ce")
map("n", "<A-Backspace>", "cb")
map("n", "<A-x>", '"_dd')
map("i", "<A-x>", '<esc>"_dd')
map("n", "<A-o>", "o<esc>")
-- map('n', '<A-x>', '"_dw')

map("n", "<leader><Left>", "za")
map("n", "<leader><Up>", "zM")
map("n", "<leader><Down>", "zR")
map("n", "<leader>h", "za")
map("n", "<leader>j", "zR")
map("n", "<leader>k", "zM")

map("n", "<A-j>", "<cmd>m .+1<cr>==")
map("v", "<A-j>", "<esc><cmd>'<,'>m '>+1<cr>gv=gv")
map("n", "<A-k>", "<cmd>m .-2<cr>==")
map("v", "<A-k>", "<esc><cmd>'<,'>m '<-2<cr>gv=gv")
map("n", "<A-h>", "b")
map("n", "<C-j>", "<cmd>bprevious<cr>")
map("n", "<C-k>", "<cmd>bnext<cr>")

-- Insert mode
-- Movements
map("i", "<A-j>", "<Down>")
map("i", "<A-k>", "<Up>")
map("i", "<A-h>", "<Left>")
map("i", "<A-l>", "<Right>")
map("i", "<S-A-h>", "<C-o>b")
map("i", "<S-A-l>", "<C-o>w")

-- map('i', '<A-u>', '<esc>ui')
map("n", "<A-m>", "<esc>o")
map("i", "<A-i>", "<esc><Right>")

map("i", "<A-,>", "<esc>lylli, <esc>ppi")

map("i", "<A-Left>", "<C-o>b")
map("i", "<A-Right>", "<C-o>e")

map("i", "<A-z>", "<Backspace>")
map("i", "<A-x>", "<Del>")
map("i", "<A-g>", "<Home>")
map("i", "<A-;>", "<End>")
map("i", "<A-Del>", "<C-o>de")
map("i", "<A-Backspace>", "<C-o>db")
map("i", "<A-S-Del>", "<C-o>die")
map("i", "<A-S-Backspace>", "<C-o>dib")

map("n", "<A-Left>", "<C-w>h")
map("n", "<A-Right>", "<C-w>l")
map("n", "<A-PageDown>", "<cmd>bnext<cr>")
map("i", "<A-PageDown>", "<esc><cmd>bnext<cr>")
map("n", "<A-PageUp>", "<cmd>bprevious<cr>")
map("i", "<A-PageUp>", "<esc><cmd>bprevious<cr>")
map("i", "<A-w>", "<esc><cmd>Bdelete<cr>")
map("n", "<A-w>", "<cmd>Bdelete<cr>")
map("n", "<A-t>", "cstt")

-- retab
map("n", "<Tab>", ">>_")
map("n", "<S-Tab>", "<<_")
map("i", "<S-Tab>", "<C-D>")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- Select with shift + arrows
map("i", "<S-Left>", "<Left><C-o>v")
map("i", "<S-Right>", "<C-o>v")
map("i", "<S-Up>", "<Left><C-o>v<Up><Right>")
map("i", "<S-Down>", "<C-o>v<Down><Left>")
map("i", "<C-S-Left>", "<S-Left><C-Left>")
map("i", "<C-S-Right>", "<S-Right><C-Right>")
map("v", "<S-Left>", "<Left>")
map("v", "<S-Right>", "<Right>")
map("v", "<S-Up>", "<Up>")
map("v", "<S-Down>", "<Down>")
map("n", "<S-Down>", "V<Down>")
map("n", "<S-Up>", "V<Up>")

-- Auto unselect when not holding shift
map("v", "<Left>", "<Esc>")
map("v", "<Right>", "<Esc><Right>")
map("v", "<Up>", "<Esc><Up>")
map("v", "<Down>", "<Esc><Down>")

-- Keybind to clear search
map("n", "<leader>c", '<cmd>nohl<cr><cmd>echo "Search Cleared"<cr>')

map("n", "<C-c>", "<cmd>PickColor<cr>", { noremap = true, silent = true })
map("i", "<C-c>", "<cmd>PickColorInsert<cr>", { noremap = true, silent = true })
