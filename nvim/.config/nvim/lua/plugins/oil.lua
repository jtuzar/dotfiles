return {
  {
    "jtuzar/oil-lsp-diagnostics.nvim",
    dependencies = { "stevearc/oil.nvim" },
    opts = {}
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    lazy = false,
    -- Optional dependencies
    dependencies = { 'nvim-mini/mini.icons', opts = {} },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        use_default_keymaps = false,
        watch_for_changes = false,
        win_options = {
          signcolumn = "yes:2",
        },
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['sh'] = 'actions.select_vsplit',
          ['sv'] = 'actions.select_split',
          ['st'] = 'actions.select_tab',
          ['op'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['or'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = 'actions.tcd',
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['g.'] = 'actions.toggle_hidden',
          ['g\\'] = 'actions.toggle_trash',
        },
        view_options = {
          show_hidden = true,
        },
      }
    end,
    keys = {
      { '<leader>e', '<cmd>Oil<cr>', mode = 'n', desc = '[E]xplorer open' },
    },
  } }
