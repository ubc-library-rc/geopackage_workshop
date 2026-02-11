---
layout: default
title: Basic queries 
nav_order: 15 
---
## Basic queries

Technically, the commands from  [projections](projections.md) page constitute a SQL query. But as queries go, they didn't produce a lot of data that would be useful in a real-life situation besides verifying that the software worked. 

A SQL query is normally designed to extract some sort of pertinent information from your collection of data. SQL is somewhat like natural language, which means, in practice, that it's not actually natural language but close enough that errors are hard to find because of your order word.

If you have no knowledge of SQL, you may want to have a look at this [SQL tutorial](https://www.w3schools.com/sql/default.asp). The following sections and pages will mostly focus on Spatialite/GeoPackage specific language or less-common SQL.

### Example 1: Show the longitude of parcels

Here's a marginally useful query that shows the longitude of three property parcels.

```sql
--select_longitude.sql
/*
Select the centroid points of parcels and
return longitude as degrees
*/
SELECT *, X(Centroid(Transform(CastAutomagic(geom),4326))) AS long
FROM prop_parcel_polygons 
--ORDER BY long
LIMIT 3;
```

Let's examine this in a little more detail. SQL, like written English, is evaluated from left to write. But because this is a computer language, not always.

`SELECT *` selects and displays all of the columns in the table. But there will be an _column_.

The key here is `X(Centroid(Transform(CastAutomagic(geom),4326)))`. This is a set of Spatialite functions all nested within each other. It's important to remember that the order of operations inside functions is from the inside out. That is, in this order

* CastAutomagic()
* Transform()
* Centroid()
* X()


CastAutomagic transforms the geometry to Spatialite geometry, even if the input is GeoPackage geometry. **The overwhelming majority of functions which process geometry take Spatialite geometry**. That output is passed to Transform, which converts it EPSG:4326 projection (WGS 84, or latitude/longitude unprojected data). That is then passed to the Centroid function, which calculates the Centroid or centre point of the polygon. Finally, the x dimension (or longitude) is extracted from the centroid.

Next is **AS**, which will become your friend as you learn to use GeoPackages. The AS clause will rename the column to **long**, instead of using its default value of **X(Centroid(Transform(CastAutomagic(geom),4326)))**, which I think we can all agree is a terrible name for a column.

You're selecting data **FROM** a single table, in this case *prop\_parcel\_polygons*.

Finally, you want only three values, so you **LIMIT 3**.

If, say, you wanted the westernmost parcels, you can do this easily, by uncommenting the **ORDER BY** clause. This will take much longer, because it has to go through the entire result list and sort it by **long**. If your computer is a potato, it could take a *lot* longer. 

Remember that west is a negative number (ie, east of the 0 degrees), so the westernmost parcels have the lowest longitude value. 


### Example 2: Area calculations

While the first example is helpful to give you an idea of how querying a GeoPackage works, it's not overly complex. Going a little further, maybe you need to find the latitude and longitudes of residences in a particular place, and find out how big the parcels are.

```sql
--select_lat_long_area.sql
/*
Select all properties in 1000 block W 70th and show the
latitude, longitude and area, with an example
of what happens if you use the wrong projection.
*/
SELECT
*,
X(Centroid(Transform(CastAutomagic(geom),4326))) AS long,
Y(Centroid(Transform(CastAutomagic(geom),4326))) AS lat,
Area(CastAutoMagic(geom)) AS area,
Area(Transform(CastAutomagic(geom),4326)) AS badarea
FROM prop_parcel_polygons
WHERE civic_number LIKE '10__' and streetname LIKE'W 70TH%';
```

You may notice that when you run this query, in the first record **badarea** is showing as 3.3437730152941e-08 and all the others are similarly tiny. While properties have been getting smaller in the 21st century, it's unlikely that residential properties are available at a sub-atomic scale.

**What has happened?**

Note that **badarea** is defined as `Area(Transform(CastAutomagic(geom),4326))`. The coordinate system has been transformed from BC Albers (which uses metres as units of measurement) to WGS84 (ie, EPSG:4326) which uses *degrees*. Then the area calculation attempts to use these units to calculate an area, resulting in a value which makes no sense.

**This is why it's important to use the right projection for your calculations**. While this example has an obvious error, it's not always so obvious that something is wrong, so construct your queries carefully.


### Example 3: Properties within 250m of a point

Imagine you are a researcher, and you're studying how many residences are are within a certain distance of a particular establishement. You have the point you're interested in, and you want to know what's within 250m.

```sql
--select_within_distance_manually_entered_point.sql
/*
Select parcels within 250m distance of *manually entered* point
and show the lat, long and area of the parcel
*/
SELECT
*,
X(Centroid(Transform(CastAutomagic(geom),4326))) as long,
Y(Centroid(Transform(CastAutomagic(geom),4326))) as lat,
Area(CastAutoMagic(geom)) AS area
FROM prop_parcel_polygons
WHERE
--Coordinates are entered into the MakePoint function
distanceWithin(castAutoMagic(geom),
	Transform(castAutoMagic(MakePoint(-123.131457045205, 49.2082220977993, 4326)),3005), 250)
```
Most of the statements should be familiar, but now there's a **WHERE** clause, which specifies the conditions. You can't specify the point just as an x,y coordinate pair, unfortunately.

Like other functions, work from the centre outwards:

* MakePoint() takes three parameters. First is the x or longitude value, the second the y or latitude value. The 4326 tells you that it's in the WGS84 coordinate system (lat/long).
* CastAutomagic() ensures that the coordinates will be parsed correctly when you pass it to...
* Transform(). The second parameter of the function (3005) converts the coordinates to EPSG:3005 (BC Albers), which, if you recall, was found using SRID near the beginning of the tutorial. 
* DistanceWithin(). The first parameter is geometry from the query (ie, the parcel), the second parameter is the giant chain from above, and the third, 250, is the maximum distance in metres. Note that this is split up on two lines. It's not necessary to have everything on one line as long as you keep all of your parentheses and commas in order.

DistanceWithin() returns a boolean value, true or false. So if the statement is true, then the query returns those elements.

Success! But although it works, you will note that it only uses data within a ready made table. [But what if you have your own data?](importing_data.html)
