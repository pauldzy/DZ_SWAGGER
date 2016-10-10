CREATE OR REPLACE PACKAGE dz_swagger_setup
AUTHID CURRENT_USER
AS
  
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE create_storage_tables(
       p_table_tablespace VARCHAR2 DEFAULT NULL
      ,p_index_tablespace VARCHAR2 DEFAULT NULL
   );
 
 END dz_swagger_setup;
/

