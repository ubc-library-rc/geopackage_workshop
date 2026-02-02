---
layout: default
title: Exporting data 
nav_order: 30
---

## Exporting data

Imagine you have performed this query:

```sql
/*
Select all properties within 200m a *particular* school
and show the distance in metres
*/
SELECT DISTINCT fid, prop_parcel_polygons.geom, civic_number, streetname, site_id,
DistanceWithin(centroid(CastAutomagic(prop_parcel_polygons.geom)), castAutomagic(schools.geom), 200) AS within_200,
round(Distance(CastAutomagic(prop_parcel_polygons.geom), castAutomagic(schools.geom))) AS distance_m,
SRID(prop_parcel_polygons.geom) AS SRID_geom,
SRID(schools.geom) AS SRID_school,
x(centroid(transform(castAutoMagic(prop_parcel_polygons.geom), 4326))) as long_prop,
y(centroid(transform(castAutoMagic(prop_parcel_polygons.geom), 4326))) as lat_prop
FROM prop_parcel_polygons
FULL OUTER JOIN (SELECT * FROM sd_39_schools AS schools WHERE schools.SCHOOL_NAME='Lord Byng Secondary')AS schools
WHERE
PtDistWithin(centroid(CastAutomagic(prop_parcel_polygons.geom)),  castAutomagic(schools.geom), 200) = 1
ORDER BY distance_m DESC;
```

You can export this _as is_ by **saving the results view**. However, there is a slight problem with the export; the geometry is stored there as well and is basically useless when viewed as a spreadsheet. If you just want a spreadsheet, edit the first line to say:

`SELECT DISTINCT fid, civic_number, streetname, site_id,`

That is, remove the geometry column.

You can then open your data in any spreadsheet application

## Exporting to GIS easily

`SELECT DISTINCT fid, AsText(castAutoMagic(prop_parcel_polygons.geom)) AS wkt_geom,`

{: .note}
Even though you may select the tab separator in the dialogue, you still need to explicitly select .tsv format for the export or DB Browser will automatically add a .csv extension. Yes, this is annoying.

Once you've exported a \[ct\]sv file, you can easily import it into a GIS application, as this screenshot from QGIS shows:

![Importing WKT into QGIS](assets/images/import_wkt_qgis.png)

You will need to set the delimiter (in this case a tab), the projection (BC Albers, or EPSG:3005) and select the geometry column and type (if it fails to do it automatically).


## Other export methods
If you wish to export a GeoJSON or Shapefile directly, you can also do this using the functions `ExportGeoJSON2` and `ExportSHP`, as well as others. There are several caveats:

* The SPATIALITE_SECURITY environment variable must be set to 'relaxed'
* Generally, exporting like this exports a whole *table*, not just a query. If you wish to export the results of a query, you must create a new table (with all that entails) and export that way. Also, it *cannot* be a temporary table — it must be a real one.
* Tables can be created with the `CREATE TABLE AS SELECT` syntax.
* Exporting this way inevitably runs to issues with geometry. While both Spatialite and GeoPackage are supported, the `Export` functions **only** work with Spatialite geometry, not GeoPackage, which is something omitted from the documentation. You will need to *not* be in GeoPackage Mode, and you will need to convert the geometry to Spatialite Geometry with `castAutoMagic`, then use the `RecoverGeometryColumn` function. Once you know this, it's not so bad. It's the finding out that's the hard part.

```sql
/*
Export a GeoJSON and a shapefile by creating a table, exporting, then deleting the table.
Remember, SPATIALITE_SECURITY must be 'relaxed'

The same procedure applies for shapefiles, kmls and other exports.
Read the functions carefully
*/
SELECT disableGpkgMode();
SELECT disableGpkgAmphibiousMode();
--the next two commands aren't necessary if the table doesn't exist yet
DROP TABLE IF EXISTS secondary;
DELETE FROM  geometry_columns WHERE f_table_name='secondary';
CREATE TABLE secondary AS SELECT fid,civic_number, streetname, site_id, castAutoMagic(geom) as g2 from prop_parcel_polygons WHERE streetname LIKE 'DUNBAR%';
--Note that the JSON lat/long column in this particular datafile was excluded because JSON inside a JSON is asking for trouble.
SELECT RecoverGeometryColumn('secondary', 'g2', 3005, 'POLYGON');
SELECT ExportGeoJSON2('secondary', 'g2', '/tmp/dunbar.geojson', 8, 1, 0, 1, 'LOWER' );
--ExportShp adds extensions automatically
SELECT ExportSHP('secondary', 'g2', '/tmp/dunbar', 'UTF-8');

DROP TABLE secondary;
DELETE FROM  geometry_columns WHERE f_table_name='secondary';
``` 
