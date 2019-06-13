CREATE OR REPLACE PACKAGE dz_swagger_constants
AUTHID DEFINER
AS
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   /*
   Header: DZ_SWAGGER
     
   - Release: %GITRELEASE%
   - Commit Date: %GITCOMMITDATE%
   
   PLSQL module for the creation, storage and production of Open API service 
   definitions.   Support for the unloading of Swagger JSON specifications into
   the storage tables is not currently supported.   
   
   */
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   /*
   Constant: dz_swagger_constants.c_table_tablespace
      Tablespace in which to store table resources created by dz_swagger. Leave
      NULL to use the schema default
   */
   c_table_tablespace  CONSTANT VARCHAR2(40 Char) := NULL;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   /*
   Constant: dz_swagger_constants.c_index_tablespace
      Tablespace in which to store index resources created by dz_swagger. Leave
      NULL to use the schema default
   */
   c_index_tablespace  CONSTANT VARCHAR2(40 Char) := NULL;

END dz_swagger_constants;
/

GRANT EXECUTE ON dz_swagger_constants TO PUBLIC;

