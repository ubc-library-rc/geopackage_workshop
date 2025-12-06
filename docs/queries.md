---
layout: default
title:  Queries part 1 
nav_order: 15 
---
## Basic queries
Basic example

```sql
/*
Select the centroid points of parcels and
return only the longitudes as degrees
*/
SELECT x(centroid(transform(castautomagic(geom),4326))) AS long
FROM prop_parcel_polygons LIMIT 3;
```

Order of operations
Discuss

More useful example


```sql
/*
Select all properties in 1000 block W 70th and show the
latitude, longitude and area, with an example
of what happens if you use the wrong projection.
*/
SELECT
*,
x(Centroid(Transform(CastAutomagic(geom),4326))) AS long,
y(Centroid(Transform(CastAutomagic(geom),4326))) AS lat,
Area(CastAutoMagic(geom)) AS area,
Area(Transform(CastAutomagic(geom),4326)) AS badarea
FROM prop_parcel_polygons
WHERE civic_number LIKE '10__' and streetname LIKE'W 70TH%';
```

Note that badarea = 3.3437730152941e-08

Clearly this is wrong and is an example of why projection matters


Get properties within 250m of a point

```sql
/*
Select parcels within 250m distance of *manually entered* point
and show the lat, long and area of the parcel
*/
SELECT
*,
x(Centroid(Transform(CastAutomagic(geom),4326))) as long,
y(Centroid(Transform(CastAutomagic(geom),4326))) as lat,
Area(CastAutoMagic(geom)) as area
FROM prop_parcel_polygons
WHERE
--Coordinates are entered into the MakePoint function
distanceWithin(castAutoMagic(geom), transform(castAutoMagic(MakePoint(-123.131457045205, 49.2082220977993, 4326)),3005), 250);
```

## Slightly more advanced queries
Most of the time you will not be entering point or polygons manually, you will need to be querying based on the properties of the data set itself.

Discuss JOINS

insert join diagram

```sql
/*
Select properties within 500m of an address and
display the distance in km rounded to two decimal points
*/
SELECT props.civic_number, props.streetname, 
round(distance(CastAutoMagic(props.geom), castAutoMagic(target.geom))/1000, 2) as distance_km
FROM prop_parcel_polygons AS props
FULL OUTER JOIN 
(SELECT geom, * FROM prop_parcel_polygons 
WHERE 
civic_number='1090' AND streetname LIKE 'W 70TH%' LIMIT 1 ) AS target
WHERE
Distance(castAutoMagic(props.geom), castAutoMagic(target.geom))/1000 < .5;

```
