/obj/abstract/world_spawn
	name = "world spawn"
	icon_state = "spawn"

/obj/abstract/New()
	globals.spawn_points += get_step(src, 0)
	kill()