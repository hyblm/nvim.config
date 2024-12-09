return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dapui.setup()
			require("dap-python").setup("python3")
			require("nvim-dap-virtual-text").setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>dc", dap.continue, {})
		end,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = {
		"nvim-neotest/nvim-nio",
	} },
	"theHamsta/nvim-dap-virtual-text",
	"mfussenegger/nvim-dap-python",
}
