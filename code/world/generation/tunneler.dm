/datum/world_tunneller
	var/length

/datum/world_tunneller/New(length)
	src.length = length

/datum/world_tunneller/proc/tunnel(x, y, z, dir = pick(NORTH, SOUTH, WEST, EAST), datum/world_generator/gen)