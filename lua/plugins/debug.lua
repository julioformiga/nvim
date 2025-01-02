---@diagnostic disable: missing-fields
return {
	{
		"https://github.com/folke/trouble.nvim",
		lazy = false,
		keys = {
			{ "<leader>e", "<CMD>Trouble diagnostics toggle<CR>", desc = "Errors in file" },
			{ "<leader>E", "<CMD>Trouble symbols toggle<CR>", desc = "Errors in workspace" },
		},
		opts = {},
	},
	{
		"https://github.com/rcarriga/nvim-dap-ui",
		lazy = false,
		keys = {
			{ "<F7>", "<cmd>DapToggleBreakpoint<cr>" },
			{ "<F8>", "<cmd>DapContinue<cr>" },
			{ "<F9>", "<cmd>DapStepInto<cr>" },
			{ "<F10>", "<cmd>DapTerminate<cr>" },
			{ "<F12>", '<cmd>lua require("dapui").toggle()<cr>' },
		},
		config = function()
			require("dapui").setup()
			local dap, dapui = require("dap"), require("dapui")

			dap.adapters.python = function(cb, config)
				if config.request == "attach" then
					local port = (config.connect or config).port
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
						args = { "-m", "debugpy.adapter" },
						options = {
							source_filetype = "python",
						},
					})
				end
			end
			--
			-- dap.configurations.python = {
			-- 	{
			-- 		type = "python",
			-- 		request = "launch",
			-- 		name = "Launch file",
			-- 		program = "${file}",
			-- 		pythonPath = function()
			-- 			-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			-- 			return vim.fn.getcwd() .. "/.venv/bin/python"
			-- 		end,
			-- 	},
			-- }

			dap.adapters.codelldb = {
				type = "server",
				host = "127.0.0.1",
				port = 13000,
				executable = {
					command = HOMEDIR .. "/.local/share/nvim/mason/bin/codelldb",
					args = { "--port", "13000" },
				},
			}

			dap.configurations.c = {
				{
					type = "codelldb",
					request = "launch",
					cwd = "${workspaceFolder}",
					-- program = function()
					--     return vim.fn.input('Path to executable: ', vim.fn.getcwd()..'/', 'file')
					-- end,
					-- program = "${fileDirname}/${fileBasenameNoExtension}",
					program = "a.out",
					-- program = "/home/julio/.local/share/nvim/mason/bin/codelldb",
					terminal = "integrated",
				},
			}
			dap.configurations.rust = {
				{
					type = "codelldb",
					request = "launch",
					cwd = "${workspaceFolder}",
					-- program = function()
					--     return vim.fn.input("Path to executable: ", vim.fn.getcwd(".") .. "/", "file")
					-- end,
					-- program = "${fileDirname}/${fileBasenameNoExtension}",
					program = "target/release/estudo",
					terminal = "integrated",
				},
			}
			dap.configurations.cpp = dap.configurations.c
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			-- dap.listeners.before.event_terminated["dapui_config"] = function()
			--     dapui.close()
			-- end
			-- dap.listeners.before.event_exited["dapui_config"] = function()
			--     dapui.close()
			-- end
		end,
		dependencies = {
			"https://github.com/mfussenegger/nvim-dap",
			"https://github.com/nvim-neotest/nvim-nio",
		},
	},
	{ "https://github.com/nvim-neotest/nvim-nio" },
	{
		"https://github.com/mfussenegger/nvim-dap-python",
		lazy = false,
		config = function()
			-- require("dap-python").setup({})
			require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
		end,
	},
	{
		"https://github.com/mortepau/codicons.nvim",
		config = function()
			require("codicons").setup()
		end,
	},
	{
		"https://github.com/folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
			})
		end,
	},
	{
		"https://github.com/theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"https://github.com/nvim-neotest/neotest",
		keys = {
			{ "<leader>tt", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Tests summary" },
			{ "<leader>tr", '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', desc = "Test current file" },
			{ "<leader>tw", '<cmd>lua require("neotest").watch.toggle()<cr>', desc = "Test watch" },
			{ "<leader>ts", '<cmd>lua require("neotest").run.run({strategy = "dap"})<cr>', desc = "Test strategy DAP" },
			{ "<leader>ta", '<cmd>lua require("neotest").run.attach()<cr>', desc = "Test attach" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
						runner = "pytest",
						python = "./.venv/bin/python",
					}),
					require("neotest-vitest"),
					require("neotest-plenary"),
					require("neotest-gtest").setup({}),
				},
				discovery = {
					filter_dir = function(name)
						if name == "build" or name:sub(1, 1) == "." then
							return false
						end
						return true
					end,
				},
			})
		end,
		dependencies = {
			"https://github.com/nvim-lua/plenary.nvim",
			"https://github.com/nvim-treesitter/nvim-treesitter",
			"https://github.com/antoinemadec/FixCursorHold.nvim",
			"https://github.com/nvim-neotest/neotest-python",
			"https://github.com/nvim-neotest/neotest-plenary",
			"https://github.com/marilari88/neotest-vitest",
			"https://github.com/alfaix/neotest-gtest",
		},
	},
}
