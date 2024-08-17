/mob
	var/next_action = 0

/mob/proc/can_act()
	. = FALSE
	if (next_action > world.time)
		return
	if (hp <= 0) // yer ded.
		return
	. = TRUE

/mob/proc/act(delay)
	if (!can_act())
		return FALSE
	next_action = world.time + delay
	return TRUE