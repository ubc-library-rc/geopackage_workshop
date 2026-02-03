/*
Select all properties within 200m a *particular* school
and show the distance in metres
*/
SELECT DISTINCT fid, prop_parcel_polygons.geom, civic_number, streetname, site_id,
DistanceWithin(centroid(CastAutomagic(prop_parcel_polygons.geom)), castAutomagic(schools.geom), 200) AS within_200,
round(Distance(CastAutomagic(prop_parcel_polygons.geom), castAutomagic(schools.geom))) AS distance_m,
SRID(prop_parcel_polygons.geom) AS SRID_geom,
SRID(schools.geom) AS SRID_school,
X(centroid(transform(castAutoMagic(prop_parcel_polygons.geom), 4326))) as long_prop,
Y(centroid(transform(castAutoMagic(prop_parcel_polygons.geom), 4326))) as lat_prop
FROM prop_parcel_polygons
FULL OUTER JOIN (SELECT * FROM sd_39_schools AS schools WHERE schools.SCHOOL_NAME='Lord Byng Secondary')AS schools
WHERE
PtDistWithin(centroid(CastAutomagic(prop_parcel_polygons.geom)),  castAutomagic(schools.geom), 200) = 1
ORDER BY distance_m DESC;
