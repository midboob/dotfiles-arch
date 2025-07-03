return {
  { import = "lazyvim.plugins.extras.editor.telescope" },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>fp", pick, desc = "Projects" },
    },
  },
}
