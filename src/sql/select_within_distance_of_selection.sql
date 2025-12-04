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
