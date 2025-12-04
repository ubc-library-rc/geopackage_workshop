/*
Select all properties in 1000 block W 70th and show the
latitude, longitude and area, with an example
of what happens if you use the wrong projection.
*/
SELECT
*,
x(Centroid(Transform(CastAutomagic(geom),4326))) AS long,
y(Centroid(Transform(CastAutomagic(geom),4326))) AS lat,
Area(CastAutoMagic(geom)) AS area,
Area(Transform(CastAutomagic(geom),4326)) AS badarea
FROM prop_parcel_polygons
WHERE civic_number LIKE '10__' and streetname LIKE'W 70TH%';
