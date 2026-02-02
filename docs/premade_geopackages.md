---
layout: default
title: Using DB Browser with premade GeoPackages
nav_order: 10
---

We will first start off by understanding how to use an already existing GeoPackage database. This is not a tutorial for the [DB Browser](https://sqlitebrowser.org) interface; it assumes you can use the interface for basic operations like entering SQL, etc. All of the functions are available via reasonably obvious buttons or through menus.

*1*{: .circle .circle-blue} Open an existing geopackage database with File/Open; the images and examples in this tutorial use a geopackage called `property-parcel-polygons.gpkg`, which, if you have cloned the Github repository, is at `src/data`.

*2*{: .circle .circle-blue}To ensure that your Spatialite extensions are working properly, switch to the **Execute SQL** tab, and run the following SQL:

```sql
SELECT spatialite_version() AS spatialite_version, HasGeoPackage() AS has_gpkg;
```
Assuming your installation has been successful, you should see a line of data with two values like the following screenshot. Your spatialite\_version may vary.

![Verify GeoPackage support](assets/images/mac_check_gpkg.png)

{:.note}
Ironically, you can't perform this step until you have a database open. It doesn't need to be a GeoPackage database, though. You can if you want, create a new, empty database and run the query and it will produce a result.

**If you get an error or no result**: you may have not enabled the extensions properly, or, if you are anything like the author, just made a typo. If not the latter, verify that you have [installed the extension(s) properly](db_browser_setup.html).

*3*{: .circle .circle-blue} In the **DB Schema** view (bottom right of the screenshot), you will notice that there are a terrifyingly large number of tables. **Do not panic**; this is normal. Almost all of them will be used by the extension itself and you will not be querying them directly. More specifically, you can (typically) not worry about Elementary Geometries, KNN2, SpatialIndex, geometry_columns\*, gpkg\*, rtree\*, spatial_ref\*, sql_statements_log, and sqlite_sequence. Not all of these files will be present in all GeoPackages, but a lot of them will.

*4*{: .circle .circle-blue}Spatialite Functions
As mentioned in the [introduction](what_is_a_geopackage.html), technically GeoPackage is standard and Spatialite is used to read data from this standard. What this means, in practice, is that using the Spatialite adds an enormous variety of functions available through SQL that are not normally available using plain SQLite.

These functions are called exactly the same way built-in functions are called. SQL commands are not case-sensitive. You may see various capitalizations of functions, etc. While I try to be consistent, it's all typed by hand, and if it works I'm not going to stress because it's **select** and not **SELECT**. And neither should you. If you're using AI to generate your SQL for Spatialite, it will, at some point, be wrong, so your best option is to actually learn how it works.

For example:

```sql
--Built-in function
SELECT length(data_licenses.name) as lname from data_licenses;
```

*5*{: .circle .circle-blue}Verify that Spatialite and GeoPackages work

```sql
-- Verify that everything is installed
SELECT spatialite_version() AS spatialite_version, HasGeoPackage() AS has_gpkg;
```


```sql
/*
Different modes are available and can be enabled and disabled at will.
*/
SELECT enableGpkgMode();
--SELECT disableGpkgMode();
--SELECT enableGpkgAmphibiousMode();
--SELECT disableGpkgAmphibiousMode();
```

You can always ensure that you've done what you think you've done:

```sql
/*
In case you forget what has been enabled, view the results like this.
*/
SELECT GetGpkgMode(), GetGpkgAmphibiousMode();
```
Generally speaking, start with enableGpkgMode() to ensure maximum compatibility. Over the course of time, you may find that pure GeoPackage mode can't be enabled. This is because of the intermingling of functions between Spatialite and the Geopackage standard. It's not an enormous problem, and you can enable the amphibious mode if you have to and things will still work just fine.

Find the projection of your data:

```sql
--Show the projection of the layer
SELECT SRID(geom) FROM prop_parcel_polygons LIMIT 4;
```

There are many (many) map projections. This is a fine source of reference: [EPSG definitions](spatialreference.org). It's not exhaustive, because it's possible to define your own projections too.

{: .important}
If you need to transform your coordinate systems, you *must* have a table called **spatial_ref_sys**. If you don't have that table, the transformations won't work.

If this doesn't work check to see if the spatial_ref_sys  table is there. It probably isn't. Then you must create it!

Thankfully, this is easy.
```sql
select InitSpatialMetadata();
```
The function creates any necessary tables, but they won't be visible in the schema viewer until you save and reopen the database. But it will still work even if the tables are not not visible. You can verify that the command worked by seeing if the tables are present, because they will be listed in the (hidden by default) `sqlite_master` table:

Without the spatial metadata, coordinate transformations will not work!

`select * from sqlite_master where name like '%spatial%'`


Why? Discussion of coordinate systems, especially WGS-84 and lat/long

In a GIS application, this is normally built-in to the software. But you are not using GIS software.

```sql
-- Reproject geometry to EPSG:4326 (WGS 84) 
SELECT transform(castAutomagic(geom), 4236) FROM prop_parcel_polygons;
```


