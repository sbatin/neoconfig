return {
  {
    'Mofiqul/vscode.nvim',
    lazy = false,    -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme('vscode')
      -- define some custom highlight groups
      local c = require('vscode.colors').get_colors()
      vim.api.nvim_set_hl(0, 'debugBreak', { fg = c.vscRed })
      vim.api.nvim_set_hl(0, 'debugStopped', { fg = c.vscDarkYellow })
    end
  },

  -- File search, buffer management etc.
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      pickers = {
        grep_string = {
          word_match = '-w',
        },
      },
    }
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
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
    cmd = 'FTermOpen',
    config = function()
      local fterm = require('FTerm')
      vim.api.nvim_create_user_command('FTermOpen', fterm.open, { bang = true })
    end
  },

  -- Git integration
  'tpope/vim-fugitive',

  -- PlatformIO
  {
    dir = '~/Projects/platformio-nvim/',
    dependencies = 'numToStr/FTerm.nvim',
    cmd = 'PIO',
    config = true,
  },

  -- Better syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all"
        ensure_installed = { 'c', 'cpp' },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end
  },

  -- Language-specific plugins
  'mrcjkb/rustaceanvim',
}
