#define HEAD_LAYER FLOAT_LAYER + 0.1
#define BELT_LAYER FLOAT_LAYER + 0.2
#define ARMOR_LAYER FLOAT_LAYER + 0.3
#define	CLOTHING_LAYER FLOAT_LAYER + 0.4
#define LEGS_LAYER FLOAT_LAYER + 0.5

/obj/item/equipable
	var/item_slot
	var/worn_icon
	var/worn_icon_state
	var/cursed = FALSE
	var/stats = list()
	var/ac = 0

/obj/item/equipable/on_use(mob/M)
	var/in_slot = M.equipment[item_slot]
	if(in_slot == src)
		usr << M.take_off(item_slot)
		return

	// usr << M.take_off(slot, src)
	usr << "equiped: [M.equip(src)]"


/obj/item/equipable/proc/on_equip(mob)
	

/obj/item/equipable/proc/on_take_off(mob)


/obj/item/equipable/proc/get_stats()
	. = stats