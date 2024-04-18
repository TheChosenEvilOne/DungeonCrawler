/atom
	plane = WORLD_PLANE
	var/list/managed_overlays

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

/atom/proc/update_overlays()
	overlays.Cut()
	for (var/O in managed_overlays)
		overlays += managed_overlays[O]

/atom/proc/add_managed_overlay(name, image)
	if (!managed_overlays) managed_overlays = list()
	if (managed_overlays[name])
		remove_managed_overlay(name)
	managed_overlays[name] = image
	overlays += image

/atom/proc/remove_managed_overlay(name)
	var/img = managed_overlays[name]
	if (!img)
		return
	managed_overlays.Remove(name)
	if (!overlays.Remove(img))
		update_overlays()