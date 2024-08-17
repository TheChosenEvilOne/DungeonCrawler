/datum/world_tunneller/hallway

/datum/world_tunneller/hallway/tunnel(x, y, z, dir = pick(NORTH, SOUTH, WEST, EAST), datum/world_generator/gen)
	var/T
	T = locate(x, y, z)
	gen.add_poi(POI_ENTRANCE_POS, list(list(T, dir)))
	while (IN_BOUNDS(x, y))
		T = locate(x, y, z)
		if (istype(T, /turf/floor))
			return
		T = new gen.style.floor(T)
		if (length <= 0)
			break
		length--
		if (dir & 3)
			y -= (dir &  3) * 2 - 3
		else
			x -= (dir >> 2) * 2 - 3
		if (length > 1 && prob(5))
			dir = (dir << 2 | dir >> 2) & 15
			if (dir & 3)
				dir ^= 3 * prob(50)
			else
				dir ^= 12 * prob(50)
	if (IN_BOUNDS(x, y))
		gen.add_poi(POI_ENTRANCE_POS, list(list(T, dir)))
		return list(T, dir)