CREATE OR REPLACE PACKAGE dz_swagger_setup
AUTHID DEFINER
AS
  
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE create_storage_tables(
       p_table_tablespace VARCHAR2 DEFAULT dz_swagger_constants.c_table_tablespace
      ,p_index_tablespace VARCHAR2 DEFAULT dz_swagger_constants.c_index_tablespace
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION dz_swagger_table_list
   RETURN MDSYS.SDO_STRING2_ARRAY;
 
 END dz_swagger_setup;
/

