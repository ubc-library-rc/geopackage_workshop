--import_csv_data_and_make_geometry.sql
/*You should have already performed these steps

SELECT enableGpkgMode();
SELECT getGpkgMode();
-- And it should be in GeoPackage mode

SELECT InitSpatialMetadata();
--so you can do transformations/

-- After these are done, you can import data using
-- File/Import/Table From CSV File
-- in this case, sd_39_schools.csv

-- Then, you need to add a geometry column
*/
--Note that the projection is EPSG:3005
SELECT gpkgAddGeometryColumn('sd_39_schools', 'geom', 'POINT', 0, 0, 3005);
