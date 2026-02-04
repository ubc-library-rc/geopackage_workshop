/*
Intermediate step showing how to add points and convert them to a different projection
*/
SELECT Transform(castAutomagic(gpkgMakePoint(SCHOOL_LONGITUDE, SCHOOL_LATITUDE, 4326)), 3005) 
	FROM sd_39_schools;
