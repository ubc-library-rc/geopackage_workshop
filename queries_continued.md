---
layout: default
title: Queries continued 
nav_order: 25
---

## Querying using your imported data

```sql
/*
Select all properties within 200m of a school
*/
SELECT DISTINCT *, 
PtDistWithin(CastAutomagic(prop_parcel_polygons.geom),  castAutomagic(schools.geom), 200) AS within_200
FROM prop_parcel_polygons
FULL OUTER JOIN sd_39_schools AS schools
WHERE
PtDistWithin(CastAutomagic(prop_parcel_polygons.geom),  castAutomagic(schools.geom), 200) = 1
```
