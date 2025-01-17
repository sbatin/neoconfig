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
