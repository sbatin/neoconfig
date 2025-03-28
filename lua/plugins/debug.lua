return {
  {
    'mfussenegger/nvim-dap',
    dependencies = 'jedrzejboczar/nvim-dap-cortex-debug',
    init = function()
      vim.fn.sign_define('DapBreakpoint',          { text = '', texthl = 'debugBreak', linehl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'debugBreak', linehl = '' })
      vim.fn.sign_define('DapBreakpointRejected',  { text = '', texthl = 'debugBreak', linehl = '' })
      vim.fn.sign_define('DapStopped',             { text = '󰌕', texthl = 'debugStopped', linehl = 'debugPC' })

      local dap = require('dap')

      dap.adapters['arm-gdb'] = {
        type = 'executable',
        command = 'arm-none-eabi-gdb',
        args = { '-i', 'dap' },
      }

      dap.adapters.lldb = {
        type = 'executable',
        command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
      }

      -- see https://github.com/jedrzejboczar/nvim-dap-cortex-debug for more info
      require('dap-cortex-debug').setup({
        debug = false,       -- log debug messages
        -- path to cortex-debug extension, supports vim.fn.glob
        -- by default tries to guess: mason.nvim or VSCode extensions
        extension_path = nil,
        lib_extension = nil, -- shared libraries extension, tries auto-detecting, e.g. 'so' on unix
        node_path = 'node',  -- path to node.js executable
        dapui_rtt = true,    -- register nvim-dap-ui RTT element
        -- make :DapLoadLaunchJSON register cortex-debug for C/C++, set false to disable
        dap_vscode_filetypes = { 'c', 'cpp' },
      })
    end
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'nvim-neotest/nvim-nio',
    opts = {
      -- see more https://github.com/rcarriga/nvim-dap-ui
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
    },
    init = function()
      local dap = require('dap')
      local dapui = require('dapui')

      vim.api.nvim_create_user_command('DapExit', function()
        dapui.close()
        vim.cmd.Neotree('show')
      end, {})

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
    end
  },
}
