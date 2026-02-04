/*
Select all properties within 200m of all schools
*/
SELECT DISTINCT *, 
PtDistWithin(Centroid(CastAutomagic(prop_parcel_polygons.geom)), 
	castAutomagic(schools.geom), 200) AS within_200
FROM prop_parcel_polygons
JOIN sd_39_schools AS schools
WHERE
PtDistWithin(Centroid(CastAutomagic(prop_parcel_polygons.geom)), 
	castAutomagic(schools.geom), 200) = 1

