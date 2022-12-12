/obj/corpse
	name = "corpse"
	interactions = list("Eat" = list("Eat", .proc/eat))

/obj/corpse/New(loc, mob/M)
	appearance = M.appearance
	name = "corpse of [M]"
	color = list(0.30,0.30,0.30, 0.60,0.60,0.60, 0.10,0.10,0.10, 0,0,0)
	M.loc = src
	transform = turn(transform, 90)
	return ..()

/obj/corpse/proc/eat(mob/M)
	M << "You consume \the [src]."
	kill()