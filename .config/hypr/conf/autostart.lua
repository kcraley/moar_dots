-- Autostart necessary processes (like notification daemons, status bars, etc.)
-- REF: https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("swaync")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hyprctl setcursor Bibata-Original-Ice 28")

	-- Automatically start up user applications.
	hl.exec_cmd("/opt/google/chrome/chrome", { workspace = "1 silent" })
	hl.exec_cmd("/usr/bin/ghostty", { workspace = "2 silent" })
	hl.exec_cmd("/usr/bin/signal-desktop", { workspace = "3 silent" })
	hl.exec_cmd("/usr/bin/spotify", { workspace = "4 silent" })
	hl.exec_cmd("/usr/bin/dolphin", { workspace = "5 silent" })
	hl.exec_cmd("/usr/bin/discord", { workspace = "6 silent" })
end)
