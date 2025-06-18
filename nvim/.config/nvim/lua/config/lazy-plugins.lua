-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({

  -- require 'plugins/gitsigns',
  -- require 'plugins/which-key',
  -- require 'plugins/telescope',
  -- require 'plugins/lspconfig',
  -- require 'plugins/conform',
  -- require 'plugins/blink-cmp',
  -- require 'plugins/tokyonight',
  -- require 'plugins/todo-comments',
  -- require 'plugins/mini',
  -- require 'plugins/treesitter',
  -- require 'plugins.neo-tree',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  { import = 'plugins' },
  { import = 'plugins.coding' },
  { import = 'plugins.dap' },
  { import = 'plugins.editor' },
  { import = 'plugins.formatting' },
  -- { import = 'plugins.lang' },
  { import = 'plugins.linting' },
  { import = 'plugins.lsp' },
  { import = 'plugins.ui' },
  { import = 'plugins.util' },

  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = {},
  },
})

-- vim: ts=2 sts=2 sw=2 et
