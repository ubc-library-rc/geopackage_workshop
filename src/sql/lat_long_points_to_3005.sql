/*
Intermediate step showing how to add points and convert them to a different projection
*/
SELECT transform(castAutoMagic(gpkgMakePoint(SCHOOL_LONGITUDE, SCHOOL_LATITUDE, 4326)), 3005) from sd_39_schools;