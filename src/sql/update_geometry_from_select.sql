/*
This will *actually* do the update
*/
UPDATE sd_39_schools SET geom = geom_gpb 
FROM 
(
SELECT rowid, Transform(CastAutomagic(gpkgMakePoint(SCHOOL_LONGITUDE, SCHOOL_LATITUDE, 4326)), 3005) AS geom_gpb FROM sd_39_schools
 ) AS tmp	 
WHERE sd_39_schools.rowid = tmp.rowid
