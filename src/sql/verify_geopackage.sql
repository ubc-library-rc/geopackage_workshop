-- Verify that everything is installed
SELECT spatialite_version() AS spatialite_version, HasGeoPackage() AS has_gpkg;
