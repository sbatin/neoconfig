vim.opt.number = true         -- show line numbers
vim.opt.clipboard = 'unnamed' -- use system clipboard by default
vim.opt.expandtab = true      -- always uses spaces instead of tabs
vim.opt.softtabstop = 2       -- insert 2 spaces when tab is pressed
vim.opt.shiftwidth = 2        -- an indent is 2 spaces
vim.opt.termguicolors = true  -- enable 24-bit colour
vim.opt.signcolumn = 'yes'    -- always show the signcolumn
vim.opt.wildignore = '*/dist/*, */target/*, */node_modules/*'

local keyset = vim.keymap.set

keyset('', '<Tab>', '<C-W>w')                     -- switch between panels
keyset('', '<F1>' , ':FTermOpen<CR>')
keyset('', '<F2>' , ':Telescope buffers<CR>')
keyset('', '<F3>' , ':Telescope live_grep<CR>')
keyset('', '<F5>' , ':DapContinue<CR>')
keyset('', '<F17>', ':DapTerminate<CR>')          -- F17 === Shift+F5
keyset('', '<F9>' , ':DapToggleBreakpoint<CR>')
keyset('', '<F10>', ':DapStepOver<CR>')
keyset('', '<F11>', ':DapStepInto<CR>')
keyset('', '<F23>', ':DapStepOut<CR>')            -- F23 === Shift+F11
keyset('', '<C-f>', ':Telescope grep_string<CR>')
keyset('', '<C-p>', ':Telescope find_files<CR>')

-- map <Shift>-Arrows to selecting characters/lines
keyset('n', '<S-Up>'   , 'v<Up>')
keyset('n', '<S-Down>' , 'v<Down>')
keyset('n', '<S-Left>' , 'v<Left>')
keyset('n', '<S-Right>', 'v<Right>')
keyset('v', '<S-Up>'   , '<Up>')
keyset('v', '<S-Down>' , '<Down>')
keyset('v', '<S-Left>' , '<Left>')
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
keyset('n', '<leader>0', ':BufferLast<CR>')
keyset('n', '<leader>q', ':BufferClose<CR>')

-- override default diagnostic icons
local signs = { Error = '󰅚', Warn = '󰀪', Hint = '󰌶', Info = '' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

--vim.cmd([[packadd termdebug]])
--vim.cmd([[autocmd BufWinEnter * Neotree action=show reveal]])
vim.cmd.colorscheme('vscode')

require('plugins')
require('autocmp')
require('dap-config/ui')
require('dap-config/adapters')

vim.api.nvim_create_user_command('SourceTree', ':silent exec "!/Applications/SourceTree.app/Contents/Resources/stree"', {})

local fterm = require('FTerm')

vim.api.nvim_create_user_command('PIORun', function()
  fterm.scratch({ cmd = 'pio run' })
end, { bang = true })

vim.api.nvim_create_user_command('PIOUpload', function()
  fterm.scratch({ cmd = 'pio run --target=upload' })
end, { bang = true })

vim.api.nvim_create_user_command('PIORefresh', function()
  fterm.scratch({ cmd = 'pio run --target=compiledb' })
end, { bang = true })

-- regenerate compile_commands.json and restart LSP server
-- every time platformio.ini file changes
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'platformio.ini',
  command = ':silent exec "!pio run -s -t compiledb" | LspRestart'
})
