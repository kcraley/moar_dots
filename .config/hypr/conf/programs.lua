-- Define a set of custom programs.
-- Locals are not shared between files, so these are returned as a table.
-- Use with: local programs = require("conf.programs")

return {
	fileManager = "dolphin",
	lockscreen = "hyprlock",
	menu = "wofi --show drun",
	terminal = "ghostty",
}
