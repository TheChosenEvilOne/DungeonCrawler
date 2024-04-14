/mob
	var/next_move = 0
	var/movement_delay = 1

/mob/proc/get_movement_delay(loc, dir)
	var/diag = 1 + (0.41421 * (IS_ORDINAL(dir) != 0))
	return movement_delay * diag

/client/Move(loc, dir)
	hide_interactable()
	mob.Move(loc, dir)

/mob/Move(loc, dir = 0, force = FALSE)
	if (force)
		if (loc)
			return src.loc = loc
		else
			return loc = get_step(src, dir)
	if (dir)
		if (!can_act())
			return
		src.dir = IS_ORDINAL(dir) || dir // EAST, WEST, or dir.
		var/turf/T = get_step(src, dir)
		if (!T || bump(T)) T = null
		var/delay = get_movement_delay(T, dir)
		if (T && act(delay))
			glide_size = (16 / delay * world.tick_lag)
			return T.enter(src)
	else
		if (istype(loc, /turf))
			var/turf/T = loc
			if (T && bump(T)) T = null
			return T?.enter(src)
		else if (!isnull(loc))
			return src.loc = loc

// Modified code from /vg/station13 - https://github.com/vgstation-coders/vgstation13
/client
	var/tmp
		mloop = 0
		move_dir = 0
		keypresses = 0

/client/New()
	. = ..()
	move_loop()

/client/verb/MoveKey(Dir as num, State as num)
	set hidden = TRUE, instant = TRUE

	var/opposite = REVERSE_DIR(Dir)
	if (State)
		move_dir |= Dir
		keypresses |= Dir
		if (opposite & keypresses)
			move_dir &= ~opposite
	else
		move_dir &= ~Dir
		keypresses &= ~Dir
		if (opposite & keypresses)
			move_dir |= opposite
		else
			move_dir |= keypresses

/client/North()
/client/South()
/client/East()
/client/West()

// This should stay like this for responsiveness reasons.
/client/proc/move_loop()
	set waitfor = FALSE

	Move(mob.loc, move_dir)
	while (TRUE)
		sleep (world.tick_lag)
		if (move_dir)
			Move(mob.loc, move_dir)