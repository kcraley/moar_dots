-- Reorder Workspaces to match monitor orientation.
-- REF: https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- REF: https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Left (DP-1): 1, 4, 7, 0. Center (DP-2): 2, 5, 8. Right (DP-3): 3, 6, 9.
hl.workspace_rule({ workspace = "1", default = true, monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", default = true, monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", default = true, monitor = "DP-3" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-2" })
hl.workspace_rule({ workspace = "6", monitor = "DP-3" })
hl.workspace_rule({ workspace = "7", monitor = "DP-1" })
hl.workspace_rule({ workspace = "8", monitor = "DP-2" })
hl.workspace_rule({ workspace = "9", monitor = "DP-3" })
hl.workspace_rule({ workspace = "0", monitor = "DP-1" })

-- "Smart gaps" / "No gaps when only"
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })

-- Ignore maximize requests from applications.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland.
-- hl.window_rule({
-- 	name = "fix-xwayland-drags",
-- 	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
-- 	no_focus = true,
-- })
