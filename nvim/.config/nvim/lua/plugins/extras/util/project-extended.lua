return {
  { import = "lazyvim.plugins.extras.util.project" },
  "ahmedkhalf/project.nvim",
  opts = {
    manual_mode = false,
    silent_chdir = false,
    show_hidden = true,
  },
  event = "VeryLazy",
  config = function(_, opts)
    require("project_nvim").setup(opts)
    local history = require("project_nvim.utils.history")
    history.delete_project = function(project)
      for k, v in pairs(history.recent_projects) do
        if v == project.value then
          history.recent_projects[k] = nil
          return
        end
      end
    end
    LazyVim.on_load("telescope.nvim", function()
      require("telescope").load_extension("projects")
    end)
  end,
}
