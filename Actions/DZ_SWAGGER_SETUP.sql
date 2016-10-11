DECLARE
   int_count NUMBER;
   
BEGIN

   SELECT
   COUNT(*)
   INTO int_count
   FROM
   user_tables
   WHERE 
   a.table_name IN (
      SELECT * FROM TABLE(dz_swagger_setup.dz_swagger_table_list())
   );
   
   -- Note the tablespaces are controlled via constants package
   IF int_count = 0
   THEN
      dz_swagger_setup.create_storage_tables();
   
   END IF;

END;
/

