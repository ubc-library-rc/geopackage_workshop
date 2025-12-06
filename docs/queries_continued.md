---
layout: default
title: Queries continued 
nav_order: 25
---

## Querying using your imported data

```sql
/*
Select all properties within 200m of all schools
*/
SELECT DISTINCT *, 
PtDistWithin(centroid(CastAutomagic(prop_parcel_polygons.geom)),  castAutomagic(schools.geom), 200) AS within_200
FROM prop_parcel_polygons
FULL OUTER JOIN sd_39_schools AS schools
WHERE
PtDistWithin(centroid(CastAutomagic(prop_parcel_polygons.geom)),  castAutomagic(schools.geom), 200) = 1
```


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

Note that it's **much** faster to do a FULL OUTER JOIN to a smaller table, so Lord Byng is selected **before** joining.

```sql
/*
Select all properties within 200m a *particular* school, 
and show the distance in metres,
this time using the property perimeter
*/
SELECT DISTINCT prop_parcel_polygons.fid, AsText(castAutoMagic(prop_parcel_polygons.geom)) AS geom, civic_number, streetname, site_id,
DistanceWithin(CastAutomagic(prop_parcel_polygons.geom), castAutomagic(schools.geom), 200) AS within_200,
round(Distance(CastAutomagic(prop_parcel_polygons.geom), castAutomagic(schools.geom))) AS distance_m,
SRID(prop_parcel_polygons.geom) AS SRID_geom,
SRID(schools.geom) AS SRID_school,
x(centroid(transform(castAutoMagic(prop_parcel_polygons.geom), 4326))) as long_prop,
y(centroid(transform(castAutoMagic(prop_parcel_polygons.geom), 4326))) as lat_prop
FROM prop_parcel_polygons
--FULL OUTER JOIN (SELECT * FROM sd_39_schools AS schools WHERE schools.SCHOOL_NAME='Lord Byng Secondary')AS schools
FULL OUTER JOIN (SELECT fid, geom FROM prop_parcel_polygons WHERE fid=66129) AS SCHOOLS
WHERE
DistanceWithin(CastAutomagic(prop_parcel_polygons.geom),  castAutomagic(schools.geom), 200) = 1
ORDER BY distance_m DESC;
```

See the difference:
![Centroids vs boundaries](assets/images/centroids_vs_boundaries.png)
