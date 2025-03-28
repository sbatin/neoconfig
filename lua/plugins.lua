return {
  -- Color themes, UI icons
  'Mofiqul/vscode.nvim',
  'nvim-tree/nvim-web-devicons',

  -- Project tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      close_if_last_window = true,
      window = {
        width = 32,
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
        },
      },
    },
    init = function()
      require('neo-tree.sources.manager').show('filesystem')
    end
  },

  -- File search, buffer management etc.
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = 'nvim-lua/plenary.nvim'
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        disabled_filetypes = {'neo-tree'},
        ignore_focus = {
          'dapui_watches', 'dapui_breakpoints',
          'dapui_scopes', 'dapui_console',
          'dapui_stacks', 'dap-repl'
        }
      }
    }
  },

  -- Tabbar
  'romgrk/barbar.nvim',

  -- Terminal
  {
    'numToStr/FTerm.nvim',
    init = function()
      local fterm = require('FTerm')
      vim.api.nvim_create_user_command('FTermOpen', fterm.open, { bang = true })
    end
  },

  -- Git integration
  'tpope/vim-fugitive',

  -- Better syntax highlighting
  --{
  --  'nvim-treesitter/nvim-treesitter',
  --  run = ':TSUpdate',
  --  init = function()
  --    require('nvim-treesitter.configs').setup({
  --      -- A list of parser names, or "all"
  --      ensure_installed = { 'c', 'cpp' },
  --      highlight = {
  --        enable = true,
  --        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  --        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  --        -- Using this option may slow down your editor, and you may see some duplicate highlights.
  --        -- Instead of true it can also be a list of languages
  --        additional_vim_regex_highlighting = false,
  --      },
  --    })
  --  end
  --},

  -- Autocompleter
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
    init = function()
      -- Having longer updatetime (default is 4000 ms) leads to noticeable
      -- delays and poor user experience
      vim.opt.updatetime = 300

      --vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
      --vim.opt.shortmess = vim.opt.shortmess + { c = true }

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
    end
  },

  -- Debugger
  'mfussenegger/nvim-dap',
  'jedrzejboczar/nvim-dap-cortex-debug',
  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'nvim-neotest/nvim-nio'
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    init = function()
      require('nvim-dap-virtual-text').setup()
    end
  },

  -- Language-specific plugins
  'mrcjkb/rustaceanvim',
}
