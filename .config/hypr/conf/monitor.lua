-- Monitor configuration.
-- REF: https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Left.
hl.monitor({
	output = "DP-1",
	mode = "highres@highrr",
	position = "-2560x0",
	scale = "auto",
})

-- Center.
hl.monitor({
	output = "DP-2",
	mode = "highres@highrr",
	position = "0x0",
	scale = "auto",
})

-- Right.
hl.monitor({
	output = "DP-3",
	mode = "highres@highrr",
	position = "2560x0",
	scale = "auto",
})
