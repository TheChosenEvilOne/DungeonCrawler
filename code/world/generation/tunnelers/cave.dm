/datum/world_tunneller/cave

/datum/world_tunneller/cave/tunnel(x, y, z, dir = pick(NORTH, SOUTH, WEST, EAST), datum/world_generator/gen)
	var/vx = 0
	var/vy = 0
	if (dir & 3)
		vy = -((dir &  3) * 2 - 3) * 0.5
	else
		vx = -((dir >> 2) * 2 - 3) * 0.5
	var/dist = 0
	while (dist++ < length)
		if (x <= 3 || x >= (world.maxx - 3))
			vx = -vx
			x += vx * 10
		if (y <= 3 || y >= (world.maxx - 3))
			vy = -vy
			y += vy * 10
		for (var/dx in -1 to 1)
			for (var/dy in -1 to 1)
				new gen.style.floor(locate(x+dx, y+dy, z))
		x += vx
		y += vy
		var/theta = rand() * 10 - 5
		vx = vx * cos(theta) - vy * sin(theta)
		vy = vx * sin(theta) + vy * cos(theta)
	return list(locate(x, y, z), 0)