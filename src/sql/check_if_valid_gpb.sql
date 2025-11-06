--check_if_valid_gpb.sql
/*
Check for valid geometry with IsValidGPB (GeoPackage Blob)
*/
SELECT IsValidGPB(transform(castAutoMagic(gpkgMakePoint(SCHOOL_LONGITUDE, SCHOOL_LATITUDE, 4326)), 3005)) AS geom FROM sd_39_schools AS tmp
