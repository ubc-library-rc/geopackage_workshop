--verify_transform_worked.sql
--Verify that your transformation worked
SELECT X(Transform(Centroid(castAutomagic(geom)), 4326)) FROM prop_parcel_polygons LIMIT 10
