---
layout: default
title: Projections and Spatial References 
nav_order: 12
---
# The earth is not flat 

Although the earth is round(ish), the way Spatialite (and really almost all geographic software works) is by calculating things in (largely) two dimensions. This means that the sphere is flattened out, like taking an orange, unpeeling it (technically an optional step), and making it flat. This has an effect on calculations, because doing this means that not all of distance, area and shape can be preserved at the same time. Differences may be negligible if you're examining small areas, but much more pronounced for large areas. 

The correspondence between the points on the intact orange and and the flattened orange defines the projection/spatial reference system.

## Displaying and working with projections

You can see what projection your data layer has by a simple commmand. "SRID" seems an unintuitive abbreviation until you realize it stands for "spatial reference identification".


```sql
--Show the projection of the layer
SELECT SRID(geom) FROM prop_parcel_polygons LIMIT 4;
```

You will see that it is technically possible to store each piece of data in a different projection. Just because you can, does not mean you *should*. The overwhelming majority of data sets will have the same projection for each piece of data, at least within a single table.

There are many (many) map projections. This is a fine source of reference: [EPSG definitions](https://spatialreference.org){:target="_blank"}. It's not exhaustive, because it's possible to define your own projections too.

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

### Why projections are extremely important.

If you've never used map projections before, you may be scratching your head by now as to what this really means. Let's use a simple ecample of why projections matter.

* Your GeoPackage comes with data in a specific projection. The example above using SRID() produced a value of 3005, which corresponds to [BC Albers Projection](https://spatialreference.org/ref/epsg/3005/){:target="_blank"}. If you look at that page, you'll see that the units used (UoM) are metres.

* Imagine you have another set of data which you have imported. This set has latitude and longitude points. This type of data is "unprojected", meaning it gives spherical coordinates. While there are many unprojected coordinate systems, most commonly this data is in [WGS 84 (EPSG:4326)](https://spatialreference.org/ref/epsg/4326/){:target="_blank"}. The units of measure are degrees.

If you want to relate spatial attributes between layers, they need to use the same frame of reference, otherwise the results may be meaningless, "This school is 20 degrees away". In a GIS application like, say, QGIS, coordinate transformations are often done automatically. But you are not using GIS software, so you have to do it yourself. Fortunately, this is not particularly difficult to do. 

```sql
-- Reproject geometry to EPSG:4326 (WGS 84) 
SELECT transform(castAutomagic(geom), 4236) FROM prop_parcel_polygons LIMIT 4;
```

This will transform the geometry form one projection to another. When you run this query, you can't tell though, because it's just outputting a binary blob. But trust me, you have. But trust is in short supply these days.

```sql
--Verify that your transformation worked
SELECT x(transform(centroid(castAutomagic(geom)), 4236)) FROM prop_parcel_polygons LIMIT 10
```

You may note the "centroid" portion. The parcel polygons are, well, polygons, so they don't have single x (or longitude) value. This demonstration took the x-value of the centre point. And if if still doesn't make any sense the [queries](queries.md) page goes into more detail.

{: .important}
>There are many ways to flatten an orange. Similarly, there are just as many ways to create a map projection. When you're working with different sets of data, you should ensure that they all use the same projection, because if they don't, any calculations may be off. Everyone should flatten their oranges in the same way.
>
>Map projections are a large and complex subject, but if you just remember that everything should have the same frame of reference you've taken the hardest, largest step.

### Bonus section

Not all analyses take place on the earth, and even non-terrestrial objects have projections. Because it's possible to define your own projections if you are so inclined, the number of sources of potential errors are limitless. This is why data science consists of largely of banging your head into the corner of a desk.



