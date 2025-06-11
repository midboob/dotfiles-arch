return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    'BufReadPre `/Documents/vault/*.md',
    'BufNewFile `/Documents/vault/*.md',
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },

  opts = {
    workspaces = {
      {
        name = 'vault',
        path = '~/Documents/vault/',
        overrides = {
          notes_subdir = '000 Index',
        },
      },
    },

    mappings = {
      ['<leader>ch'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },

    completions = {
      nvim_cmp = true,
      -- Minimum amount of characters for completion to trigger
      min_chars = 3,
    },

    notes_subdir = '000 Index',
    new_notes_location = 'notes_subdir',
  },
}
