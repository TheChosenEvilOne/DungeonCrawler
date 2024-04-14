/obj/item
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	interactions = list("Pick Up" = list("Pick Up", .proc/pick_up))
	var/rarity = 0

// Returns true if successfully picked up.
/obj/item/proc/pick_up(mob/M, slot = 0)
	return M.pick_up(src, slot)

/obj/item/proc/on_use(mob/M)

// Returns true if dropping is allowed.
/obj/item/proc/drop(mob/M, location = M.loc)
	loc = location
	return TRUE

/obj/item/MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
	if (get_dist(usr, src) > 1)
		return
	if (istype(over_object, /ui_element/item_slot))
		var/ui_element/item_slot/slot = over_object
		if (slot.item) return
		pick_up(usr, slot.slot_number)