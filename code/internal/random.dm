/proc/xorshift(seed)
	// only 24-bits of BYOND numbers can be manipulated, yet this is using xorshift 32.
	seed ^= seed << 13
	seed ^= seed >> 7
	seed ^= seed << 5
	return seed