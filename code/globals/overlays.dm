/proc/create_overlay(from)
	var/obj/overlay = new
	overlay.icon = from?:worn_icon
	overlay.icon_state = from?:worn_icon_state
	overlay.layer = from?:layer
	return overlay