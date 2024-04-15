/obj/item/equippable
	var/item_slot
	var/worn_icon
	var/worn_icon_state
	var/cursed = FALSE
	var/stats = list()
	var/ac = 0

/obj/item/equippable/on_use(mob/M)
	var/in_slot = M.equipment[item_slot]
	if(in_slot == src)
		usr << M.take_off(item_slot)
		return

	usr << "equipped: [M.equip(src)]"


/obj/item/equippable/proc/on_equip(mob)
	

/obj/item/equippable/proc/on_take_off(mob)


/obj/item/equippable/proc/get_stats()
	. = stats