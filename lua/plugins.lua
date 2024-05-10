return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color themes, UI icons
  use 'Mofiqul/vscode.nvim'
  use 'nvim-tree/nvim-web-devicons'

  -- Project tree
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

  -- File search, buffer management etc.
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- Status line
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

  -- Tabbar
  use 'romgrk/barbar.nvim'

  -- Terminal
  use {
    'numToStr/FTerm.nvim',
    config = function()
      local fterm = require('FTerm')
      vim.api.nvim_create_user_command('FTermOpen', fterm.open, { bang = true })
    end
  }

  -- Git integration
  use 'tpope/vim-fugitive'

  -- Better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all"
        ensure_installed = { 'c', 'cpp' },
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      })
    end
  }

  -- LSP client configs
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').clangd.setup({
        cmd = { 'clangd', '--query-driver=/**/arm-none-eabi-g*,/**/avr-g*' },
        filetypes = { 'c', 'cpp' },
      })
    end
  }

  -- Autocompleter
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
  use {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup()
    end
  }

  -- Language-specific plugins
  use 'mrcjkb/rustaceanvim'
end)
