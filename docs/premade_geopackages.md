---
layout: default
title: Using DB Browser with premade GeoPackages
nav_order: 10
---

# Using premade GeoPackages

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

{: .note}
This is actually the case with the sample database; if you try you will see that GetGpkgMode always returns 0. This is because it was laboriously converted to a GeoPackage manually for the purposes of this tutorial.
