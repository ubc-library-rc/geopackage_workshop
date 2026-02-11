--reproject_geometry.sql
-- Reproject geometry to EPSG:4326 (WGS 84)
SELECT Transform(castAutomagic(geom), 4326) FROM prop_parcel_polygons LIMIT 4;
