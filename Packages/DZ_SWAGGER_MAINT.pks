CREATE OR REPLACE PACKAGE dz_swagger_maint
AUTHID DEFINER
AS

   -----------------------------------------------------------------------------
   -- The import_json procedure was INTENDED to parse a swagger json file and
   -- load the results into the dz_swagger tables.  One would THINK this would
   -- be possible using the new 12c JSON SQL functions.  But alas there remains
   -- a 4000 byte limit on JSON_QUERY which makes it basically unusable for 
   -- large JSON structures such as swagger.  I would expect this limitation to
   -- be raised in the near future so the code remains for future development. 
   -----------------------------------------------------------------------------
   PROCEDURE import_json(
       p_input         IN  CLOB
      ,p_versionid     IN  VARCHAR2 DEFAULT NULL
      ,p_headerid      IN  VARCHAR2 DEFAULT 'IMPORT'
      ,p_groupid       IN  VARCHAR2 DEFAULT 'IMPORT'
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE dump_swagger_tables(
       p_filename      IN  VARCHAR2 DEFAULT NULL
      ,p_directory     IN  VARCHAR2 DEFAULT 'LOADING_DOCK'
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE restore_swagger_tables(
       p_filename      IN  VARCHAR2
      ,p_directory     IN  VARCHAR2 DEFAULT 'LOADING_DOCK'
      ,p_action        IN  VARCHAR2 DEFAULT 'TRUNCATE'
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION validate_path_object_parms(
       p_versionid     IN  VARCHAR2 DEFAULT NULL
      ,p_path_group_id IN  VARCHAR2 DEFAULT NULL
   ) RETURN MDSYS.SDO_STRING2_ARRAY PIPELINED;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION validate_def_tables(
       p_versionid     IN  VARCHAR2 DEFAULT NULL
   ) RETURN MDSYS.SDO_STRING2_ARRAY PIPELINED;

END dz_swagger_maint;
/

