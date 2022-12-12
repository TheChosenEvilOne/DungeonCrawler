var/list/generated_levels = list()

/proc/generate_zlevel(z)
	if (z >= world.maxz)
		world.maxz++
	var/datum/generator_state/state = new
	state.complexity_budget = 25
	var/style = pick(typesof(/datum/world_style) - /datum/world_style)
	state.style = new style
	generate_feature(world.maxx / 2, world.maxy / 2, z, 0, state)
	for (var/P in state.points_of_interest[POI_ENTRANCE_POS])
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
	var/T = state.take_poi(POI_RANDOM_POS)
	new /obj/item/key(T)
	for (var/P in state.points_of_interest[POI_RANDOM_POS])
		new /mob/goblin(P)
	generated_levels += z
	return state

/proc/generate_feature(x, y, z, dir, datum/generator_state/state)
	if (!IN_BOUNDS(x, y) || state.complexity_budget <= 0)
		return
	var/datum/world_feature/F = pick_weight(state.style.features)
	F = new F()
	state.complexity_budget -= F.complexity
	F.generate(x, y, z, dir, state)
	var/N = 0
	while (prob(100 - N * 25) && length(state.points_of_interest[POI_TUNNEL_POS]))
		if (state.complexity_budget <= 0)
			return
		N++
		var/poi = state.take_poi(POI_TUNNEL_POS)
		var/turf/trf = poi[1]
		if (istype(trf, /turf/floor)) continue
		var/datum/world_tunneller/T = pick_weight(state.style.tunnelers)
		T = new T(rand(MIN_TUNNEL_LENGTH, MAX_TUNNEL_LENGTH))
		poi = T.tunnel(trf.x, trf.y, z, poi[2], state)
		if (!poi) continue
		trf = poi[1]
		generate_feature(trf.x, trf.y, z, poi[2], state)