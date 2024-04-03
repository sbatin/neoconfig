--dap.adapters.gdb = {
--  type = 'executable',
--  command = 'arm-none-eabi-gdb',
--  args = { '-i', 'dap' }
--}
--
--require('dap.ext.vscode').type_to_filetypes['gdb'] = {'c', 'cpp'}

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

require('dap.ext.vscode').load_launchjs()

