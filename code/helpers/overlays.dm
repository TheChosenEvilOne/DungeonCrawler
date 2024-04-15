/atom/proc/create_overlay(obj/item/equippable/from)
	var/image/overlay = new
	overlay.icon = from.worn_icon
	overlay.icon_state = from.worn_icon_state
	overlay.layer = from.layer
	return overlay

/atom/proc/update_overlays(list/overlay_list)
	overlays.Cut()
	var/mutable_appearance/MA = new(src)
	for(var/overlay in overlay_list)
		MA.overlays += overlay
	appearance = MA