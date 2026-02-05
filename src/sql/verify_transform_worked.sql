--verify_transform_worked.sql
--Verify that your transformation worked
SELECT X(Transform(Centroid(castAutomagic(geom)), 4236)) FROM prop_parcel_polygons LIMIT 10
