/obj/item/equipable
	var/item_slot
	var/cursed = FALSE
	var/stats = list()
	var/ac = 0

/obj/item/equipable/on_use(mob/M)
	var/slot = M.equipment[item_slot]
	if(slot == src)
		usr << M.take_off(slot, src)
		return

	// usr << M.take_off(slot, src)
	usr << "equiped: [M.equip(src)]"

/obj/item/equipable/proc/on_equip(mob)
	

/obj/item/equipable/proc/on_take_off(mob)


/obj/item/equipable/proc/get_stats()
	. = stats