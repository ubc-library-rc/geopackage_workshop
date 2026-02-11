--lat_long_points_to_3005.sql
/*
Intermediate step showing how to add points and convert them to a different projection
*/
--Note; whether or not you need AsGPB() depends on whether or not you've opened
--or closed the database!
--SELECT AsGPB(Transform(castAutomagic(gpkgMakePoint(SCHOOL_LONGITUDE, 
--			 SCHOOL_LATITUDE, 4326)), 3005)) 
--	FROM sd_39_schools;
SELECT Transform(castAutomagic(gpkgMakePoint(SCHOOL_LONGITUDE, 
			 SCHOOL_LATITUDE, 4326)), 3005)
	FROM sd_39_schools;
