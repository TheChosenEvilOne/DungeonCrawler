// so you can create rectangles by just doing rect(x1, y1, x2, y2)
/proc/rect(x1, y1, x2, y2)
	return new /datum/rect(x1, y1, x2, y2)

/datum/rect
	var/x1, y1, x2, y2

/datum/rect/New(x1,y1,x2,y2)
	if (x1 > x2)
		src.x2 = x1
		src.x1 = x2
	else
		src.x1 = x1
		src.x2 = x2
	if (y1 > y2)
		src.y2 = y1
		src.y1 = y2
	else
		src.y1 = y1
		src.y2 = y2

/datum/rect/proc/operator[](datum/rect/B)
	return x1 < B.x2 && x2 > B.x1 && y1 < B.y2 && y2 > B.y1