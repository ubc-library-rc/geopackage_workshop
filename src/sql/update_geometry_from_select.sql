/*
This will *actually* do the update
*/
UPDATE sd_39_schools SET geom = tmpquery.geom_gpb 
FROM 
(
SELECT transform(castAutoMagic(gpkgMakePoint(SCHOOL_LONGITUDE, SCHOOL_LATITUDE, 4326)), 3005) AS geom_gpb FROM sd_39_schools
) AS tmpquery