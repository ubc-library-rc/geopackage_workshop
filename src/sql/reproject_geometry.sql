-- Reproject geometry to EPSG:4326 (WGS 84)
SELECT transform(castAutomagic(geom), 4236) FROM prop_parcel_polygons;
