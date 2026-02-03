/*
Select all properties within 200m of all schools
*/
SELECT DISTINCT *, 
PtDistWithin(centroid(CastAutomagic(prop_parcel_polygons.geom)), castAutomagic(schools.geom), 200) AS within_200
FROM prop_parcel_polygons
FULL OUTER JOIN sd_39_schools AS schools
WHERE
PtDistWithin(CEntroid(CastAutomagic(prop_parcel_polygons.geom)), castAutomagic(schools.geom), 200) = 1

