/image/light
	plane = LIGHTING_PLANE
	layer = LIGHTING_LAYER
	appearance_flags = KEEP_APART
	icon = 'icons/light.dmi'
	pixel_x = -144
	pixel_y = -144

/atom/movable/light
	plane = LIGHTING_PLANE
	layer = LIGHTING_LAYER
	appearance_flags = KEEP_APART
	icon = 'icons/light.dmi'
	pixel_x = -144
	pixel_y = -144


/proc/add_light(atom/movable/AM, range, color = "")
	var/static/list/lights = list()
	if (lights["[range][color]"])
		AM.vis_contents += lights["[range][color]"]
	else
		var/atom/movable/light/L = new
		L.icon_state = "overlay[range]"
		L.color = color
		lights["[range][color]"] = L
		AM.vis_contents += L