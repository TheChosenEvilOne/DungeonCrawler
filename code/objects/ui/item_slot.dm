/ui_element/item_slot
	icon_state = "invslot"
	layer = OBJ_LAYER-1
	var/slot_number
	var/obj/item/item

/ui_element/item_slot/proc/insert_item(obj/item/I)
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	item = I
	overlays += I
	var/image/img = image(icon = 'icons/ui.dmi', icon_state = "rarity")
	img.color = rarity_color(I.rarity)
	overlays += img
	if (istype(I, /obj/item/equipable))
		img = image(icon = 'icons/ui.dmi', icon_state = "equip")
		img.color = "#ccc"
		overlays += img
	name = I.name

/ui_element/item_slot/proc/remove_item()
	mouse_drag_pointer = MOUSE_INACTIVE_POINTER
	item = null
	name = ""
	overlays.Cut()

/ui_element/item_slot/examine()
	return item ? item.examine() : list()

/ui_element/item_slot/Click(location,control,params)
	params = params2list(params)
	if (params["middle"])
		usr.drop(slot_number)
	else
		item?.on_use(usr)

/ui_element/item_slot/MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
	if (!item)
		return
	if (istype(over_object, /ui_element/item_slot))
		var/ui_element/item_slot/slot = over_object
		if (slot.item)
			return
		slot.insert_item(item)
		usr.inv[slot.slot_number] = item
		remove_item()
		usr.inv[slot_number] = null