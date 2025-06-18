local prefix = '<leader>o'

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  enabled = true,
  lazy = true,
  ft = { 'markdown' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'blink.cmp',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter',
    'render-markdown.nvim',
  },
  keys = {
    { prefix .. 'o', '<cmd>Obsidian open<CR>', desc = 'Open on App' },
    { prefix .. 'g', '<cmd>Obsidian search<CR>', desc = 'Grep' },
    { prefix .. 'n', '<cmd>Obsidian new<CR>', desc = 'New Note' },
    { prefix .. 'N', '<cmd>Obsidian new_from_template<CR>', desc = 'New Note (Template)' },
    { prefix .. '<space>', '<cmd>Obsidian quick_switch<CR>', desc = 'Find Files' },
    { prefix .. 'b', '<cmd>Obsidian backlinks<CR>', desc = 'Backlinks' },
    { prefix .. 't', '<cmd>Obsidian tags<CR>', desc = 'Tags' },
    { prefix .. 'T', '<cmd>Obsidian template<CR>', desc = 'Template' },
    { prefix .. 'L', '<cmd>Obsidian link<CR>', mode = 'v', desc = 'Link' },
    { prefix .. 'l', '<cmd>Obsidian links<CR>', desc = 'Links' },
    { prefix .. 'l', '<cmd>Obsidian link_new<CR>', mode = 'v', desc = 'New Link' },
    { prefix .. 'e', '<cmd>Obsidian extract_note<CR>', mode = 'v', desc = 'Extract Note' },
    { prefix .. 'w', '<cmd>Obsidian workspace<CR>', desc = 'Workspace' },
    { prefix .. 'r', '<cmd>Obsidian rename<CR>', desc = 'Rename' },
    { prefix .. 'i', '<cmd>Obsidian paste_img<CR>', desc = 'Paste Image' },
  },
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '~/Documents/notes/',
        overrides = {
          notes_subdir = '000 Index',
        },
      },
    },

    mappings = {
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ['<C-c>'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    completion = {
      nvim_cmp = false,
      blink = true,
    },

    notes_subdir = '000 Index',
    new_notes_location = 'notes_subdir',

    ui = {
      enabled = false,
    },

    picker = {
      name = 'telescope.nvim',
      note_mappings = {
        new = '<C-x>',
        insert_link = '<C-l>',
      },
      tag_mappings = {
        tag_note = '<C-x>',
        insert_tag = '<C-l>',
      },
    },

    templates = {
      subdir = '000 Index/001 Templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },

    attachments = {
      img_folder = '999 Images',
    },
  },
}
