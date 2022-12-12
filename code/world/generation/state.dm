/datum/generator_state
	var/complexity_budget = 0
	var/list/points_of_interest = list()
	var/list/datum/rect/reserve = list()
	var/datum/world_style/style

/datum/generator_state/proc/add_poi(type, poi)
	if (!points_of_interest[type])
		points_of_interest[type] = list()
	points_of_interest[type].Add(poi)

/datum/generator_state/proc/get_poi(type)
	if (!points_of_interest[type] || !length(points_of_interest[type]))
		return null
	return pick(points_of_interest[type])

/datum/generator_state/proc/take_poi(type)
	var/poi = get_poi(type)
	if (poi) points_of_interest[type] -= poi
	return poi

/datum/generator_state/proc/reserve(datum/rect/rect)
	for (var/datum/rect/R in reserve)
		if (rect[R])
			return FALSE
	reserve += rect
	return TRUE