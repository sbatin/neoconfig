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
keyset('', '<F1>' , ':FTerm<CR>')
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

vim.api.nvim_create_user_command('SourceTree', ':silent exec "!/Applications/SourceTree.app/Contents/Resources/stree"', {})

vim.lsp.enable({'clangd', 'tsserver'})

require('lazy-setup')
