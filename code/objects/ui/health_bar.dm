/ui_element/health_bar
	icon = 'icons/ui24.dmi'
	icon_state = "pbar"

/ui_element/health_bar/mask
	icon_state = "pbarmask"
/ui_element/health_bar/mask/New()

/ui_element/health_bar/fill
	icon_state = "pbarfill"
	blend_mode = BLEND_MULTIPLY
	appearance_flags = KEEP_TOGETHER
/ui_element/health_bar/fill/New()

/ui_element/health_bar/New()
	. = ..()
	var/ui_element/mask = new /ui_element/health_bar/mask
	var/ui_element/fill = new /ui_element/health_bar/fill
	mask.vis_contents += fill
	vis_contents += mask
	animate(fill, transform = turn(matrix(), 90), loop = -1, time = 80)
	animate( transform = turn(matrix(), 180), time = 80)
	animate( transform = null, time = 0)