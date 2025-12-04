/*
Select parcels within 250m distance of *manually entered* point
and show the lat, long and area of the parcel
*/
SELECT
*,
x(Centroid(Transform(CastAutomagic(geom),4326))) as long,
y(Centroid(Transform(CastAutomagic(geom),4326))) as lat,
Area(CastAutoMagic(geom)) as area
FROM prop_parcel_polygons
WHERE
--Coordinates are entered into the MakePoint function
distanceWithin(castAutoMagic(geom), transform(castAutoMagic(MakePoint(-123.131457045205, 49.2082220977993, 4326)),3005), 250)
