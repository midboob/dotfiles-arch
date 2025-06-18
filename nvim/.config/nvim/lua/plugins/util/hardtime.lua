return {
  'm4xshen/hardtime.nvim',
  enabled = false,
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    disabled_filetypes = {
      'qf',
      'netrw',
      'NvimTree',
      'lazy',
      'mason',
      'oil',
      'neo-tree',
      'symbols-outline',
      'vim-be-good',
      'oil',
      'outline',
    },
    restriction_mode = 'hint',
  },
}
