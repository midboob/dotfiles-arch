require("full-border"):setup()

require("bunny"):setup({
	hops = {
		{ key = "/", path = "/" },
		{ key = "t", path = "/tmp" },
		{ key = "h", path = "~", desc = "Home" },
		{ key = "d", path = "~/Downloads/", desc = "Downloads" },
		{ key = "D", path = "~/Documents", desc = "Documents" },
		{ key = "c", path = "~/.config", desc = "Config" },
		{ key = { "l", "s" }, path = "~/.local/share", desc = "Local share" },
		{ key = { "l", "b" }, path = "~/.local/bin", desc = "Local bin" },
		{ key = { "l", "t" }, path = "~/.local/state", desc = "Local state" },
		{ key = { "s", "p" }, path = "/mnt/Storage/Pictures", desc = "Storage Pictures" },
		-- key and path attributes are required, desc is optional
	},
	desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
	ephemeral = true, -- Enable ephemeral hops, default is true
	tabs = true, -- Enable tab hops, default is true
	notify = false, -- Notify after hopping, default is false
	fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
})

require("pref-by-location"):setup({})

require("restore"):setup({
	-- Set the position for confirm and overwrite dialogs.
	-- don't forget to set height: `h = xx`
	-- https://yazi-rs.github.io/docs/plugins/utils/#ya.input
	position = { "center", w = 70, h = 40 }, -- Optional

	-- Show confirm dialog before restore.
	-- NOTE: even if set this to false, overwrite dialog still pop up
	show_confirm = true, -- Optional
})
