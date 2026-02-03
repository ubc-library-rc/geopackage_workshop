/*
If you ever delete your table or have problems creating a geometry column, have a look
at gpkg_geometry_columns and make sure that there is not an entry already.

It will persist EVEN IF THE TABLE HAS BEEN DELETED, so you have to delete
the entry manually.

*/
DELETE FROM gpkg_geometry_columns WHERE table_name='sd_39_schools';
