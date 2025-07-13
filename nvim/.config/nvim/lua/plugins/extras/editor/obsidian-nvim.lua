local prefix = "<leader>o"

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = { "markdown" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  keys = {
    { prefix, "<Nop>", desc = "obsidian" },
    { prefix .. "o", "<cmd>Obsidian open<CR>", desc = "Open on App" },
    { prefix .. "g", "<cmd>Obsidian search<CR>", desc = "Grep" },
    { prefix .. "n", "<cmd>Obsidian new<CR>", desc = "New Note" },
    { prefix .. "N", "<cmd>Obsidian new_from_template<CR>", desc = "New Note (Template)" },
    { prefix .. "<space>", "<cmd>Obsidian quick_switch<CR>", desc = "Find Files" },
    { prefix .. "b", "<cmd>Obsidian backlinks<CR>", desc = "Backlinks" },
    { prefix .. "t", "<cmd>Obsidian tags<CR>", desc = "Tags" },
    { prefix .. "T", "<cmd>Obsidian template<CR>", desc = "Template" },
    { prefix .. "L", "<cmd>Obsidian link<CR>", mode = "v", desc = "Link" },
    { prefix .. "l", "<cmd>Obsidian links<CR>", desc = "Links" },
    { prefix .. "l", "<cmd>Obsidian link_new<CR>", mode = "v", desc = "New Link" },
    { prefix .. "e", "<cmd>Obsidian extract_note<CR>", mode = "v", desc = "Extract Note" },
    { prefix .. "w", "<cmd>Obsidian workspace<CR>", desc = "Workspace" },
    { prefix .. "r", "<cmd>Obsidian rename<CR>", desc = "Rename" },
    { prefix .. "i", "<cmd>Obsidian paste_img<CR>", desc = "Paste Image" },
    { prefix .. "p", "<cmd>MarkdownPreview<CR>", desc = "Preview File" },
  },

  opts = {
    workspaces = {
      -- {
      --   name = "notes",
      --   path = "~/Documents/notes/",
      -- },
      {
        name = "notes",
        path = "/mnt/Storage/Documents/notes/",
      },
    },

    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<M-c>"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },

    notes_subdir = "000 Index",
    new_notes_location = "notes_subdir",

    ui = {
      enable = false,
    },

    disable_frontmatter = false,

    ---@return table
    note_frontmatter_func = function(note)
      local out = {
        id = note.id,
        aliases = note.aliases,
        tags = note.tags,
        links = note.metadata and note.metadata.links or {},
      }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    note_id_func = function(title)
      return title
    end,
    note_path_func = function(spec)
      return spec.dir / (spec.title .. ".md")
    end,

    picker = {
      name = "snacks.pick",
      note_mappings = {
        new = "<C-x>",
        insert_link = "<C-l>",
      },
      tag_mappings = {
        tag_note = "<C-x>",
        insert_tag = "<C-l>",
      },
    },

    templates = {
      subdir = "000 Index/001 Templates/",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    attachments = {
      img_folder = "999 Images/",
      img_name_func = function()
        return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
      end,
      img_text_func = function(client, path)
        -- Use the base name and make it a wikilink
        return string.format("![[%s]]", path.name)
      end,
      confirm_img_paste = false,
    },
  },
}
