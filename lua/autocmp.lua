-- Having longer updatetime (default is 4000 ms) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

--vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
--vim.opt.shortmess = vim.opt.shortmess + { c = true }

vim.api.nvim_create_autocmd('CursorHold', {
  pattern = '*',
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

local cmp = require('cmp')

cmp.setup({
  snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
        --vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer', keyword_length = 2 },
    { name = 'vsnip' },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

