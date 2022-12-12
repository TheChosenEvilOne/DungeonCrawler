/datum/world_feature/room
	complexity = 1

/datum/world_feature/room/generate(x, y, z, dir, datum/generator_state/state)
	var/size = rand(2, 4)
	var/w = size - round(size * rand() / 2)
	var/h = size - round(size * rand() / 2)

	if (x - w <= 1)
		w -= 1 - x - w
	else if (x + w >= world.maxx)
		w -= x + w - world.maxx + 1
	if (y - h <= 1)
		h -= 1 - y - h
	else if (y + h >= world.maxy)
		h -= y + h - world.maxy + 1

	if (dir & 3)
		var/D = ((dir &  3) * 2 - 3)
		y -= h * D + D
	else if (dir & 12)
		var/D = ((dir >> 2) * 2 - 3)
		x -= w * D + D
	if (!state.reserve(rect(x - w, y - h, x + w, y + h)))
		return
	var/list/pois = list(
		list(locate(x + rand(-w, w), y + h + 1, z), NORTH),
		list(locate(x + rand(-w, w), y - h - 1, z), SOUTH),
		list(locate(x + w + 1, y + rand(-h, h), z), EAST),
		list(locate(x - w - 1, y + rand(-h, h), z), WEST))
	if (dir)
		dir = (dir & 10) >> 1 | (dir & 5) << 1
		var/i = (dir &  3) + ((dir >> 2) + (((dir >> 2) + 1) & 2))
		pois.Cut(i, i+1)
	state.add_poi(POI_TUNNEL_POS, pois)
	for (var/x2 = -w, x2 <= w, x2++)
		for (var/y2 = -h, y2 <= h, y2++)
			var/turf/T = locate(x + x2, y + y2, z)
			new state.style.floor(T)
			if (prob(2)) state.add_poi(POI_RANDOM_POS, T)