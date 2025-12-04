/*
Select the centroid points of parcels and
return only the longitudes as degrees
*/
SELECT x(centroid(transform(castautomagic(geom),4326))) AS long
FROM prop_parcel_polygons LIMIT 3;