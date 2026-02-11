---
layout: default
title: Introduction 
nav_order: 0
has_children: true
has_toc: false
---

## GeoPackages, or GIS without GIS

![SQLite screenshot](assets/images/mac_db_browser_intro.png "Do not be alarmed")

Before you do anything, [please take a minute to consider where you are](land-acknowledgement.html).

This workshop will provide an introduction to using GeoPackage (and to some extent, Spatialite) spatial databases _without_ using specialized geographic information systems (GIS) software. This doesn't mean that it is a GIS replacement, but GIS software learning curves are steep, and may not be necessary depending on your needs.
 
The only software you will need is an interface to [SQLite](https://sqlite.org). This workshop will use [DB Browser for SQLite](https://sqlitebrowser.org), but any SQLite software will do, even the SQLite terminal interface.

It also presupposes *some* knowledge of SQL (structured query language), although if you don't know any it may still be of use to you.

### Is this for me?

Not sure? Here are some situations where GeoPackages can be useful:
* if you’re familiar with databases but not GIS software
* to analyse spatial data when the output is not a map (e.g. calculate distance between points)
* to filter or manipulate spatial data before opening it in GIS software (e.g. if source dataset is large)
* to work with spatial data where GIS software is not available (e.g. in mobile app development)

### Prerequisites
 
* A basic understanding of SQL databases
* A functioning SQLite environment. This tutorial uses DB Browser for SQLite. Setup instructions are available [here](db_browser_setup.html#installing-sqlite-3-with-geopackagespatialite-support)

### Objectives

After completion you should have an understanding of:

* What a GeoPackage is and what it does
* How to perform basic queries
* How to perform some basic geographic operations
* How to export your data, either as a data table or in a spatial format.

