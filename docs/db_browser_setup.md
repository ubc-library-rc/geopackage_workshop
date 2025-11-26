---
layout: default
title: Setting up DB Browser
has_children: true
nav_order: 4 
has_toc: false
---

## Setting up DB Browser for use with GeoPackages and Spatialite

### What is all this?

A [GeoPackage](https://en.wikipedia.org/wiki/GeoPackage)  (note the capital P) is a type of [relational database](https://en.wikipedia.org/wiki/Relational_database) which both holds geographic data and has the capability to perform spatially aware functions with it. It is similar to a Spatialite database, which has very similar capabilities. But this capability is not available by default, so it requires a bit of extra work, or [yak-shaving](https://en.wiktionary.org/wiki/yak_shaving){:target="_blank"}.

<details markdown="block">

<summary>I want even more information</summary>

Both GeoPackages and Spatialite are extensions to [SQLite](https://sqlite.org) databases. That is they *are* SQLite databases, and all SQLite functions will work on them, but if you have extensions installed you can perform even *more* operations.

SQLite databases have several features which make them useful:

* They can hold any type of digital data
* They are portable, with each SQLite database, and by extension, GeoPackages and Spatialite databases, is a single file.
* Multiple databases can be attached to each other, even on an *ad_hoc* basis
* The standards are open
* SQLite databases are supported on almost every platform, from Arduinos to supercomputers. This includes cell phones

GeoPackages and Spatialite databases have all of these advantages, plus:
* They can perform spatially aware operations like distance calculations, etc.
* They can hold both vector and raster data
* Because they are databases, they are free of many of the constraints of an ArcGIS shapefile, so they can have long field names, unusual data types etc.

While these databases can be opened and used in a geographic information system such as QGIS or ArcGIS, these types of applications have very steep learning curves. **Using a dedicated GIS application is not required** to access the spatial features of a GeoPackage. If you need to perform some basic analysis, there may not be any reason to learn a GIS application, because the spatial operations are available via SQL (Structured Query Language).

</details>

## Installing SQLite 3 with GeoPackage/Spatialite support

{: .important}
The methods below are not the *only* way to install what you are need. If you want to do it another way, or have found some more comprehensible instructions, do you what you think is best. It's your computer, after all. 

### Instructions

* [Windows](installation/windows.html)
* [MacOS](installation/macos.html)
* [Linux](installation/linux.html)
