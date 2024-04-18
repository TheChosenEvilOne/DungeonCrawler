/mob/undead
	name = "undead"
	desc = "not alive"
	icon_state = "skeleton"
/mob/undead/skeleton
	name = "skeleton"
	desc = "Bad to the bone."
	max_hp = 10
	icon_state = "skeleton"

/mob/undead/zombie
	name = "flesh zombie"
	desc = "Brains."
	max_hp = 15
	icon_state = "zombie"

/mob/undead/skeleton/skeleton_warrior
	name = "skeleton warrior"
	desc = "Worse to the bone."
	max_hp = 20

/mob/undead/skeleton/skeleton_warrior/New()
	. = ..()
	equip_new(/obj/item/equipable/head/full)
	equip_new(/obj/item/equipable/chest/steel)
	equip_new(/obj/item/equipable/belt/steel)
	equip_new(/obj/item/equipable/legs/steel)
	equip_new(/obj/item/equipable/clothing/shirt/shirt_b)

/mob/undead/lich
	name = "lich"
	desc = "The worst to the bone and the most evil."
	max_hp = 100
	icon_state = "lich"

/mob/undead/lich/New()
	. = ..()
	equip_new(/obj/item/equipable/head/crown)
	equip_new(/obj/item/equipable/chest/evil)
	equip_new(/obj/item/equipable/belt/emerald)
	equip_new(/obj/item/equipable/legs/evil)
	equip_new(/obj/item/equipable/clothing/magic/evilrobe)
