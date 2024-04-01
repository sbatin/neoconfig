return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color themes
  use {
    'loctvl842/monokai-pro.nvim',
    config = function()
      require('monokai-pro').setup()
    end
  }

  -- Generic plugins
  use 'nvim-tree/nvim-web-devicons'

  use 'numToStr/FTerm.nvim'

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup({
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
      })
      require('neo-tree.sources.manager').show('filesystem')
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          disabled_filetypes = {'neo-tree'},
          ignore_focus = {
            'dapui_watches', 'dapui_breakpoints',
            'dapui_scopes', 'dapui_console',
            'dapui_stacks', 'dap-repl'
          }
        }
      })
    end
  }

  use 'romgrk/barbar.nvim'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Debugger
  use 'mfussenegger/nvim-dap'
  use 'jedrzejboczar/nvim-dap-cortex-debug'
  use {
    'rcarriga/nvim-dap-ui',
    requires = 'nvim-neotest/nvim-nio'
  }

  -- Language-specific plugins
  use 'mrcjkb/rustaceanvim'
end)
