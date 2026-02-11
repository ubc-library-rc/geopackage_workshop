--update_geometry_from_select.sql
/*
This will *actually* do the update. Again, whether or not you need
AsGPB() will depend on whether you have used InitSpatialMetadata()
and reopened the database.
*/
UPDATE sd_39_schools SET geom = geom_gpb 
FROM 
(
SELECT rowid, 
	--AsGPB(Transform(CastAutomagic(gpkgMakePoint(SCHOOL_LONGITUDE, 
	--	  SCHOOL_LATITUDE, 4326)), 3005)) 
	Transform(CastAutomagic(gpkgMakePoint(SCHOOL_LONGITUDE, 
		  SCHOOL_LATITUDE, 4326)), 3005)
	AS geom_gpb FROM sd_39_schools
 ) AS tmp	 
WHERE sd_39_schools.rowid = tmp.rowid
