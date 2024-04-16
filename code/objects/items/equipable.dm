/obj/item/equipable
	var/item_slot
	var/worn_icon
	var/cursed = FALSE
	var/stats = list()
	var/ac = 0

/obj/item/equipable/on_use(mob/M)
	var/in_slot = M.equipment[item_slot]
	if(in_slot == src)
		M.take_off(item_slot)
		return

	M.equip(src)

/obj/item/equipable/drop(mob/M, location = M.loc)
	if(!M.equipment[item_slot] == src)
		if(!M.take_off(item_slot))
			return
	. = ..()

/obj/item/equipable/proc/on_equip(mob)
	

/obj/item/equipable/proc/on_take_off(mob)


/obj/item/equipable/proc/get_stats()
	. = stats


/obj/item/equipable/proc/create_overlay()
	return image(worn_icon, icon_state = icon_state, layer = layer)
