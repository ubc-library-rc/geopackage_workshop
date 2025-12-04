---
layout: default
title: Importing external data 
nav_order: 20
---
## Importing data

Many times you will need to import data because your are studying something else. 
Use School data `sd_39_schools.csv`

Came from provincial gov't
cropped for brevity


Not quite as straightforward as a regular import, because you have to turn your spreadsheet into something which is geospatially aware.

Import data from CSV file

```sql
/*You should have already performed these steps

SELECT enableGpkgMode();
SELECT getGpkgMode();
-- And it should be in Geopackage mode

SELECT InitSpatialMetadata();
--so you can do transformations/

-- After these are done, you can import data using
-- File/Import/Table From CSV File
-- in this case, sd_39_schools.csv

-- Then, you need to add a geometry column
*/

SELECT gpkgAddGeometryColumn('sd_39_schools', 'geom', 'POINT', 0, 0, 4326);
```

```sql
/*
If you ever delete your table or have problems creating a geometry column, have a look
at gpkg_geometry_columns and make sure that there is not an entry already.

It will persist EVEN IF THE TABLE HAS BEEN DELETED, so you have to delete
the entry manually.

*/
DELETE FROM  gpkg_geometry_columns WHERE table_name='sd_39_schools';
```

You can create the geometry like this (note, this doesn't actually add it to the table):

```sql
SELECT transform(castAutoMagic(gpkgMakePoint(SCHOOL_LONGITUDE, SCHOOL_LATITUDE, 4326)), 3005) from sd_39_schools;
```
Transforms the data so that it uses the same projection aas the original data set, for ease of use later.

To add it to the file:

```sql
/*
This will *actually* do the update
*/
UPDATE sd_39_schools SET geom = geom_gpb 
FROM 
(
SELECT transform(castAutoMagic(gpkgMakePoint(SCHOOL_LONGITUDE, SCHOOL_LATITUDE, 4326)), 3005) AS geom_gpb FROM sd_39_schools
)
```

Now your data is in the geopackage and you can use it to work with any other table in your database.
