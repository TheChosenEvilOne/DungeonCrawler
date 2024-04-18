/obj/door
	name = "door"
	desc = "It opens and closes, if it feels like it."
	icon = 'icons/objects/world_objects.dmi'
	icon_state = "door"
	opacity = TRUE
	density = TRUE
	interactions = list("Open" = list("Open", .proc/open))
	var/open
	// set to number for directional lock, set to item instance for item lock.
	var/locked = null

/obj/door/New(loc, open = FALSE)
	if (open)
		open(silent = TRUE)
	else
		close(silent = TRUE)
	. = ..()

/obj/door/bumped(atom/thing)
	var/mob/M = thing
	if (istype(M) && !open)
		open(M)
	. = ..()

/obj/door/proc/open(mob/M, silent = FALSE)
	if (locked)
		if (isnum(locked) && locked == get_dir(locked, M))
			locked = null
		else
			M << "The door is locked."
			return
	M << "You open \the [src]."
	interactions["Open"][INTR_NAME] = "Close"
	interactions["Open"][INTR_PROC] = .proc/close
	generate_interact()
	open = TRUE
	icon_state = "[initial(icon_state)][open]"
	density = opacity = FALSE

/obj/door/proc/close(mob/M, silent = FALSE)
	if (locate(/mob) in loc)
		M << "There is something in the way of \the [src]."
		return
	if (locked)
		locked = null
	M << "You close \the [src]."
	interactions["Open"][INTR_NAME] = "Open"
	interactions["Open"][INTR_PROC] = .proc/open
	generate_interact()
	open = FALSE
	icon_state = "[initial(icon_state)][open]"
	density = opacity = TRUE
