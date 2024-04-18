/obj/stairs
	name = "stairs"
	icon = 'icons/objects/world_objects.dmi'
	icon_state = "dstairs"
	interactions = list("Down" = list("Down", .proc/down))

/obj/stairs/proc/down(mob/M)
	if (!((z + 1) in generated_levels))
		generate_zlevel(z + 1)
	var/turf/T = locate(world.maxx / 2, world.maxy / 2, z + 1)
	if (istype(T, /turf/floor))
		new /obj/stairs/up(T)
		M.loc = T

/obj/stairs/up
	icon_state = "ustairs"
	interactions = list("Up" = list("Up", .proc/up), "Down" = list("Down", .proc/down))
	var/locked = TRUE

/obj/stairs/up/down(mob/M)
	if (locked)
		var/atom/key = M.find_type(/obj/item/key)
		if (!key)
			M << "You need a key to go deeper."
			return
		key = M.drop(key, null)
		key.kill()
		locked = FALSE
	if (!((z + 1) in generated_levels))
		generate_zlevel(z + 1)
	var/turf/T = locate(x, y, z + 1)
	if (istype(T, /turf/floor))
		new /obj/stairs/up(T)
		M.loc = T

/obj/stairs/proc/up(mob/M)
	M.loc = locate(x, y, z - 1)

/obj/stairs/dungeon_entrance
	name = "dungeon entrance"

/obj/stairs/dungeon_exit
	icon_state = "ustairs"
	name = "dungeon exit"
	interactions = list("Up" = list("Up", .proc/up))

/obj/stairs/dungeon_exit/up(mob/M)
	M << "You should try beating the game first."