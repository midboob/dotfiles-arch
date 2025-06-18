return {
  'folke/snacks.nvim',
  enabled = true,
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = {
      enabled = false,
      width = 60,
      pane_gap = 16,
      sections = {
        {
          section = 'header',
          align = 'center',
          enabled = function()
            return not (vim.o.columns > 135)
          end,
        },
        {
          pane = 1,
          {
            enabled = function()
              return vim.o.columns > 135
            end,
            section = 'terminal',
            cmd = 'chafa ~/.config/nvim/lua/custom/plugins/anime-girl-nobg-crop.png --size 52x32 --format symbols --stretch --align center; sleep .1',
            height = 32,
            width = 56,
            padding = 1,
          },
          {
            section = 'startup',
            padding = 1,
            enabled = function()
              return vim.o.columns > 135
            end,
          },
        },
        {
          pane = 2,
          { section = 'keys', padding = 2, gap = 1 },
          {
            icon = ' ',
            title = 'Recent Files',
          },
          {
            section = 'recent_files',
            opts = { limit = 3 },
            indent = 2,
            padding = 1,
          },
          {
            icon = ' ',
            title = 'Projects',
          },
          {
            section = 'projects',
            opts = { limit = 3 },
            indent = 2,
            padding = 1,
          },
          {
            section = 'startup',
            padding = 1,
            enabled = function()
              return not (vim.o.columns > 135)
            end,
          },
        },
      },
    },
    explorer = { enabled = false },
    image = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = true },
    picker = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    toggle = {},
    words = { enabled = false },
    styles = {
      notification = {
        border = 'rounded',
        zindex = 100,
        ft = 'markdown',
        wo = {
          winblend = 5,
          wrap = false,
          conceallevel = 2,
          colorcolumn = '',
        },
        bo = { filetype = 'snacks_notif' },
      },
      notification_history = {
        border = 'rounded',
        zindex = 100,
        width = 0.6,
        height = 0.6,
        minimal = false,
        title = ' Notification History ',
        title_pos = 'center',
        ft = 'markdown',
        bo = { filetype = 'snacks_notif_history', modifiable = false },
        wo = { winhighlight = 'Normal:SnacksNotifierHistory' },
        keys = { q = 'close' },
      },
    },
  },
  keys = {
    {
      '<leader>n',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification History',
    },
  },
}
