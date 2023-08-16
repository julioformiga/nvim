require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false },
        }),
        require("neotest-vitest"),
        -- require("neotest-plenary"),
    },
})

require("neodev").setup({
    library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
})

require("codicons").setup()

-- require("dap").setup()
-- local dap = require('dap')

-- require("dap-python").setup("/home/julio/.cache/pypoetry/virtualenvs/fast-zero-Mp744fZZ-py3.11/bin/python")
require("nvim-dap-virtual-text").setup()
require("dapui").setup()
-- require("dapui").open()
local dap, dapui = require("dap"), require("dapui")

dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"
        cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
                source_filetype = "python",
            },
        })
    else
        cb({
            type = "executable",
            command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
            -- command = "/home/julio/.cache/pypoetry/virtualenvs/fast-zero-Mp744fZZ-py3.11/bin/python",
            args = { "-m", "debugpy.adapter" },
            options = {
                source_filetype = "python",
            },
        })
    end
end

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            return "/home/julio/.cache/pypoetry/virtualenvs/fast-zero-Mp744fZZ-py3.11/bin/python"
        end,
    },
}

dap.adapters.codelldb = {
    type = "server",
    host = "127.0.0.1",
    port = 13000,
    executable = {
        command = "/home/julio/.local/share/nvim/mason/bin/codelldb",
        args = { "--port", "13000" },
    },
}

dap.configurations.c = {
    {
        type = "codelldb",
        request = "launch",
        -- program = function()
        --     return vim.fn.input('Path to executable: ', vim.fn.getcwd()..'/', 'file')
        -- end,
        program = "${fileDirname}/${fileBasenameNoExtension}",
        -- program = '/home/julio/.local/share/nvim/mason/bin/codelldb',
        cwd = "${workspaceFolder}",
        terminal = "integrated",
    },
}
-- dap.configurations.cpp = dap.configurations.c
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end
