---
layout: default
title: Demystifying BC Assessment Data
nav_order: 2 
---
# Demystifying BC Assessment Data

## Objectives

	* Understand the [SQLite](sqlite.org) database which holds BC Assessment data
	* Learn to read the database using [DB Browser for SQLite](sqlitebrowser.org)
	* Learn basic SQL query syntax --further learning
    * Learn to import external data --further learning
    * Learn how to enable Geopackage support in DB Browser
	* Learn how to import data and join it to BC Assessment data  --further learning
	* Learn how to perform geospatial SQL queries *without* using a dedicated Geographic Information System such as ArcGIS Pro or QGIS
	* Learn how to *export* the data for use in other applications, such as Excel

## Workshop overview

    Will this be a hands-on workshop? That could be tough via Zoom.

    Because the workshop takes place over Zoom, it will not be possible to make it a hands-on workshop. However, participants are encouraged to follow along on their own computers and to ask questions.

## Prerequisites
    
    * Computer with DB Browser for SQLite (from this point just "DB Browser") installed. Supported platforms are MacOS, Windows, and Linux. For MacOS, you should install [Homebrew](brew.sh) to enable easy geopackage support.
    * Although we will give an overview of SQLite, this is not really an introduction to SQL. Some SQL knowledge would be very helpful
    * If you are following along, the BC Assessment Data set from Abacus: https://abacus.library.ubc.ca/dataset.xhtml?persistentId=hdl:11272.1/AB2/NXRVP9 
        [Select *which* of these we need]
    * Experience using a terminal/command prompt may be helpful

## Part I - Preparing DB Browser for SQLite
    [Provide some troubleshooting]
    * Install software (whatever means you want)
    * Download mod_spatialite
        * Windows: 
            <https://www.gaia-gis.it/gaia-sins/>. Select 32 or 64 bit as required
            * Uncompress this file (using 7z or other application) and move the uncompressed folder to its permanent location
        * MacOS: `brew install libspatialite`
        * Name may vary on Linux: `apt install libsqlite3-mod-spatialite`
    * Configure DB Browser:
        * Either Edit/Preferences or DB Browser for SQLite/Settings (MacOS)
        * Under Extensions use the "Add extension button" (it looks like a puzzle piece) 
        * Navigate to where the Spatialite extension and select the appropriate file:
            * MacOS: /opt/homebrew/Cellar/libspatialite/[version]/mod_spatialite.8.dylib (or similar)
            * Linux: /lib/[distro_dependent_path]/mod_spatialite.so or it's original file
        * Switch to the "General" tab
            * Click "Manage" beside "DB File Extensions"
            * Select "Add"
            * Double click "Description" and type "Geopackage"
            * Double click "*.Extension" and type *.gpkg
        * Hit OK, then Save. You have enabled Spatialite!

## Part 2: Why SQL

    * Data is disseminated by BC Assessment and GeoBC as a database
    * SQLite is a relational database, which allows you to have multiple tables with some relationship, either direct or indirect, with other tables in the database. This is like Microsoft Access, but with a few differences)
        * It's a single file, which makes it very portable
        * Multi-platform; it works on Windows, Mac, Linux and other operating systems (like Android)
    * Spatialite is an extension (a piece of software which extends functionality) which enables analysis by geography; ie, you can consider the *spatial* component of relationships too
    * Spatialite supports two types of [related] databases: Spatialite, and the newer, more common, Geopackage database. Both use more-or-less the same features, but because both are part of the same software
    * Data from other sources can be imported or linked to the database
    * SQL allows for analysis in place
    * Data can also be *exported* in a number of formats, so it's possible to (for example) work on a small subsample    

## Part 2a: Orientation to DB Browser interface
    SQL window, database view and schema view

## Part 3: Basic queries
    [sample query that someone could typically do, non-spatial, probably with joins on other tables]
    * Folio ID identifies a property, and is used as a method of linking to other tables
    [non case-level data, counts, etc]

## Part 4: Importing other data and using that as well

    * Data is imported into DB Browser either by delimited text files, or by SQL. The most common way is delimited text.  [Discussion of CSV/TSV, plus how to make one out of Excel]
    * When imported, data is just another table, and works the same way
        [sample query]


## Part 5: Intro to Geopackage
    * Point out that we have ignored the vast majority of tables. These are all tables that are used for georgaphic functionality
    * Indices, spatial indices, coordinate reference systems, etc. Essentially everything that a Geographic Information System needs.
    * But you don't need to have a dedicated GIS application system to use it. You can use DB Browser
    * The important difference is that these databases have their geometry encoded into the database, usually in a column called `geom`.
        * Binary format
        * This is the part that displays in ArcGIS, like an Illustrator document.

    * explain SQL functions, and how you often have to use them with SELECT, otherwise it doesn't work
    * Explain how, because there are two different systems, Spatialite and Geopackage geometry isn't the same

## Part 6: Using Geopackage
    
    * Using `SELECT` to chose modes (like EnableAmphibiousMode())
    * Attaching databases [maybe take this out]
    * Creating geometry columns
    * The importance of not using a temporary database
    * Performing a spatial search
    * Common pitfalls
    * SPATIALITE_SECURITY and why it matters [Advanced tips/don't show, export tabular data only but mention in extra learning] 
        * Environment variables in various OSs
    * Exporting data as both tabular data *AND* as GIS files

## Conclusion
    Now you can do anything

## Where to get help
    Paul, Jeremy, [Meghan], [Alex]

## Important websites
    
    * Windows software: www.gaia-gis.it/gaia-sins/
    * DB Browser for SQLite: sqlitebrowser.org
    * SQLite: sqlite.org
    * Spatialite: https://www.gaia-gis.it/fossil/libspatialite/index
        Spatialite functions list: https://www.gaia-gis.it/gaia-sins/spatialite-sql-5.1.0.html
    * BC Assessment data advice on Abacus: https://abacus.library.ubc.ca/dataset.xhtml?persistentId=hdl:11272.1/AB2/NXRVP9
    * Handy quickstart for SQL: https://www.w3schools.com/sql/

## FAQ    

