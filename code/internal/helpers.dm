/proc/pick_weight(list/list_to_pick)
	var/total = 0
	var/item
	for(item in list_to_pick)
		if(!list_to_pick[item])
			list_to_pick[item] = 0
		total += list_to_pick[item]
	total = rand(1, total)
	for(item in list_to_pick)
		total -= list_to_pick[item]
		if(total <= 0 && list_to_pick[item])
			return item
	return null

/proc/roll_die(str)
	var/dies = splittext(str, "+")
	var/total = 0
	for (var/die in dies)
		var/count = splittext(die, "d")
		var/sides = text2num(count[2])
		count = text2num(count[1])
		for (var/i in 1 to count)
			total += rand(1, sides)
	return total

/proc/rarity_color(rarity)
	switch (rarity)
		if (RARITY_COMMON) return "#333"
		if (RARITY_UNCOMMON) return "#7CFC00"
		if (RARITY_RARE) return "#00FFFF"
		if (RARITY_EPIC) return "#800080"
		if (RARITY_LEGENDARY) return "#FFA500"