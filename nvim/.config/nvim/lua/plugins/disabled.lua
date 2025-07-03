-- Delete this condition if you want to execute the file
if true then
  return {}
end

local disabled = {
  {
    "akinsho/bufferline.nvim",
  },
}

for i, plugin in ipairs(disabled) do
  plugin.enabled = false
end

return disabled
