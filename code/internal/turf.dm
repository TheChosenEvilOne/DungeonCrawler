/turf
	plane = TURF_PLANE
	var/icon_variation = 0

/turf/New()
	if (icon_variation)
		icon_state = "[icon_state][xorshift(x ^ y) % icon_variation]"
	. = ..()

/turf/bumped(atom/by)
	. = density
	for (var/atom/A as anything in contents)
		. = by.bump(A) ? TRUE : .

/turf/proc/enter(atom/movable/AM)
	return AM.loc = src