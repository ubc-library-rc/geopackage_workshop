--select_within_distance_manually_entered_point.sql
/*
Select parcels within 250m distance of *manually entered* point,
Gladstone Elementary School
and show the lat, long and area of the parcel

*/
SELECT
*,
X(Centroid(Transform(CastAutomagic(geom),4326))) as long,
Y(Centroid(Transform(CastAutomagic(geom),4326))) as lat,
Area(CastAutoMagic(geom)) AS area
FROM prop_parcel_polygons
WHERE
--Coordinates are entered into the MakePoint function
distanceWithin(castAutoMagic(geom),
	Transform(castAutoMagic(MakePoint(-123.06159, 49.2485455, 4326)),3005), 250)
