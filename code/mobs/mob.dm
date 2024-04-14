/mob
	desc = "Seems kind of stinky."
	density = TRUE
	sight = SEE_PIXELS
	icon = 'icons/mobs/creatures.dmi'
	var/factions = list()
	// Stats
	var/hp
	var/max_hp = 100
	var/mp
	var/max_mp = 100
	var/ac = 0

	var/list/stats = list("STR" = 10, "INT" = 10, "DEX" = 10)
	var/stats_final = list()
	var/skills = list()
	// Inventory
	var/list/obj/item/inv[64]
	var/list/equipment = list()

/mob/New()
	. = ..()
	factions += "[type]"
	hp = max_hp
	mp = max_mp

/mob/Login()
	. = ..()
	for (var/i in 1 to inv.len)
		if (inv[i])
			var/ui_element/item_slot/S = client.item_slots[i]
			S.insert_item(inv[i])

/mob/Stat()
	bstat("Health", "Health: [hp] / [max_hp]")
	bstat("Mana", "Mana: [mp] / [max_mp]")
	for (var/s in stats_final)
		bstat(s, "[s]: [stats_final[s]]")

/mob/proc/update_stats()
	var/final_stats = stats.Copy()

	for(var/item in equipment)
		var/equipment_stats = equipment[item].get_stats()
		for(var/stat in equipment_stats)
			final_stats[stat] += equipment_stats[stat]

	stats_final = final_stats		

/mob/proc/find_type(type)
	for (var/i in 1 to inv.len)
		if (istype(inv[i], type))
			return i

//inventory
/mob/proc/drop(slot, location = loc)
	. = null
	if (!inv[slot])
		return
	var/obj/item/I = inv[slot]
	if (!I.drop(src, location))
		return
	if (client)
		var/ui_element/item_slot/S = client.item_slots[slot]
		S.remove_item()
	inv[slot] = null
	return I

/mob/proc/pick_up(obj/item/I, slot = 0)
	. = FALSE
	if (slot)
		if (inv[slot]) return
		inv[slot] = I
		I.loc = src
		if (client)
			var/ui_element/item_slot/S = client.item_slots[slot]
			S.insert_item(I)
		return TRUE
	for (var/i in 1 to inv.len)
		if (inv[i]) continue
		inv[i] = I
		I.loc = src
		if (client)
			var/ui_element/item_slot/S = client.item_slots[i]
			S.insert_item(I)
		return TRUE
	src << "You do not have space for that."

/mob/proc/equip(obj/item/equipable/I)
	if(!can_equip(I))//already thinking about adding a text that tells you why you couldnt equip
		return
	//okay basic overlays working
	src.overlays += create_overlay(I)
	equipment[I.item_slot] = I
	I.on_equip(src)
	update_stats()
	print_ac_list(equipment)
	. = I.name

/mob/proc/take_off(item_slot)
	var/in_slot = equipment[item_slot]
	if(!can_take_off(in_slot))
		return
	. = "[in_slot?:name] taken off"
	src.overlays -= create_overlay(in_slot)
	equipment.Remove(item_slot)
	print_ac_list(equipment)


/mob/proc/can_equip(obj/item/equipable/I)
	if(isnull(equipment[I.item_slot]))
		return TRUE
	else
		src << "something went wrong"
		return FALSE

/mob/proc/can_take_off(obj/item/equipable/I)
	if(!I.cursed)
		return TRUE
	else
		return FALSE

/mob/proc/update_overlays()
	

/mob/proc/on_death()
	oview(5) << "[src] dies."
	new /obj/corpse(loc, src)

/mob/proc/take_damage(damage)

	var/final_damage
	hp -= final_damage
	if (hp <= 0)
		on_death()

/mob/proc/on_attacked(mob/attacker, damage)
	damage = round(damage)
	take_damage(damage)
	return damage

/mob/proc/attack(mob/other)
	if (!equipment[ITEM_SLOT_HANDS]) // unarmed
		if (!act(2))
			return
		var/skill_level = skills[SKILL_UNARMED]
		var/damage = (roll_die("1d3") + skill_level) * (1 + ((stats["STR"] - 10) * 0.025))
		damage = other.on_attacked(src, damage)
		src << "You attack \the [other], dealing [damage] damage."
		return

/mob/bump(thing)
	var/mob/M = thing
	if (istype(M))
		for (var/F in factions)
			if (F in M.factions)
				goto in_faction
		attack(M)
	return ..()
	in_faction:
	var/L = M.loc
	M.loc = loc
	loc = L
	return FALSE