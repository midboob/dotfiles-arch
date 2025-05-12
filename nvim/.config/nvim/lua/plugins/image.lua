return {
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    opts = {
      backend = "kitty",
      processor = "magick_cli",
      resolve_image_path = function(document_path, image_path, fallback)
        local working_dir = vim.fn.getcwd()
        -- Format image path for Obsidian notes
        if working_dir:find("/mnt/Storage/Documents/My Safe/") then
          return working_dir .. "/" .. image_path
        end
        -- Fallback to the default behavior
        return fallback(document_path, image_path)
      end,
    },
  },
}
