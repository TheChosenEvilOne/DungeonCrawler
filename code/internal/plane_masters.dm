/plane
	parent_type = /atom/movable
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR

/plane/lighting_plane
	plane = LIGHTING_PLANE
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = 0

/plane/blackness_plane
	color = "#000"
	plane = BLACKNESS_PLANE

/plane/blackness_plane/New()
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=4, color="#fff")
	filters += filter(type="blur", size=2)

/plane/world_plane
	plane = WORLD_PLANE

/plane/turf_plane
	plane = TURF_PLANE

/plane/ui_plane
	plane = UI_PLANE

/plane/group
	screen_loc = "1,1"
	var/list/planes

/plane/group/New()
	. = ..()
	for (var/P in planes)
		overlays += new P

/plane/group/lighting
	planes = list(/plane/lighting_plane, /plane/blackness_plane)

/plane/group/world
	planes = list(/plane/world_plane, /plane/turf_plane)

/plane/group/interface
	planes = list(/plane/ui_plane)