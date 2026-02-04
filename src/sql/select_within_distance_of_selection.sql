/*
Select properties within 500m of an address and
display the distance in km rounded to two decimal points
*/
SELECT props.civic_number, props.streetname, 
round(Distance(CastAutomagic(props.geom), CastAutomagic(target.geom))/1000, 2) AS distance_km
FROM prop_parcel_polygons AS props
JOIN 
(SELECT geom, * FROM prop_parcel_polygons 
WHERE 
civic_number='1090' AND streetname LIKE 'W 70TH%' LIMIT 1 ) AS target
WHERE
Distance(CastAutomagic(props.geom), CastAutomagic(target.geom))/1000 < .5;
