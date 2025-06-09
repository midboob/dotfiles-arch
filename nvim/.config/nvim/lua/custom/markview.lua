return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  config = function()
    require('markview').setup {
      preview = {
        enable = true,
        filetypes = { 'md' }, -- Only activate for markdown files
        -- ... other options as needed ...
      },
      -- ... other configuration sections ...
    }
  end,
}
