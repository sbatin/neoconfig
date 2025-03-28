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

-- override default diagnostic signs
vim.diagnostic.config({
  --virtual_text = true,
  --virtual_lines = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌶',
    }
  }
})

vim.api.nvim_create_autocmd('CursorHold', {
  pattern = '*',
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

vim.lsp.enable({'clangd'})

require('lazy-setup')
--vim.cmd([[packadd termdebug]])

-- define some custom highlight groups
local c = require('vscode.colors').get_colors()
vim.api.nvim_set_hl(0, 'debugBreak', { fg = c.vscRed })
vim.api.nvim_set_hl(0, 'debugStopped', { fg = c.vscDarkYellow })

vim.api.nvim_create_user_command('SourceTree', ':silent exec "!/Applications/SourceTree.app/Contents/Resources/stree"', {})

local pio = function(opts)
  local fterm = require('FTerm')
  local param = opts.fargs[1]

  if param == 'run' then
    fterm.scratch({ cmd = 'pio run' })
  elseif param == 'upload' then
    fterm.scratch({ cmd = 'pio run --target=upload' })
  elseif param == 'compiledb' then
    fterm.scratch({ cmd = 'pio run --target=compiledb' })
  elseif param == 'check' then
    fterm.scratch({ cmd = 'pio check' })
  end
end

vim.api.nvim_create_user_command('PIO', pio, {
  nargs = 1,
  desc = 'Execute PlatformIO command',
  bang = true,
  complete = function(ArgLead, CmdLine, CursorPos)
    return { 'run', 'upload', 'compiledb', 'check' }
  end,
})

-- regenerate compile_commands.json and restart LSP server
-- every time platformio.ini file changes
--vim.api.nvim_create_autocmd('BufWritePost', {
--  pattern = 'platformio.ini',
--  command = ':silent exec "!pio run -s -t compiledb" | LspRestart'
--})
