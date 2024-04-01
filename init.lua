vim.opt.number = true         -- show line numbers
vim.opt.clipboard = 'unnamed' -- use system clipboard by default
vim.opt.expandtab = true      -- always uses spaces instead of tabs
vim.opt.softtabstop = 2       -- insert 2 spaces when tab is pressed
vim.opt.shiftwidth = 2        -- an indent is 2 spaces
vim.opt.termguicolors = true  -- enable 24-bit colour
vim.opt.signcolumn = 'yes'    -- always show the signcolumn
vim.opt.wildignore = '*/dist/*, */target/*, */node_modules/*'

local keyset = vim.keymap.set

keyset('', '<Tab>', ':BufferNext<CR>')                   -- cycle between buffers
keyset('', '<C-f>', ':vimgrep! <cword> **/*<CR>:cw<CR>') -- global search in files
keyset('', '<F1>', ':FTermOpen<CR>')                     -- open terminal
keyset('', '<F2>', '<C-W>w')                             -- switch between panels
keyset('', '<F3>', ':cclose<CR>')                        -- close quickfix window
keyset('', '<F5>', ':DapContinue<CR>')
keyset('', '<F17>', ':DapTerminate<CR>')                 -- F17 === Shift+F5
keyset('', '<F9>', ':DapToggleBreakpoint<CR>')
keyset('', '<F10>', ':DapStepOver<CR>')
keyset('', '<F11>', ':DapStepInto<CR>')
keyset('', '<F23>', ':DapStepOut<CR>')                   -- F23 === Shift+F11

-- map <Shift>-Arrows to selecting characters/lines
keyset('n', '<S-Up>', 'v<Up>')
keyset('n', '<S-Down>', 'v<Down>')
keyset('n', '<S-Left>', 'v<Left>')
keyset('n', '<S-Right>', 'v<Right>')
keyset('v', '<S-Up>', '<Up>')
keyset('v', '<S-Down>', '<Down>')
keyset('v', '<S-Left>', '<Left>')
keyset('v', '<S-Right>', '<Right>')

-- switch between buffers with \number
keyset('n', '<leader>1', ':BufferGoto 1<CR>')
keyset('n', '<leader>2', ':BufferGoto 2<CR>')
keyset('n', '<leader>3', ':BufferGoto 3<CR>')
keyset('n', '<leader>4', ':BufferGoto 4<CR>')
keyset('n', '<leader>5', ':BufferGoto 5<CR>')
keyset('n', '<leader>6', ':BufferGoto 6<CR>')
keyset('n', '<leader>7', ':BufferGoto 7<CR>')
keyset('n', '<leader>8', ':BufferGoto 8<CR>')
keyset('n', '<leader>9', ':BufferGoto 9<CR>')
keyset('n', '<leader>0', ':tablast<CR>')

--vim.cmd([[packadd termdebug]])
--vim.cmd([[autocmd BufWinEnter * Neotree action=show reveal]])

require('plugins')
require('autocmp')
require('dap-config/ui')

vim.cmd.colorscheme('monokai-pro')

local fterm = require('FTerm')

vim.api.nvim_create_user_command('FTermOpen', fterm.open, { bang = true })

vim.api.nvim_create_user_command('SourceTree', ':silent exec "!/Applications/SourceTree.app/Contents/Resources/stree"', {})

vim.api.nvim_create_user_command('PIORun', function()
  fterm.run('pio run')
end, { bang = true })

vim.api.nvim_create_user_command('PIODebug', function()
  fterm.run('pio debug')
end, { bang = true })

vim.api.nvim_create_user_command('PIOUpload', function()
  fterm.run('pio run --target=upload')
end, { bang = true })

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

