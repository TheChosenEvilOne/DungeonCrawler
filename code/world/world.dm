/proc/generate_zlevel(z)
	var/datum/world_generator/generator = pick(typesof(/datum/world_generator) - /datum/world_generator)
	generator = new()
	generator.complexity_budget = 25
	generator.generate_z(z)
	return generator