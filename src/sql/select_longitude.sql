/*
Select the centroid points of parcels and
return longitude as degrees
*/
SELECT *, X(Centroid(Transform(CastAutomagic(geom),4326))) AS long
FROM prop_parcel_polygons LIMIT 3;
