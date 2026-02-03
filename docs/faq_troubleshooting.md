---
layout: default
title: FAQ & Troubleshooting 
nav_order: 35 
---

# Frequently asked questions & troubleshooting

### My query apparently runs without error, but the window displays no results


Even if Spatialite appears correctly installed, (ie, the query `SELECT spatialite_version() AS spatialite_version, HasGeoPackage() AS has_gpkg;` produces a result), there may still be a cleverly hidden problem.

This can happen if the **proj** library, which is responsible for data projection, is is not installed or not being detected correctly.

You can find out if this is the problem by going to the SQL Log and looking at the error log (you can click on the image to see it full size).

[![Proj error](assets/images/proj_error.png)](assets/images/proj_error.png){:target="_blank"}

If you see something like `PROJ reports "proj_create: no database context specified"`, this means that DB Browser is not finding **proj**.

While how to fix this varies by system, the problem most often occurs on Windows.

The fix:

* Ensure that **proj** is [installed correctly](https://proj.org/en/stable/install.html). 

* You may also (and *definitely* for Windows) need to have the **PROJ_LIB**  and **PROJ_DATA** environment variables set to the directory which contains **proj**. This is [usually] the dirctory which contains the file *proj.db*.

Use whatever method you like to find that file, and then set the environment variables to point at that directory.

{: .note} 
If you have QGIS installed, the **proj** directory is already available to you, at _[QGIS Installation Directory]/share/proj_.

A discussion of this (although not related to this specific problem) is available here: <https://github.com/pyproj4/pyproj/discussions/1262>{:target="_blank"}

### The dataset prop_parcel_polygons already has JSON data with lat/long points. Why are we using X() and Y()?

Yes, you can parse JSON data with SQLite, but this is a GeoPackage tutorial. And having JSON with lat/long points is a rarity. The eagle-eyed may notice that the values may not be exactly the same as those calculated. This can happen for a number of reasons, including, but not limited to, the original coordinate system and transformations used and floating point accuracy. For a discussion of what the difference may mean, see this Stackexchange page: <https://gis.stackexchange.com/questions/8650/measuring-accuracy-of-latitude-and-longitude>{:target="_blank"}.
