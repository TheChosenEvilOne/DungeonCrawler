/datum/world_generator/dungeon


/datum/world_generator/dungeon/generate_z(z)
	if (z >= world.maxz)
		world.maxz++
	style = pick(typesof(/datum/world_style) - /datum/world_style)
	style = new style
	generate_feature(world.maxx / 2, world.maxy / 2, z, 0)
	for (var/P in points_of_interest[POI_ENTRANCE_POS])
		var/turf/T = P[1]
		// double doors are an issue
		if (locate(/obj/door) in T) continue
		var/dir = PERPEND_DIR(P[2])
		var/turf/T1 = get_step(T, dir)
		if (istype(T1, /turf/floor))
			continue
		T1 = get_step(T, REVERSE_DIR(dir))
		if (istype(T1, /turf/floor))
			continue
		new /obj/door(T)
	//TODO: PoI consumer datum?
	var/T = take_poi(POI_RANDOM_POS)
	new /obj/item/key(T)
	for (var/P in points_of_interest[POI_RANDOM_POS])
		new /mob/goblin(P)
	generated_levels += z

/datum/world_generator/dungeon/generate_feature(x, y, z, dir)
	if (!IN_BOUNDS(x, y) || complexity_budget <= 0)
		return
	var/datum/world_feature/F = pick_weight(style.features)
	F = new F()
	complexity_budget -= F.complexity
	F.generate(x, y, z, dir, src)
	var/N = 0
	while (prob(100 - N * 25) && length(points_of_interest[POI_TUNNEL_POS]))
		if (complexity_budget <= 0)
			return
		N++
		var/poi = take_poi(POI_TUNNEL_POS)
		var/turf/trf = poi[1]
		if (istype(trf, /turf/floor)) continue
		var/datum/world_tunneller/T = pick_weight(style.tunnelers)
		T = new T(rand(MIN_TUNNEL_LENGTH, MAX_TUNNEL_LENGTH))
		poi = T.tunnel(trf.x, trf.y, z, poi[2], src)
		if (!poi) continue
		trf = poi[1]
		generate_feature(trf.x, trf.y, z, poi[2])