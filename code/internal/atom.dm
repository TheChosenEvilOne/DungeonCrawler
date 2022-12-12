/atom
	plane = WORLD_PLANE

/atom/New()
	appearance_flags |= LONG_GLIDE
	. = ..()

/atom/proc/kill()
	tag = null

/atom/proc/bump(atom/thing)
	return thing.bumped(src)

/atom/proc/bumped(atom/by)
	return density

/atom/proc/examine()
	. = list(desc)