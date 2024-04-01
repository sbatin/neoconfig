vim.api.nvim_set_hl(0, 'debugBreak', { fg = 'red' })
vim.api.nvim_set_hl(0, 'debugStopped', { fg = '', bg = '#3d59a1' })
vim.fn.sign_define('DapBreakpoint',          { text = '', texthl = 'debugBreak', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'debugBreak', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected',  { text = '', texthl = 'debugBreak', linehl = '', numhl = ''})
vim.fn.sign_define('DapStopped',             { text = '⮕', texthl = '', linehl = 'debugStopped', numhl = ''})

-- see more https://github.com/rcarriga/nvim-dap-ui
local dapui = require('dapui')
dapui.setup({
  layouts = {
    {
      position = 'left',
      size = 40,
      elements = {
        {
          id = 'scopes',
          size = 0.25
        }, {
          id = 'breakpoints',
          size = 0.25
        }, {
          id = 'stacks',
          size = 0.25
        }, {
          id = 'watches',
          size = 0.25
        }
      }
    },
    {
      position = 'bottom',
      size = 10,
      elements = {
        {
          id = 'repl',
          size = 1.0
        }
      }
    }
  },
})

local dap = require('dap')

dap.listeners.before.attach.dapui_config = function()
  vim.cmd.Neotree('close')
  dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
  vim.cmd.Neotree('close')
  dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
  vim.cmd.Neotree('show')
end

dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
  vim.cmd.Neotree('show')
end

