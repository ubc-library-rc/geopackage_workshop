--properties_close_to_particular_school.sql
/*
Select all properties within 200m a *particular* school
and show the distance in metres
*/
SELECT DISTINCT fid, prop_parcel_polygons.geom, civic_number,
	streetname, site_id,
	DistanceWithin(Centroid(CastAutomagic(prop_parcel_polygons.geom)), 
		CastAutomagic(schools.geom), 200) AS within_200,
	round(Distance(CastAutomagic(prop_parcel_polygons.geom), 
			CastAutomagic(schools.geom))) AS distance_m,
	SRID(prop_parcel_polygons.geom) AS SRID_geom,
	SRID(schools.geom) AS SRID_school,
	X(Centroid(Transform(CastAutomagic(prop_parcel_polygons.geom), 4326))) AS long_prop,
	Y(Centroid(Transform(CastAutomagic(prop_parcel_polygons.geom), 4326))) AS lat_prop
FROM prop_parcel_polygons
JOIN (SELECT * FROM sd_39_schools AS schools 
	WHERE schools.SCHOOL_NAME='Lord Byng Secondary') AS schools
WHERE
PtDistWithin(Centroid(CastAutomagic(prop_parcel_polygons.geom)),  
	CastAutomagic(schools.geom), 200) = 1
ORDER BY distance_m DESC;
