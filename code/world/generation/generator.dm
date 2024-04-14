var/list/generated_levels = list()

/datum/world_generator
	var/complexity_budget = 0
	var/datum/world_style/style
	var/list/datum/rect/reserve = list()
	var/list/points_of_interest = list()

/datum/world_generator/proc/generate_z(z)

/datum/world_generator/proc/generate_feature(x, y, z)

/datum/world_generator/proc/add_poi(type, poi)
	if (!points_of_interest[type])
		points_of_interest[type] = list()
	points_of_interest[type].Add(poi)

/datum/world_generator/proc/get_poi(type)
	if (!points_of_interest[type] || !length(points_of_interest[type]))
		return null
	return pick(points_of_interest[type])

/datum/world_generator/proc/take_poi(type)
	var/poi = get_poi(type)
	if (poi) points_of_interest[type] -= poi
	return poi

/datum/world_generator/proc/reserve(datum/rect/rect)
	for (var/datum/rect/R in reserve)
		if (rect[R])
			return FALSE
	reserve += rect
	return TRUE