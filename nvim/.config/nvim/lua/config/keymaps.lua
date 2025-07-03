local map = vim.keymap.set

local lazy = require("lazy")

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Disable arrow keys in normal mode
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Search current word
local google_search = function()
  vim.fn.system({ "xdg-open", "https://www.google.com/search?q=" .. vim.fn.expand("<cword>") })
end
map("n", "<leader>?", google_search, { noremap = true, silent = true, desc = "Search Current Word on Brave Search" })

-- Lazy options
map("n", "<leader>l", "<Nop>", { desc = "lazy" })
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- stylua: ignore start
map("n", "<leader>ld", function() vim.fn.system({ "xdg-open", "https://lazyvim.org" }) end, { desc = "LazyVim Docs" })
map("n", "<leader>lr", function() vim.fn.system({ "xdg-open", "https://github.com/LazyVim/LazyVim" }) end, { desc = "LazyVim Repo" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Extras" })
map("n", "<leader>lc", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

map("n", "<leader>lu", function() lazy.update() end, { desc = "Lazy Update" })
map("n", "<leader>lC", function() lazy.check() end, { desc = "Lazy Check" })
map("n", "<leader>ls", function() lazy.sync() end, { desc = "Lazy Sync" })

-- Disable LazyVim bindings
vim.keymap.del("n", "<leader>L")
vim.keymap.del("n", "<leader>fT")

-- Indentation
map("n", "<", "<<", { desc = "Deindent" })
map("n", ">", ">>", { desc = "Indent" })

-- Plugin Info
map("n", "<leader>cif", "<cmd>LazyFormatInfo<cr>", { desc = "Formatting" })
map("n", "<leader>cic", "<cmd>ConformInfo<cr>", { desc = "Conform" })
local linters = function()
  local linters_attached = require("lint").linters_by_ft[vim.bo.filetype]
  local buf_linters = {}

  if not linters_attached then
    LazyVim.warn("No linters attached", { title = "Linter" })
    return
  end

  for _, linter in pairs(linters_attached) do
    table.insert(buf_linters, linter)
  end

  local unique_client_names = table.concat(buf_linters, ", ")
  local linters = string.format("%s", unique_client_names)

  LazyVim.notify(linters, { title = "Linter" })
end
map("n", "<leader>ciL", linters, { desc = "Lint" })
map("n", "<leader>cir", "<cmd>LazyRoot<cr>", { desc = "Root" })

-- U for redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- Open typst in pdf
vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match("%.typ$") then
    local pdf_path = filepath:gsub("%.typ$", ".pdf")
    vim.system({ "xdg-open", pdf_path }) -- macOS
    -- For Linux, you might use `xdg-open` instead:
    -- vim.system({ "xdg-open", pdf_path })
  end
end, {})

vim.keymap.set("n", "<leader>p", "<cmd>OpenPdf<cr>", { noremap = true, silent = true })
