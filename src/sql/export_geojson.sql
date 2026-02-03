/*
Export a GeoJSON and a shapefile by creating a table, exporting, then deleting the table.
Remember, SPATIALITE_SECURITY must be 'relaxed'

The same procedure applies for shapefiles, kmls and other exports.
Read the functions carefully
*/
SELECT DisableGpkgMode();
SELECT DisableGpkgAmphibiousMode();
--the next two commands aren't necessary if the table doesn't exist yet
DROP TABLE IF EXISTS secondary;
DELETE FROM  geometry_columns WHERE f_table_name='secondary';
CREATE TABLE secondary AS SELECT fid,civic_number, streetname, site_id, castAutoMagic(geom) as g2 from prop_parcel_polygons WHERE streetname LIKE 'DUNBAR%';
--Note that the JSON lat/long column was excluded because JSON inside a JSON is asking for trouble
SELECT RecoverGeometryColumn('secondary', 'g2', 3005, 'POLYGON');
SELECT ExportGeoJSON2('secondary', 'g2', '/tmp/dunbar.geojson', 8, 1, 0, 1, 'LOWER' );
--ExportShp adds extensions automatically
SELECT ExportSHP('secondary', 'g2', '/tmp/dunbar', 'UTF-8');

DROP TABLE secondary;
DELETE FROM  geometry_columns WHERE f_table_name='secondary';
