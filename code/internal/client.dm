/client
	fps = 40
	var/atom/examining
	var/text_height
	var/interacting = FALSE
	var/image/interaction_image
	var/list/item_slots = list()
	var/list/plane_groups = list()
	var/list/stat_cache = list()

/client/New()
	interaction_image = new /image/interaction
	interaction_image.maptext_width = 128
	interaction_image.maptext_height = 128
	// Inventory START
	for (var/y in 8 to 1 step -1)
		for (var/x in 1 to 8)
			var/ui_element/item_slot/A = new
			A.screen_loc = "inv:[x],[y]"
			screen += A
			item_slots.Add(A)
			A.slot_number = item_slots.len
	// Inventory END
	for (var/i in 1 to 4)
		var/atom/movable/AM = new()
		AM.icon = 'icons/ui18.dmi'
		AM.icon_state = "ability"
		AM.screen_loc = "[i * 1.5]:-1,1.5:-1"
		AM.plane = UI_PLANE
		AM.overlays += image(icon = 'icons/ui18.dmi', icon_state = "ability[i]")
		screen += AM
	var/spanel = @{"
	<style>
	.tab {
		overflow: hidden;
		border: 1px solid #ccc;
	}
	.tab button {
		padding: 2px, 4px;
		border: none;
		outline: none;
		cursor: pointer;
		transition: 0.3s;
	}
	.tab button.active {
		background-color: #AEA;
		font-weight: bold;
	}
	</style>
	<script>
		var elements = {}
		var selected_category
		function update(key, value, category) {
			if (!value) value = ""
			if (!elements[category]) {
				elements[category] = {}
				var cat = document.createElement("div")
				var tab = document.createElement("button")
				tab.innerHTML = category
				tab.id = "tab_"+category
				tab.onclick=function(){change_cat(category)}
				cat.id = category
				if (selected_category) {
					cat.style.display = "none"
				} else {
					selected_category = category
					tab.className = "active"
				}
				document.getElementById("tabs").appendChild(tab)
				document.getElementById("contents").appendChild(cat)
			}
			if (!elements[category][key]) {
				elements[category][key] = document.createElement("div")
				document.getElementById(category).appendChild(elements[category][key])
			}
			elements[category][key].innerHTML = value
		}

		function change_cat(category) {
			if (category == selected_category)
				return
			document.getElementById("tab_"+selected_category).className = ""
			document.getElementById("tab_"+category).className = "active"
			document.getElementById(selected_category).style.display = "none"
			document.getElementById(category).style.display = "block"
			selected_category = category
		}
		var url = "byond://winset?command=statready";
		window.location = url;
	</script>
	<body>
	<div class='tab' id='tabs'>
	</div>
	<div id='contents'></div>
	</body>
	"}
	src << browse(spanel, "stat")
	for (var/plane/plane as anything in typesof(/plane/group) - /plane/group)
		plane_groups[plane] = new plane
		screen += plane_groups[plane]
	if (usr)
		images += new /image/light(icon_state = "light19", loc = usr)
		return ..()
	var/mob/M = new /mob/player(pick(globals.spawn_points))
	M.ckey = ckey
	M.factions |= "player_[key]"
	M.name = key
	images += new /image/light(icon_state = "light19", loc = M)
	mob = M
	return M

/client/Stat()
	if (!usr)
		return
	. = ..()
	bstat("catslime", "<img src='https://hellomouse.net/~tceo/rooms/images/catslime.gif'>", "Catslime")

/proc/bstat(key, value, category = "Stats", client/client = usr.client)
	if (!client) CRASH("bstat called without a client")
	if (client.stat_cache["[key]"] == value)
		return
	client.stat_cache[key] = value
	var/data = list(key, value, category)
	client << output(list2params(data), "stat.stat:update")

/client/Click(object,location,control,params)
	// HACK: maptext generates Click and MouseDown events, this is to catch the Click event
	if (interacting)
		hide_interactable()
		return
	var/list/p = params2list(params)
	if (p["right"])
		examining = object
		var/description = examining.examine().Join("<br>")
		bstat("examine", "<div style='border-style:inset;text-align:center;background-color:#EEE;'><strong style='display:block;font-size=24'>[examining.name]</strong><span>[description]</span></div>")
		spawn(100)
			if (examining == object)
				bstat("examine", null, client = src)
		return
	. = ..()

/client/proc/view_interactable(obj/O, params)
	interacting = TRUE
	if (!O.interact_cache)
		O.generate_interact()
	if (!text_height)
		text_height = splittext(MeasureText("text", "maptext", width=10), "x")
		text_height = text2num(text_height[2])
	interaction_image.pixel_x = text2num(params["icon-x"]) + 2
	interaction_image.pixel_y = text2num(params["icon-y"]) - (text_height / 2 * O.interactions.len / 2)
	interaction_image.maptext = O.interact_cache
	interaction_image.loc = get_step(O, 0)
	images += interaction_image

/client/proc/hide_interactable()
	interacting = FALSE
	images -= interaction_image

/client/verb/resized(size as text)
	set hidden = TRUE, instant = TRUE
	var/w = splittext(size, " ")
	var/h = text2num(w[2])
	if (!h) return // minimized.
	w = text2num(w[1])
	var/y = text2num(splittext(winget(usr, "map", "size"), "x")[2])
	winset(usr, "child1", "splitter=[y / w * 100]")
	var/x = text2num(splittext(winget(usr, "inv", "size"), "x")[1])
	winset(usr, "child2", "splitter=[100 - (x / h * 100)]")

/client/verb/say(what as text)
	if (!what)
		return
	world << "[src]: [what]"

/client/verb/statready()
	stat_cache = list()