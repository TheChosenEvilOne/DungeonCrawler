/obj/item/equipable
	var/item_slot
	var/worn_icon
	var/worn_layer
	var/mutable_appearance/worn
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

/obj/item/equipable/New()
	. = ..()
	worn = mutable_appearance(worn_icon, icon_state, worn_layer)

/obj/item/equipable/proc/on_equip(mob/user)
	user.add_managed_overlay(item_slot, worn)
	user << "equipped: [name]"

/obj/item/equipable/proc/on_take_off(mob/user)
	user.remove_managed_overlay(item_slot)
	user << "taken off: [name]"

/obj/item/equipable/proc/get_stats()
	. = stats
