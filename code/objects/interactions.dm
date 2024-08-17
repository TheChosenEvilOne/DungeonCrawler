/obj
	var/list/interactions
	var/interact_cache

/obj/proc/generate_interact()
	interact_cache = ""
	for (var/i = 1, i <= interactions.len, i++)
		var/interaction = interactions[interactions[i]]
		interact_cache += "<a class='small maptext'\
		style='background-color:#7F7F7F0F'\
		href='?src=\ref[src];action=[interactions[i]]'>\> [interaction[INTR_NAME]]</a><br>"

/obj/Click(location, control, params)
	if (!interactions)
		return ..()
	if (get_dist(usr, loc) > 1)
		return
	usr.client.view_interactable(src, params2list(params))

/obj/Topic(href, href_list)
	if (interactions)
		if (get_dist(usr, loc) <= 1)
			call(src, interactions[href_list["action"]][INTR_PROC])(usr)