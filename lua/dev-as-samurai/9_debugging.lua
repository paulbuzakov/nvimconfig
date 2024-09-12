local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")
  local dapExt = require("dap.ext.vscode")

  dap.adapters.coreclr = {
    type = "executable",
    command = "/Users/paulbuzakov/.config/netcoredbg/netcoredbg",
    args = { "--interpreter=vscode" },
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
    },
  }

  dapExt.load_launchjs()

  dapui.setup()

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

  vim.keymap.set("n", "<F5>", function()
    dap.continue()
  end)

  vim.keymap.set("n", "<F10>", function()
    dap.step_over()
  end)

  vim.keymap.set("n", "<F11>", function()
    dap.step_into()
  end)

  vim.keymap.set("n", "<F9>", function()
    dap.toggle_breakpoint()
  end)
end

return M
