--
--*************************--
PROMPT sqlplus_header.sql;

WHENEVER SQLERROR EXIT -99;
WHENEVER OSERROR  EXIT -98;
SET DEFINE OFF;
--
--*************************--
PROMPT DZ_SWAGGER_CONSTANTS.pks;

CREATE OR REPLACE PACKAGE dz_swagger_constants
AUTHID CURRENT_USER
AS
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   /*
   Header: DZ_SWAGGER
     
   - Build ID: 17
   - Change Set: 2a551e67827bdf8d9e243bd6c168e42d9abd3952
   
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

--
--*************************--
PROMPT DZ_SWAGGER_SETUP.pks;

CREATE OR REPLACE PACKAGE dz_swagger_setup
AUTHID CURRENT_USER
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

--
--*************************--
PROMPT DZ_SWAGGER_SETUP.pkb;

CREATE OR REPLACE PACKAGE BODY dz_swagger_setup
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE create_storage_tables(
       p_table_tablespace VARCHAR2 DEFAULT dz_swagger_constants.c_table_tablespace
      ,p_index_tablespace VARCHAR2 DEFAULT dz_swagger_constants.c_index_tablespace
   )
   AS
      str_sql VARCHAR2(4000 Char);
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check that user is qualified to create tables in schema
      --------------------------------------------------------------------------
   
      --------------------------------------------------------------------------
      -- Step 20
      -- Build VERS table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_vers('
              || '    versionid            VARCHAR2(40 Char) NOT NULL '
              || '   ,is_default           VARCHAR2(5 Char) NOT NULL '
              || '   ,version_owner        VARCHAR2(255 Char) '
              || '   ,version_created      DATE '
              || '   ,version_notes        VARCHAR2(255 Char)  '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_vers '
              || 'ADD CONSTRAINT dz_swagger_vers_pk '
              || 'PRIMARY KEY(versionid) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_vers '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_vers_c01 '
              || '    CHECK (is_default IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_vers_c02 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
   
      --------------------------------------------------------------------------
      -- Step 30
      -- Build DEF table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_def_prop('
              || '    definition          VARCHAR2(255 Char) NOT NULL '
              || '   ,definition_type     VARCHAR2(255 Char) NOT NULL '
              || '   ,property_id         VARCHAR2(255 Char) NOT NULL '
              || '   ,property_order      NUMBER NOT NULL '
              || '   ,property_required   VARCHAR2(5 Char)   NOT NULL '
              || '   ,column_name         VARCHAR2(30 Char) '
              || '   ,versionid           VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_def_prop '
              || 'ADD CONSTRAINT dz_swagger_def_prop_pk '
              || 'PRIMARY KEY(versionid,definition,property_id) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_def_prop '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_def_prop_c01 '
              || '    CHECK (definition = TRIM(definition)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_prop_c02 '
              || '    CHECK (property_id = TRIM(property_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_prop_c03 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_prop_c04 '
              || '    CHECK (property_required IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Build DEF ATTR table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_definition('
              || '    definition              VARCHAR2(255 Char) NOT NULL '
              || '   ,definition_type         VARCHAR2(255 Char) NOT NULL '
              || '   ,definition_desc         VARCHAR2(4000 Char) '
              || '   ,definition_desc_updated DATE '
              || '   ,definition_desc_author  VARCHAR2(30 Char) '
              || '   ,definition_desc_notes   VARCHAR2(255 Char) '
              || '   ,xml_name                VARCHAR2(255 Char) '
              || '   ,xml_namespace           VARCHAR2(2000 Char) '
              || '   ,xml_prefix              VARCHAR2(255 Char) '
              || '   ,table_owner             VARCHAR2(30 Char) '
              || '   ,table_name              VARCHAR2(30 Char) '
              || '   ,table_mapping           VARCHAR2(30 Char) '
              || '   ,versionid               VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_definition '
              || 'ADD CONSTRAINT dz_swagger_definition_pk '
              || 'PRIMARY KEY(versionid,definition,definition_type) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_definition '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_definition_c01 '
              || '    CHECK (definition = TRIM(definition)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_definition_c03 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Build PROPERTIES table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_property('
              || '    property_id           VARCHAR2(255 Char) NOT NULL '
              || '   ,property              VARCHAR2(255 Char) NOT NULL '
              || '   ,property_type         VARCHAR2(255 Char) NOT NULL '
              || '   ,property_target       VARCHAR2(255 Char) '
              || '   ,property_format       VARCHAR2(255 Char) '
              || '   ,property_allow_null   VARCHAR2(5 Char) NOT NULL '
              || '   ,property_title        VARCHAR2(255 Char) '
              || '   ,property_exp_string   VARCHAR2(255 Char) '
              || '   ,property_exp_number   NUMBER '
              || '   ,property_description  VARCHAR2(4000 Char) '
              || '   ,property_desc_updated DATE '
              || '   ,property_desc_author  VARCHAR2(30 Char) '
              || '   ,property_desc_notes   VARCHAR2(255 Char) '
              || '   ,xml_name              VARCHAR2(255 Char) '
              || '   ,xml_namespace         VARCHAR2(2000 Char) '
              || '   ,xml_prefix            VARCHAR2(255 Char) '
              || '   ,xml_attribute         VARCHAR2(5 Char) '
              || '   ,xml_wrapped           VARCHAR2(5 Char) '
              || '   ,xml_array_name        VARCHAR2(255 Char) '
              || '   ,versionid             VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_property '
              || 'ADD CONSTRAINT dz_swagger_property_pk '
              || 'PRIMARY KEY(versionid,property_id) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_property '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_property_c01 '
              || '    CHECK (property_id = TRIM(property_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_property_c02 '
              || '    CHECK (property = TRIM(property)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_property_c03 '
              || '    CHECK (property_target = TRIM(property_target)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_property_c04 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_wagger_property_c05 '
              || '    CHECK (property_allow_null IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Build HEAD table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_head('
              || '    header_id           VARCHAR2(255 Char) NOT NULL '
              || '   ,info_title          VARCHAR2(255 Char) NOT NULL '
              || '   ,info_description    VARCHAR2(4000 Char) '
              || '   ,info_termsofservice VARCHAR2(255 Char) '
              || '   ,info_contact_name   VARCHAR2(255 Char) '
              || '   ,info_contact_url    VARCHAR2(255 Char) '
              || '   ,info_contact_email  VARCHAR2(255 Char) '
              || '   ,info_license_name   VARCHAR2(255 Char) '
              || '   ,info_license_url   VARCHAR2(255 Char) '
              || '   ,info_version        VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_host        VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_basepath    VARCHAR2(255 Char) NOT NULL '
              || '   ,schemes_https       VARCHAR2(5 Char) NOT NULL '
              || '   ,consumes_json       VARCHAR2(5 Char) NOT NULL '
              || '   ,consumes_xml        VARCHAR2(5 Char) NOT NULL '
              || '   ,produces_json       VARCHAR2(5 Char) NOT NULL '
              || '   ,produces_xml        VARCHAR2(5 Char) NOT NULL '
              || '   ,info_desc_updated   DATE '
              || '   ,info_desc_author    VARCHAR2(30 Char) '
              || '   ,info_desc_notes     VARCHAR2(255 Char) '
              || '   ,versionid           VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_head '
              || 'ADD CONSTRAINT dz_swagger_head_pk '
              || 'PRIMARY KEY(versionid,header_id) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_head '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_head_c01 '
              || '    CHECK (schemes_https IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c02 '
              || '    CHECK (consumes_json IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c03 '
              || '    CHECK (consumes_xml IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c04 '
              || '    CHECK (produces_json IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c05 '
              || '    CHECK (produces_xml IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c06 '
              || '    CHECK (header_id = TRIM(header_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c07 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Build PARM table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_parm('
              || '    swagger_parm_id     VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_parm        VARCHAR2(255 Char) NOT NULL '
              || '   ,parm_description    VARCHAR2(4000 Char) '
              || '   ,parm_type           VARCHAR2(255 Char) '
              || '   ,parm_default_string VARCHAR2(255 Char) '
              || '   ,parm_default_number NUMBER '
              || '   ,parm_required       VARCHAR2(5 Char) NOT NULL '
              || '   ,parm_undocumented   VARCHAR2(5 Char) NOT NULL '
              || '   ,param_sort          INTEGER NOT NULL '
              || '   ,parm_desc_updated   DATE '
              || '   ,parm_desc_author    VARCHAR2(30 Char) '
              || '   ,parm_desc_notes     VARCHAR2(255 Char) '
              || '   ,versionid           VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_parm '
              || 'ADD CONSTRAINT dz_swagger_parm_pk '
              || 'PRIMARY KEY(versionid,swagger_parm_id) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_parm '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_parm_c01 '
              || '    CHECK (parm_required IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_parm_c02 '
              || '    CHECK (parm_undocumented IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_parm_c03 '
              || '    CHECK (swagger_parm_id = TRIM(swagger_parm_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_parm_c04 '
              || '    CHECK (swagger_parm = TRIM(swagger_parm)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_parm_c05 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_parm_c06 '
              || '    CHECK (parm_type IN (''number'',''string'')) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Build PARM ENUM table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_parm_enum('
              || '    swagger_parm_id    VARCHAR2(255 Char) NOT NULL '
              || '   ,enum_value_string  VARCHAR2(255 Char) '
              || '   ,enum_value_number  NUMBER '
              || '   ,enum_value_order   INTEGER NOT NULL '
              || '   ,versionid            VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_parm_enum '
              || 'ADD CONSTRAINT dz_swagger_parm_enum_pk '
              || 'PRIMARY KEY(versionid,swagger_parm_id,enum_value_order) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_parm_enum '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_parm_enum_c01 '
              || '    CHECK (swagger_parm_id = TRIM(swagger_parm_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_parm_enum_c02 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 90
      -- Build PATH table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_path('
              || '    path_group_id       VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_path        VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_http_method VARCHAR2(255 Char) NOT NULL '
              || '   ,path_summary        VARCHAR2(4000 Char) '
              || '   ,path_description    VARCHAR2(4000 Char) '
              || '   ,path_order          INTEGER NOT NULL '
              || '   ,object_owner        VARCHAR2(30 Char) '
              || '   ,object_name         VARCHAR2(30 Char) '
              || '   ,procedure_name      VARCHAR2(30 Char) '
              || '   ,object_overload     INTEGER '
              || '   ,path_desc_updated   DATE '
              || '   ,path_desc_author    VARCHAR2(30 Char) '
              || '   ,path_desc_notes     VARCHAR2(255 Char) '
              || '   ,versionid           VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path '
              || 'ADD CONSTRAINT dz_swagger_path_pk '
              || 'PRIMARY KEY(versionid,path_group_id,swagger_path,swagger_http_method) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_path_c01 '
              || '    CHECK (swagger_http_method IN (''get'',''post'',''get/post'',''put'',''delete'',''patch'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_c02 '
              || '    CHECK (path_group_id = TRIM(path_group_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_c03 '
              || '    CHECK (swagger_path = TRIM(swagger_path)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_c04 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 100
      -- Build PATH PARM table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_path_parm('
              || '    swagger_path        VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_http_method VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_parm_id     VARCHAR2(255 Char) NOT NULL '
              || '   ,path_param_sort     NUMBER NOT NULL '
              || '   ,versionid            VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path_parm '
              || 'ADD CONSTRAINT dz_swagger_path_parm_pk '
              || 'PRIMARY KEY(versionid,swagger_path,swagger_http_method,swagger_parm_id) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path_parm '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_path_parm_c01 '
              || '    CHECK (swagger_http_method IN (''get'',''post'',''get/post'',''put'',''delete'',''patch'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_parm_c02 '
              || '    CHECK (swagger_path = TRIM(swagger_path)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_parm_c03 '
              || '    CHECK (swagger_parm_id = TRIM(swagger_parm_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_parm_c04 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Build PATH RESP table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_path_resp('
              || '    swagger_path          VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_http_method   VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_response      VARCHAR2(255 Char) NOT NULL '
              || '   ,response_schema_def   VARCHAR2(255 Char) NOT NULL '
              || '   ,response_schema_type  VARCHAR2(255 Char) NOT NULL '
              || '   ,response_description  VARCHAR2(4000 Char) '
              || '   ,response_desc_updated DATE '
              || '   ,response_desc_author  VARCHAR2(30 Char) '
              || '   ,response_desc_notes   VARCHAR2(255 Char) '
              || '   ,versionid             VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path_resp '
              || 'ADD CONSTRAINT dz_swagger_path_resp_pk '
              || 'PRIMARY KEY(versionid,swagger_path,swagger_http_method) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path_resp '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_path_resp_c01 '
              || '    CHECK (swagger_http_method IN (''get'',''post'',''get/post'',''put'',''delete'',''patch'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_resp_c02 '
              || '    CHECK (swagger_path = TRIM(swagger_path)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_resp_c03 '
              || '    CHECK (response_schema_def = TRIM(response_schema_def)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_resp_c04 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 120
      -- Build PATH TAGS table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_path_tags('
              || '    swagger_path         VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_http_method  VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_tag          VARCHAR2(255 Char) NOT NULL '
              || '   ,versionid            VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path_tags '
              || 'ADD CONSTRAINT dz_swagger_path_tags_pk '
              || 'PRIMARY KEY(versionid,swagger_path,swagger_http_method,swagger_tag) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path_tags '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_path_tags_c01 '
              || '    CHECK (swagger_http_method IN (''get'',''post'',''get/post'',''put'',''delete'',''patch'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_tags_c02 '
              || '    CHECK (swagger_path = TRIM(swagger_path)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_tags_c03 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 130
      -- Build CONDENSE table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_condense('
              || '    condense_key         VARCHAR2(255 Char) NOT NULL '
              || '   ,condense_value       VARCHAR2(255 Char) NOT NULL '
              || '   ,versionid            VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_condense '
              || 'ADD ( '
              || '    CONSTRAINT dz_swagger_condense_pk '
              || '    PRIMARY KEY(versionid,condense_key,condense_value) ';
              
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || '    USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      str_sql := str_sql 
              || '   ,CONSTRAINT dz_swagger_condense_u01 '
              || '    UNIQUE(versionid,condense_value) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || '    USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
       
      str_sql := str_sql || ') ';
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_condense '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_condense_c01 '
              || '    CHECK (condense_key = TRIM(condense_key)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_condense_c02 '
              || '    CHECK (condense_value = TRIM(condense_value)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_condense_c03 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
   END create_storage_tables;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION dz_swagger_table_list
   RETURN MDSYS.SDO_STRING2_ARRAY
   AS
   
   BEGIN
   
      RETURN MDSYS.SDO_STRING2_ARRAY(
          'DZ_SWAGGER_CONDENSE'
         ,'DZ_SWAGGER_DEF'
         ,'DZ_SWAGGER_DEF_ATTR'
         ,'DZ_SWAGGER_PROPERTIES'
         ,'DZ_SWAGGER_HEAD'
         ,'DZ_SWAGGER_PARM'
         ,'DZ_SWAGGER_PARM_ENUM'
         ,'DZ_SWAGGER_PATH'
         ,'DZ_SWAGGER_PATH_PARM'
         ,'DZ_SWAGGER_PATH_RESP'
         ,'DZ_SWAGGER_PATH_TAGS'
         ,'DZ_SWAGGER_VERS'
      );
   
   END dz_swagger_table_list;

END dz_swagger_setup;
/

--
--*************************--
PROMPT DZ_SWAGGER_SETUP.sql;

DECLARE
   int_count NUMBER;
   
BEGIN

   SELECT
   COUNT(*)
   INTO int_count
   FROM
   user_tables a
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

--
--*************************--
PROMPT DZ_SWAGGER_UTIL.pks;

CREATE OR REPLACE PACKAGE dz_swagger_util
AUTHID CURRENT_USER
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_guid
   RETURN VARCHAR2;
  
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION yaml_text(
       p_input        IN  VARCHAR2 
      ,p_pretty_print IN  NUMBER DEFAULT 0
   ) RETURN VARCHAR2;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION yaml_text(
       p_input        IN  NUMBER 
      ,p_pretty_print IN  NUMBER DEFAULT 0
   ) RETURN VARCHAR2;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION yaml_text(
       p_input        IN  BOOLEAN
      ,p_pretty_print IN  NUMBER DEFAULT 0
   ) RETURN VARCHAR2;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION dzcondense(
       p_versionid    IN  VARCHAR2
      ,p_input        IN  VARCHAR2
   ) RETURN VARCHAR2 DETERMINISTIC;
 
 END dz_swagger_util;
/

GRANT EXECUTE ON dz_swagger_util TO public;

--
--*************************--
PROMPT DZ_SWAGGER_UTIL.pkb;

CREATE OR REPLACE PACKAGE BODY dz_swagger_util
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_guid
   RETURN VARCHAR2
   AS
      str_sysguid VARCHAR2(40 Char);
      
   BEGIN
   
      str_sysguid := UPPER(RAWTOHEX(SYS_GUID()));
      
      RETURN '{' 
         || SUBSTR(str_sysguid,1,8)  || '-'
         || SUBSTR(str_sysguid,9,4)  || '-'
         || SUBSTR(str_sysguid,13,4) || '-'
         || SUBSTR(str_sysguid,17,4) || '-'
         || SUBSTR(str_sysguid,21,12)|| '}';
   
   END get_guid;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION yaml_text(
       p_input        IN  VARCHAR2 
      ,p_pretty_print IN  NUMBER DEFAULT 0
   ) RETURN VARCHAR2
   AS
      str_output  VARCHAR2(32000 Char) := p_input;
      str_format  VARCHAR2(4000 Char);
      ary_strings MDSYS.SDO_STRING2_ARRAY;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10 
      -- Determine what format to use
      --------------------------------------------------------------------------
      IF INSTR(p_input,CHR(10)) > 0
      OR INSTR(p_input,CHR(13)) > 0
      THEN
         str_format := 'multiline';
         
      ELSIF REGEXP_LIKE(p_input,'\:|\?|\]|\[|\"|\''|\&|\%|\$')
      THEN
         str_format := 'double';
         
      ELSIF REGEXP_LIKE(p_input,'^[-[:digit:],.]+$')
      OR LOWER(p_input) IN ('true','false')      
      THEN
         str_format := 'single';
         
      ELSE
         str_format := 'bare';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20 
      -- Process bare strings
      --------------------------------------------------------------------------
      IF str_format = 'bare'
      THEN
         RETURN str_output;
         
      --------------------------------------------------------------------------
      -- Step 30 
      -- Process single quoted strings
      --------------------------------------------------------------------------
      ELSIF str_format = 'single'
      THEN
         str_output := REGEXP_REPLACE(str_output,'''','''''');
         
         RETURN '''' || str_output || '''';
         
      --------------------------------------------------------------------------
      -- Step 40 
      -- Process double quoted strings
      --------------------------------------------------------------------------
      ELSIF str_format = 'double'
      THEN
         str_output := REGEXP_REPLACE(str_output,CHR(13),'');
         
         str_output := REGEXP_REPLACE(str_output,'"','\"');
         
         RETURN '"' || str_output || '"';
      
      --------------------------------------------------------------------------
      -- Step 50 
      -- Process bar indented strings
      --------------------------------------------------------------------------
      ELSIF str_format = 'multiline'
      THEN
         str_output := REGEXP_REPLACE(str_output,CHR(13),'');
         
         ary_strings := dz_json_util.gz_split(
             str_output
            ,CHR(10)
         );
         
         str_output := dz_json_util.pretty_str(
             '|-'
            ,0
            ,'  '
         );
         
         FOR i IN 1 .. ary_strings.COUNT
         LOOP
            IF i < ary_strings.COUNT
            THEN
               str_output := str_output || dz_json_util.pretty_str(
                   ary_strings(i)
                  ,p_pretty_print + 1
                  ,'  '
               );
               
            ELSE
               str_output := str_output || dz_json_util.pretty_str(
                   ary_strings(i)
                  ,p_pretty_print + 1
                  ,'  '
                  ,NULL
               );

            END IF;
         
         END LOOP;
         
         RETURN str_output;
         
      ELSE
         RAISE_APPLICATION_ERROR(-20001,'err');
      
      END IF;

      
   END yaml_text;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION yaml_text(
       p_input        IN  NUMBER 
      ,p_pretty_print IN  NUMBER DEFAULT 0
   ) RETURN VARCHAR2
   AS
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10 
      -- Simple override
      --------------------------------------------------------------------------
      RETURN TO_CHAR(p_input);

      
   END yaml_text;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION yaml_text(
       p_input        IN  BOOLEAN 
      ,p_pretty_print IN  NUMBER DEFAULT 0
   ) RETURN VARCHAR2
   AS
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10 
      -- Simple override
      --------------------------------------------------------------------------
      IF p_input
      THEN
         RETURN 'true';
         
      ELSE
         RETURN 'false';
         
      END IF;

   END yaml_text;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION dzcondense(
       p_versionid    IN  VARCHAR2
      ,p_input        IN  VARCHAR2
   ) RETURN VARCHAR2 DETERMINISTIC
   AS
      str_output VARCHAR2(4000) := p_input;
      ary_keys   MDSYS.SDO_STRING2_ARRAY;
      ary_values MDSYS.SDO_STRING2_ARRAY;
      boo_check  BOOLEAN := FALSE;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Pull condense universe from source table
      --------------------------------------------------------------------------
      SELECT
       a.condense_key
      ,a.condense_value
      BULK COLLECT INTO
       ary_keys
      ,ary_values
      FROM
      dz_swagger_condense a
      WHERE
      a.versionid = p_versionid
      ORDER BY
      LENGTH(a.condense_key) DESC;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Loop through results looking for replacement candidates
      --------------------------------------------------------------------------
      FOR i IN 1 .. ary_keys.COUNT
      LOOP
         IF REGEXP_INSTR(p_input,ary_keys(i)) > 0
         THEN
            str_output := REGEXP_REPLACE(
                p_input
               ,ary_keys(i)
               ,ary_values(i)
            );
            
            boo_check := TRUE;
         
         END IF;
         
         IF boo_check
         THEN
            EXIT;
            
         END IF;
      
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Remove final underscore if found
      --------------------------------------------------------------------------
      IF SUBSTR(str_output,-1) = '_'
      THEN
         str_output := SUBSTR(str_output,1,LENGTH(str_output) - 1);
         
      END IF;
      
      RETURN str_output;
      
   END dzcondense;

END dz_swagger_util;
/

--
--*************************--
PROMPT DZ_SWAGGER_XML.tps;

CREATE OR REPLACE TYPE dz_swagger_xml FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    xml_name            VARCHAR2(255 Char)
   ,xml_namespace       VARCHAR2(2000 Char)
   ,xml_prefix          VARCHAR2(255 Char)
   ,xml_attribute       VARCHAR2(5 Char)
   ,xml_wrapped         VARCHAR2(5 Char)
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_xml
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_xml(
       p_xml_name            IN  VARCHAR2 DEFAULT NULL
      ,p_xml_namespace       IN  VARCHAR2 DEFAULT NULL
      ,p_xml_prefix          IN  VARCHAR2 DEFAULT NULL
      ,p_xml_attribute       IN  VARCHAR2 DEFAULT NULL
      ,p_xml_wrapped         IN  VARCHAR2 DEFAULT NULL
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print         IN  NUMBER   DEFAULT NULL
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print         IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_xml TO public;

--
--*************************--
PROMPT DZ_SWAGGER_XML.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_xml
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_xml
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_xml;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_xml(
       p_xml_name            IN  VARCHAR2 DEFAULT NULL
      ,p_xml_namespace       IN  VARCHAR2 DEFAULT NULL
      ,p_xml_prefix          IN  VARCHAR2 DEFAULT NULL
      ,p_xml_attribute       IN  VARCHAR2 DEFAULT NULL
      ,p_xml_wrapped         IN  VARCHAR2 DEFAULT NULL
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.xml_name         := p_xml_name;
      self.xml_namespace    := p_xml_namespace;
      self.xml_prefix       := p_xml_prefix;
      self.xml_attribute    := p_xml_attribute;
      self.xml_wrapped      := p_xml_wrapped;
      
      RETURN; 
      
   END dz_swagger_xml;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty('{',NULL);
         str_pad := '';
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         str_pad := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add optional name
      --------------------------------------------------------------------------
      IF self.xml_name IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'name'
               ,self.xml_name
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         str_pad := ',';
         
      END IF;
         
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional namespace
      --------------------------------------------------------------------------
      IF self.xml_namespace IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'namespace'
               ,self.xml_namespace
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         str_pad := ',';

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional prefix
      --------------------------------------------------------------------------
      IF self.xml_prefix IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'prefix'
               ,self.xml_prefix
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         str_pad := ',';

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Add optional attribute
      --------------------------------------------------------------------------
      IF self.xml_attribute = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'attribute'
               ,TRUE
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         str_pad := ',';

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional wrapped
      --------------------------------------------------------------------------
      IF self.xml_wrapped = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'wrapped'
               ,TRUE
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         str_pad := ',';

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      num_pretty_print  NUMBER := p_pretty_print;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the optional name
      --------------------------------------------------------------------------
      IF self.xml_name IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'name: ' || dz_swagger_util.yaml_text(
                self.xml_name
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the optional namespace
      --------------------------------------------------------------------------
      IF self.xml_namespace IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'namespace: ' || dz_swagger_util.yaml_text(
                self.xml_namespace
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Write the optional prefix
      --------------------------------------------------------------------------
      IF self.xml_prefix IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'prefix: ' || dz_swagger_util.yaml_text(
                self.xml_prefix
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Write the optional attribute boolean
      --------------------------------------------------------------------------
      IF self.xml_attribute = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'attribute: ' || dz_swagger_util.yaml_text(
                TRUE
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Write the optional wrapped boolean
      --------------------------------------------------------------------------
      IF self.xml_wrapped = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'wrapped: ' || dz_swagger_util.yaml_text(
                TRUE
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Cough it out without final line feed
      --------------------------------------------------------------------------
      RETURN REGEXP_REPLACE(
          clb_output
         ,'\n$'
         ,''
      );
      
   END toYAML;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_ARGUMENT.tps;

CREATE OR REPLACE TYPE dz_swagger_argument FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    object_owner        VARCHAR2(30 Char)
   ,object_name	      VARCHAR2(30 Char)
   ,procedure_name      VARCHAR2(30 Char)
   ,argument_name       VARCHAR2(30 Char)
   ,data_type           VARCHAR2(30 Char)
   ,position            INTEGER
   ,overload            INTEGER
   ,dummy               INTEGER

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_argument
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_argument(
       p_object_owner         IN  VARCHAR2
      ,p_object_name          IN  VARCHAR2
      ,p_procedure_name       IN  VARCHAR2
      ,p_argument_name        IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
      ,p_overload             IN  INTEGER
   ) RETURN SELF AS RESULT

);
/

GRANT EXECUTE ON dz_swagger_argument TO public;

--
--*************************--
PROMPT DZ_SWAGGER_ARGUMENT.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_argument
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_argument
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_argument;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_argument(
       p_object_owner         IN  VARCHAR2
      ,p_object_name          IN  VARCHAR2
      ,p_procedure_name       IN  VARCHAR2
      ,p_argument_name        IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
      ,p_overload             IN  INTEGER
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.object_owner         := p_object_owner;
      self.object_name          := p_object_name;
      self.procedure_name       := p_procedure_name;
      self.argument_name        := p_argument_name;
      self.data_type            := p_data_type;
      self.position             := p_position;
      self.overload             := p_overload;

      RETURN; 
      
   END dz_swagger_argument;

END;
/

--
--*************************--
PROMPT DZ_SWAGGER_ARGUMENT_LIST.tps;

CREATE OR REPLACE TYPE dz_swagger_argument_list FORCE                                       
AS 
TABLE OF dz_swagger_argument;
/

GRANT EXECUTE ON dz_swagger_argument_list TO public;

--
--*************************--
PROMPT DZ_SWAGGER_PROPERTY_TYP.tps;

CREATE OR REPLACE TYPE dz_swagger_property_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid            VARCHAR2(40 Char)
   ,property_id          VARCHAR2(255 Char)
   ,property             VARCHAR2(255 Char)
   ,property_type	       VARCHAR2(255 Char)
   ,property_title       VARCHAR2(255 Char)
   ,property_format      VARCHAR2(255 Char)
   ,property_allow_null  VARCHAR2(5 Char)
   ,property_exp_string  VARCHAR2(255 Char)
   ,property_exp_number  NUMBER
   ,property_description VARCHAR2(4000 Char)
   ,property_target      VARCHAR2(255 Char)
   ,property_required    VARCHAR2(5 Char)
   ,xml_name             VARCHAR2(255 Char)
   ,xml_namespace        VARCHAR2(2000 Char)
   ,xml_prefix           VARCHAR2(255 Char)
   ,xml_attribute        VARCHAR2(5 Char)
   ,xml_wrapped          VARCHAR2(5 Char)
   ,xml_array_name       VARCHAR2(255 Char)
   ,dummy                INTEGER
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_property_typ
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_property_typ(
       p_property_id          IN  VARCHAR2
      ,p_property             IN  VARCHAR2
      ,p_property_type	      IN  VARCHAR2
      ,p_property_title       IN  VARCHAR2
      ,p_property_format      IN  VARCHAR2
      ,p_property_allow_null  IN  VARCHAR2
      ,p_property_exp_string  IN  VARCHAR2
      ,p_property_exp_number  IN  NUMBER
      ,p_property_description IN  VARCHAR2
      ,p_property_target      IN  VARCHAR2
      ,p_property_required    IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_xml_attribute        IN  VARCHAR2
      ,p_xml_wrapped          IN  VARCHAR2
      ,p_xml_array_name       IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
       p_pretty_print      IN  NUMBER   DEFAULT NULL
      ,p_jsonschema        IN  VARCHAR2 DEFAULT 'FALSE' 
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_property_typ TO PUBLIC;

--
--*************************--
PROMPT DZ_SWAGGER_PROPERTY_TYP.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_property_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_property_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_property_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_property_typ(
       p_property_id          IN  VARCHAR2
      ,p_property             IN  VARCHAR2
      ,p_property_type	      IN  VARCHAR2
      ,p_property_title       IN  VARCHAR2
      ,p_property_format      IN  VARCHAR2
      ,p_property_allow_null  IN  VARCHAR2
      ,p_property_exp_string  IN  VARCHAR2
      ,p_property_exp_number  IN  NUMBER
      ,p_property_description IN  VARCHAR2
      ,p_property_target      IN  VARCHAR2
      ,p_property_required    IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_xml_attribute        IN  VARCHAR2
      ,p_xml_wrapped          IN  VARCHAR2
      ,p_xml_array_name       IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.property_id          := TRIM(p_property_id);
      self.property             := TRIM(p_property);
      self.property_type        := TRIM(p_property_type);
      self.property_title       := TRIM(p_property_title);
      self.property_format      := TRIM(p_property_format);
      self.property_allow_null  := TRIM(p_property_allow_null);
      self.property_exp_string  := TRIM(p_property_exp_string);
      self.property_exp_number  := p_property_exp_number;
      self.property_description := TRIM(p_property_description);
      self.property_target      := TRIM(p_property_target);
      self.property_required    := TRIM(p_property_required);
      self.xml_name             := TRIM(p_xml_name);
      self.xml_namespace        := TRIM(p_xml_namespace);
      self.xml_prefix           := TRIM(p_xml_prefix);
      self.xml_attribute        := TRIM(p_xml_attribute);
      self.xml_wrapped          := TRIM(p_xml_wrapped);
      self.xml_array_name       := TRIM(p_xml_array_name);
      self.versionid            := p_versionid;
      
      RETURN; 
      
   END dz_swagger_property_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
      ,p_jsonschema       IN  VARCHAR2 DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      str_jsonschema   VARCHAR2(4000 Char) := UPPER(p_jsonschema);
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_pad2         VARCHAR2(1 Char);
      ary_types        MDSYS.SDO_STRING2_ARRAY;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      IF str_jsonschema IS NULL
      OR str_jsonschema NOT IN ('TRUE','FALSE')
      THEN
         str_jsonschema := 'FALSE';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.property) || ':{'
            ,NULL
         );
         str_pad  := '';
         str_pad2 := '';
         
      ELSE
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.property) || ': {'
            ,-1
         );
         str_pad  := ' ';
         str_pad2 := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add base attributes
      --------------------------------------------------------------------------
      IF self.property_type = 'reference'
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                '$ref'
               ,'#/definitions/' || dz_swagger_util.dzcondense(
                  self.versionid 
                 ,self.property_target
                )
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         str_pad := ',';
         
      ELSE
         IF self.property_allow_null = 'TRUE'
         AND str_jsonschema = 'TRUE'
         THEN
            ary_types := MDSYS.SDO_STRING2_ARRAY();
            ary_types.EXTEND(2);
            ary_types(1) := self.property_type;
            ary_types(2) := 'null';
            
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'type'
                  ,ary_types
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );
            str_pad := ',';
            
         ELSE   
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'type'
                  ,self.property_type
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );
            str_pad := ',';
            
         END IF;
         
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional format 
      --------------------------------------------------------------------------
         IF self.property_format IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'format'
                  ,self.property_format
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional title 
      --------------------------------------------------------------------------
         IF self.property_title IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'title'
                  ,self.property_title
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Add optional example 
      --------------------------------------------------------------------------
         IF  str_jsonschema = 'FALSE'
         AND self.property_exp_string IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'example'
                  ,self.property_exp_string
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );

         ELSIF str_jsonschema = 'FALSE'
         AND   self.property_exp_number IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'example'
                  ,self.property_exp_number
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );
            
         END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional description
      --------------------------------------------------------------------------
         IF self.property_description IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'description'
                  ,self.property_description
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add optional array item
      --------------------------------------------------------------------------
         IF self.property_type = 'array' 
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.fastname('items',num_pretty_print) || '{'
               ,num_pretty_print + 1
            );
            
            IF LOWER(self.property_target) IN ('string','number','integer','boolean')
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                  str_pad2 || dz_json_main.value2json(
                      'type'
                     ,LOWER(self.property_target)
                     ,num_pretty_print + 2
                  )
                  ,num_pretty_print + 2
               );
               str_pad2 := ',';
                  
               IF self.xml_array_name IS NOT NULL
               AND str_jsonschema = 'FALSE'
               THEN
                  clb_output := clb_output || dz_json_util.pretty(
                      str_pad2 || dz_json_main.formatted2json(
                         'xml'
                        ,dz_swagger_xml(
                           p_xml_name => self.xml_array_name
                         ).toJSON(num_pretty_print + 2)
                        ,num_pretty_print + 2
                      )
                     ,num_pretty_print + 2
                  );
                  str_pad2 := ',';
                  
               END IF;

            ELSE
               clb_output := clb_output || dz_json_util.pretty(
                  str_pad2 || dz_json_main.value2json(
                      '$ref'
                     ,'#/definitions/' || dz_swagger_util.dzcondense(
                         self.versionid
                        ,self.property_target
                      )
                     ,num_pretty_print + 2
                  )
                  ,num_pretty_print + 2
               );
               str_pad2 := ',';
               
            END IF;
            
            clb_output := clb_output || dz_json_util.pretty(
                '}'
               ,num_pretty_print + 1
            );

         END IF;
         
      --------------------------------------------------------------------------
      -- Step 90 
      -- Add optional xml tag items
      --------------------------------------------------------------------------
         IF str_jsonschema = 'FALSE'
         THEN   
            IF self.xml_name      IS NOT NULL
            OR self.xml_namespace IS NOT NULL
            OR self.xml_prefix    IS NOT NULL
            OR self.xml_attribute = 'TRUE'
            OR self.xml_wrapped   = 'TRUE'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad2 || dz_json_main.formatted2json(
                      'xml'
                     ,dz_swagger_xml(
                         p_xml_name      => self.xml_name
                        ,p_xml_namespace => self.xml_namespace
                        ,p_xml_prefix    => self.xml_prefix
                        ,p_xml_attribute => self.xml_attribute
                        ,p_xml_wrapped   => self.xml_wrapped
                      ).toJSON(
                        p_pretty_print => num_pretty_print + 1
                      )
                     ,num_pretty_print + 1
                   )
                  ,num_pretty_print + 1
               );
               
            END IF;
            
         END IF;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      num_pretty_print  NUMBER := p_pretty_print;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml name to description
      --------------------------------------------------------------------------
      IF self.property_type = 'reference' 
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             '"$ref": "#/definitions/' || dz_swagger_util.dzcondense(
                 self.versionid
                ,self.property_target
             ) || '" '
            ,num_pretty_print + 1
            ,'  '
         );
         
      ELSE       
         clb_output := clb_output || dz_json_util.pretty_str(
             'type: ' || self.property_type
            ,num_pretty_print + 1
            ,'  '
         );
         
         IF self.property_format IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'format: ' || self.property_format
               ,num_pretty_print + 1
               ,'  '
            );

         END IF;
         
         IF self.property_title IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'title: ' || dz_swagger_util.yaml_text(
                   self.property_title
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
               ,'  '
            );

         END IF;
         
         -----------------------------------------------------------------------
         IF self.property_exp_string IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'example: ' || dz_swagger_util.yaml_text(
                   self.property_exp_string
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
               ,'  '
            );

         ELSIF self.property_exp_number IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'example: ' || dz_swagger_util.yaml_text(
                   self.property_exp_number
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
               ,'  '
            );
            
         END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional description
      --------------------------------------------------------------------------
         IF self.property_description IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'description: ' || dz_swagger_util.yaml_text(
                   self.property_description
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
               ,'  '
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add optional array item
      --------------------------------------------------------------------------
         IF self.property_type = 'array' 
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'items: '
               ,num_pretty_print + 1
               ,'  '
            );

            IF LOWER(self.property_target) IN ('string','number','integer','boolean')
            THEN
               clb_output := clb_output || dz_json_util.pretty_str(
                   'type: ' || LOWER(self.property_target) || ' '
                  ,num_pretty_print + 2
                  ,'  '
               );
               
               IF self.xml_array_name IS NOT NULL
               THEN
                  clb_output := clb_output || dz_json_util.pretty_str(
                      'xml: '
                     ,num_pretty_print + 2
                     ,'  '
                  ) || dz_swagger_xml(
                     p_xml_name => self.xml_array_name
                  ).toYAML(
                     num_pretty_print + 3
                  );
               
               END IF;
            
            ELSE
               clb_output := clb_output || dz_json_util.pretty_str(
                   '"$ref": "#/definitions/' || dz_swagger_util.dzcondense(
                       self.versionid
                      ,self.property_target
                   ) || '" '
                  ,num_pretty_print + 2
                  ,'  '
               );
            
            END IF;
         
         END IF;
         
      --------------------------------------------------------------------------
      -- Step 90 
      -- Add optional xml tag items
      --------------------------------------------------------------------------   
         IF self.xml_name      IS NOT NULL
         OR self.xml_namespace IS NOT NULL
         OR self.xml_prefix    IS NOT NULL
         OR self.xml_attribute = 'TRUE'
         OR self.xml_wrapped   = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'xml: '
               ,num_pretty_print + 1
               ,'  '
            ) || dz_swagger_xml(
                p_xml_name      => self.xml_name
               ,p_xml_namespace => self.xml_namespace
               ,p_xml_prefix    => self.xml_prefix
               ,p_xml_attribute => self.xml_attribute
               ,p_xml_wrapped   => self.xml_wrapped
            ).toYAML(
               num_pretty_print + 2
            );
         
         END IF;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_PROPERTY_LIST.tps;

CREATE OR REPLACE TYPE dz_swagger_property_list FORCE                                       
AS 
TABLE OF dz_swagger_property_typ;
/

GRANT EXECUTE ON dz_swagger_property_list TO public;

--
--*************************--
PROMPT DZ_SWAGGER_INFO_CONTACT.tps;

CREATE OR REPLACE TYPE dz_swagger_info_contact FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    contact_name        VARCHAR2(255 Char)
   ,contact_url         VARCHAR2(255 Char)
   ,contact_email       VARCHAR2(255 Char)
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info_contact 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info_contact(
       p_contact_name     IN  VARCHAR2
      ,p_contact_url      IN  VARCHAR2
      ,p_contact_email    IN  VARCHAR2
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION isNULL
    RETURN VARCHAR2
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print      IN  NUMBER   DEFAULT NULL
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_info_contact TO public;

--
--*************************--
PROMPT DZ_SWAGGER_INFO_CONTACT.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_info_contact
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info_contact
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_info_contact;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info_contact(
       p_contact_name     IN  VARCHAR2
      ,p_contact_url      IN  VARCHAR2
      ,p_contact_email    IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.contact_name      := p_contact_name;
      self.contact_url       := p_contact_url;
      self.contact_email     := p_contact_email;
      
      RETURN; 
      
   END dz_swagger_info_contact;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION isNULL
   RETURN VARCHAR2
   AS
   BEGIN
   
      IF self.contact_name IS NOT NULL
      THEN
         RETURN 'FALSE';
         
      ELSIF self.contact_url IS NOT NULL
      THEN
         RETURN 'FALSE';
      
      ELSIF self.contact_email IS NOT NULL
      THEN
         RETURN 'FALSE';
      
      ELSE
         RETURN 'TRUE';
         
      END IF;
   
   END isNULL;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty('{',NULL);
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add name element
      --------------------------------------------------------------------------
      str_pad := ' ';
      
      IF self.contact_name IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'name'
               ,self.contact_name
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         
         str_pad := ',';
         
      END IF;
         
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional url 
      --------------------------------------------------------------------------
      IF self.contact_url IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'url'
               ,self.contact_url
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         
         str_pad := ',';

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional email 
      --------------------------------------------------------------------------
      IF self.contact_email IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'email'
               ,self.contact_email
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         
         str_pad := ',';

      END IF;
 
      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      num_pretty_print  NUMBER := p_pretty_print;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml contact name
      --------------------------------------------------------------------------
      IF self.contact_name IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'name: ' || dz_swagger_util.yaml_text(
                self.contact_name
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the optional contact url
      --------------------------------------------------------------------------
      IF self.contact_url IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'url: ' || dz_swagger_util.yaml_text(
                self.contact_url
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the optional contact_email
      --------------------------------------------------------------------------
      IF self.contact_email IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'email: ' || dz_swagger_util.yaml_text(
                self.contact_email
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out without final line feed
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_INFO_LICENSE.tps;

CREATE OR REPLACE TYPE dz_swagger_info_license FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    license_name        VARCHAR2(255 Char)
   ,license_url         VARCHAR2(255 Char)
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info_license
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info_license(
       p_license_name     IN  VARCHAR2
      ,p_license_url      IN  VARCHAR2
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION isNULL
    RETURN VARCHAR2
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print      IN  NUMBER   DEFAULT NULL
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_info_license TO public;

--
--*************************--
PROMPT DZ_SWAGGER_INFO_LICENSE.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_info_license
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info_license
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_info_license;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info_license(
       p_license_name     IN  VARCHAR2
      ,p_license_url      IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.license_name      := p_license_name;
      self.license_url       := p_license_url;
      
      RETURN; 
      
   END dz_swagger_info_license;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION isNULL
   RETURN VARCHAR2
   AS
   BEGIN
   
      IF self.license_name IS NOT NULL
      THEN
         RETURN 'FALSE';
         
      ELSE
         RETURN 'TRUE';
         
      END IF;
   
   END isNULL;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty('{',NULL);
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add name element
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          ' ' || dz_json_main.value2json(
             'name'
            ,self.license_name
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
         
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional url 
      --------------------------------------------------------------------------
      IF self.license_url IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'url'
               ,self.license_url
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );

      END IF;
 
      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      num_pretty_print  NUMBER := p_pretty_print;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml license name
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'name: ' || dz_swagger_util.yaml_text(
             self.license_name
            ,num_pretty_print
         )
         ,num_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the optional license url
      --------------------------------------------------------------------------
      IF self.license_url IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'url: ' || dz_swagger_util.yaml_text(
                self.license_url
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out without final line feed
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_INFO.tps;

CREATE OR REPLACE TYPE dz_swagger_info FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    info_title          VARCHAR2(255 Char)
   ,info_description    VARCHAR2(4000 Char)
   ,info_termsofservice VARCHAR2(255 Char)
   ,info_contact        dz_swagger_info_contact
   ,info_license        dz_swagger_info_license
   ,info_version        VARCHAR2(255 Char)
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info(
       p_info_title          IN  VARCHAR2
      ,p_info_description    IN  VARCHAR2
      ,p_info_termsofservice IN  VARCHAR2
      ,p_info_contact        IN  dz_swagger_info_contact
      ,p_info_license        IN  dz_swagger_info_license
      ,p_info_version        IN  VARCHAR2
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION isNULL
    RETURN VARCHAR2
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print         IN  NUMBER   DEFAULT NULL
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print         IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_info TO public;

--
--*************************--
PROMPT DZ_SWAGGER_INFO.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_info
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_info;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info(
       p_info_title          IN  VARCHAR2
      ,p_info_description    IN  VARCHAR2
      ,p_info_termsofservice IN  VARCHAR2
      ,p_info_contact        IN  dz_swagger_info_contact
      ,p_info_license        IN  dz_swagger_info_license
      ,p_info_version        IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.info_title          := p_info_title;
      self.info_description    := p_info_description;
      self.info_termsofservice := p_info_termsofservice;
      self.info_contact        := p_info_contact;
      self.info_license        := p_info_license;
      self.info_version        := p_info_version;
      
      RETURN; 
      
   END dz_swagger_info;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION isNULL
   RETURN VARCHAR2
   AS
   BEGIN
   
      IF self.info_title IS NOT NULL
      THEN
         RETURN 'FALSE';
         
      ELSE
         RETURN 'TRUE';
         
      END IF;
   
   END isNULL;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty('{',NULL);
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add name element
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          ' ' || dz_json_main.value2json(
             'title'
            ,self.info_title
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
         
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional description
      --------------------------------------------------------------------------
      IF self.info_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'description'
               ,self.info_description
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional termsOfService
      --------------------------------------------------------------------------
      IF self.info_termsOfService IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'termsOfService'
               ,self.info_termsOfService
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Add optional contact object
      --------------------------------------------------------------------------
      IF self.info_contact.isNULL() = 'FALSE'
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.formatted2json(
                'contact'
               ,self.info_contact.toJSON(num_pretty_print + 1)
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional license object
      --------------------------------------------------------------------------
      IF self.info_license.isNULL() = 'FALSE'
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.formatted2json(
                'license'
               ,self.info_license.toJSON(num_pretty_print + 1)
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add optional version
      --------------------------------------------------------------------------
      IF self.info_version IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'version'
               ,self.info_version
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );

      END IF;
 
      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      num_pretty_print  NUMBER := p_pretty_print;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the info title
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'title: ' || dz_swagger_util.yaml_text(
             self.info_title
            ,num_pretty_print
         )
         ,num_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the optional info description
      --------------------------------------------------------------------------
      IF self.info_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'description: ' || dz_swagger_util.yaml_text(
                self.info_description
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Write the optional info termsOfService
      --------------------------------------------------------------------------
      IF self.info_termsOfService IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'termsOfService: ' || dz_swagger_util.yaml_text(
                self.info_termsOfService
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Write the optional info contact object
      --------------------------------------------------------------------------
      IF self.info_contact.isNULL() = 'FALSE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'contact: ' 
            ,num_pretty_print
            ,'  '
         ) || self.info_contact.toYAML(
            num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Write the optional info license object
      --------------------------------------------------------------------------
      IF self.info_license.isNULL() = 'FALSE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'license: '
            ,num_pretty_print
            ,'  '
         ) || self.info_license.toYAML(
            num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Write the optional info version
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'version: ' || dz_swagger_util.yaml_text(
             self.info_version
            ,num_pretty_print
         )
         ,num_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out without final line feed
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_DEFINITION_TYP.tps;

CREATE OR REPLACE TYPE dz_swagger_definition_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid            VARCHAR2(40 Char)
   ,definition           VARCHAR2(255 Char)
   ,definition_type      VARCHAR2(255 Char)
   ,definition_desc      VARCHAR2(4000 Char)
   ,inline_def           VARCHAR2(5 Char)
   ,swagger_properties   dz_swagger_property_list
   ,xml_name             VARCHAR2(255 Char)
   ,xml_namespace        VARCHAR2(2000 Char)
   ,xml_prefix           VARCHAR2(255 Char)
   ,dummy                INTEGER

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_definition_typ
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_definition_typ(
       p_definition           IN  VARCHAR2
      ,p_definition_type      IN  VARCHAR2
      ,p_definition_desc      IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_definition_typ(
       p_definition           IN  VARCHAR2
      ,p_definition_type      IN  VARCHAR2
      ,p_definition_desc      IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
      ,p_swagger_properties   IN  dz_swagger_property_list
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
       p_pretty_print      IN  NUMBER   DEFAULT NULL
      ,p_jsonschema        IN  VARCHAR2 DEFAULT 'FALSE'       
   ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_definition_typ TO public;

--
--*************************--
PROMPT DZ_SWAGGER_DEFINITION_TYP.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_definition_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_definition_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_definition_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_definition_typ(
       p_definition           IN  VARCHAR2
      ,p_definition_type      IN  VARCHAR2
      ,p_definition_desc      IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.definition           := p_definition;
      self.definition_type      := p_definition_type;
      self.definition_desc      := p_definition_desc;
      self.inline_def           := p_inline_def;
      self.xml_name             := TRIM(p_xml_name);
      self.xml_namespace        := TRIM(p_xml_namespace);
      self.xml_prefix           := TRIM(p_xml_prefix);
      self.versionid            := p_versionid;
      
      RETURN; 
      
   END dz_swagger_definition_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_definition_typ(
       p_definition           IN  VARCHAR2
      ,p_definition_type      IN  VARCHAR2
      ,p_definition_desc      IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
      ,p_swagger_properties   IN  dz_swagger_property_list
   ) RETURN SELF AS RESULT 
   AS
   BEGIN 
   
      self.definition           := p_definition;
      self.definition_type      := p_definition_type;
      self.definition_desc      := p_definition_desc;
      self.inline_def           := p_inline_def;
      self.xml_name             := TRIM(p_xml_name);
      self.xml_namespace        := TRIM(p_xml_namespace);
      self.xml_prefix           := TRIM(p_xml_prefix);
      self.versionid            := p_versionid;
      self.swagger_properties   := p_swagger_properties;
      
      RETURN; 
      
   END dz_swagger_definition_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print      IN  NUMBER   DEFAULT NULL
      ,p_jsonschema        IN  VARCHAR2 DEFAULT 'FALSE' 
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      str_jsonschema   VARCHAR2(4000 Char) := UPPER(p_jsonschema);
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_pad1         VARCHAR2(1 Char);
      str_pad2         VARCHAR2(1 Char);
      ary_required     MDSYS.SDO_STRING2_ARRAY;
      int_counter      PLS_INTEGER;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      IF str_jsonschema IS NULL
      OR str_jsonschema NOT IN ('TRUE','FALSE')
      THEN
         str_jsonschema := 'FALSE';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty('{',NULL);
         str_pad  := '';
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         str_pad  := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add base attributes
      --------------------------------------------------------------------------
      str_pad1 := str_pad;
      
      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'type'
            ,self.definition_type
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      str_pad1 := ',';
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional description object
      --------------------------------------------------------------------------
      IF self.definition_desc IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                'description'
               ,self.definition_desc
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional xml object
      --------------------------------------------------------------------------
      IF str_jsonschema = 'FALSE'
      THEN
         IF self.xml_name      IS NOT NULL
         OR self.xml_namespace IS NOT NULL
         OR self.xml_prefix    IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad1 || dz_json_main.formatted2json(
                   'xml'
                  ,dz_swagger_xml(
                      p_xml_name      => self.xml_name
                     ,p_xml_namespace => self.xml_namespace
                     ,p_xml_prefix    => self.xml_prefix
                   ).toJSON(
                     p_pretty_print => num_pretty_print + 1
                   )
                  ,num_pretty_print + 1
                )
               ,num_pretty_print + 1
            );
            str_pad1 := ',';
            
         END IF;
         
      END IF;
  
      --------------------------------------------------------------------------
      -- Step 60
      -- Add properties
      --------------------------------------------------------------------------
      IF self.swagger_properties IS NULL
      OR self.swagger_properties.COUNT = 0
      THEN
         NULL;

      ELSE
         str_pad2 := str_pad;
         
         ary_required := MDSYS.SDO_STRING2_ARRAY();
         int_counter := 1;
      
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('properties',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         
         FOR i IN 1 .. self.swagger_properties.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad2 || self.swagger_properties(i).toJSON(
                   p_pretty_print => num_pretty_print + 2
                  ,p_jsonschema   => str_jsonschema
                )
               ,num_pretty_print + 2
            );
            str_pad2 := ',';
            
            IF self.swagger_properties(i).property_required = 'TRUE'
            THEN
               ary_required.EXTEND();
               ary_required(int_counter) := self.swagger_properties(i).property;
               int_counter := int_counter + 1;

            END IF;
            
         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1
         );
         str_pad1 := ',';
         
      --------------------------------------------------------------------------
      -- Step 70
      -- Add properties required array
      --------------------------------------------------------------------------
         IF ary_required IS NOT NULL
         AND ary_required.COUNT > 0
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad1 || dz_json_main.value2json(
                   'required'
                  ,ary_required
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );
            str_pad1 := ',';
         
         END IF;
      
      END IF;
        
      --------------------------------------------------------------------------
      -- Step 80
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 90
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      num_pretty_print  NUMBER := p_pretty_print;
      boo_required      BOOLEAN;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Do the type element
      --------------------------------------------------------------------------
      clb_output := dz_json_util.pretty_str(
          'type: ' || self.definition_type
         ,num_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add optional description object
      --------------------------------------------------------------------------
      IF self.definition_desc IS NOT NULL
      THEN
         clb_output := dz_json_util.pretty_str(
             'description: ' || self.definition_desc
            ,num_pretty_print
            ,'  '
         );
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional xml object
      --------------------------------------------------------------------------
      IF self.xml_name      IS NOT NULL
      OR self.xml_namespace IS NOT NULL
      OR self.xml_prefix    IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'xml: '
            ,num_pretty_print
            ,'  '
         ) || dz_swagger_xml(
             p_xml_name      => self.xml_name
            ,p_xml_namespace => self.xml_namespace
            ,p_xml_prefix    => self.xml_prefix
         ).toYAML(
            num_pretty_print + 1
         );
      
      END IF; 
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add the properties
      --------------------------------------------------------------------------
      boo_required := FALSE;
      
      IF self.swagger_properties IS NULL
      OR self.swagger_properties.COUNT = 0
      THEN
         NULL;

      ELSE      
         clb_output := clb_output || dz_json_util.pretty_str(
             'properties: '
            ,num_pretty_print
            ,'  '
         );
          
         FOR i IN 1 .. self.swagger_properties.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty_str(
                self.swagger_properties(i).property || ': '
               ,num_pretty_print + 1
               ,'  '
            ) || self.swagger_properties(i).toYAML(num_pretty_print + 1);
            
            IF self.swagger_properties(i).property_required = 'TRUE'
            THEN
               boo_required := TRUE;
               
            END IF;
    
         END LOOP;
         
      --------------------------------------------------------------------------
      -- Step 70
      -- Add properties required array
      --------------------------------------------------------------------------
         IF boo_required
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'required: '
               ,num_pretty_print
               ,'  '
            );
            
            FOR i IN 1 .. self.swagger_properties.COUNT
            LOOP
               IF self.swagger_properties(i).property_required = 'TRUE'
               THEN
                  clb_output := clb_output || dz_json_util.pretty_str(
                      '- ' || self.swagger_properties(i).property
                     ,num_pretty_print
                     ,'  '
                  );
                  
               END IF;
               
            END LOOP;
         
         END IF;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/--
--*************************--
PROMPT DZ_SWAGGER_DEFINITION_LIST.tps;

CREATE OR REPLACE TYPE dz_swagger_definition_list FORCE                                       
AS 
TABLE OF dz_swagger_definition_typ;
/

GRANT EXECUTE ON dz_swagger_definition_list TO public;

--
--*************************--
PROMPT DZ_SWAGGER_JSONSCH_TYP.tps;

CREATE OR REPLACE TYPE dz_swagger_jsonsch_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid             VARCHAR2(40 Char)
   ,swagger_path          VARCHAR2(255 Char)
   ,swagger_http_method   VARCHAR2(255 Char)
   ,swagger_response      VARCHAR2(255 Char)
   ,response_schema_obj   dz_swagger_definition_typ
   ,swagger_defs          dz_swagger_definition_list
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_jsonsch_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_jsonsch_typ(
       p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_swagger_response     IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
       p_pretty_print      IN  NUMBER   DEFAULT NULL
    ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_jsonsch_typ TO public;

--
--*************************--
PROMPT DZ_SWAGGER_JSONSCH_TYP.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_jsonsch_typ
AS 
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_jsonsch_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_jsonsch_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_jsonsch_typ(
       p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_swagger_response     IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
   AS    
      def_pool   dz_swagger_definition_list;
         
   BEGIN
   
      self.versionid           := p_versionid;
      self.swagger_path        := p_swagger_path;
      self.swagger_http_method := LOWER(p_swagger_http_method);
      self.swagger_response    := p_swagger_response;
      
      --------------------------------------------------------------------------
      --
      --------------------------------------------------------------------------
      SELECT dz_swagger_definition_typ(
          p_definition          => a.definition
         ,p_definition_type     => a.definition_type
         ,p_definition_desc     => a.definition_desc
         ,p_inline_def          => NULL
         ,p_xml_name            => a.xml_name
         ,p_xml_namespace       => a.xml_namespace
         ,p_xml_prefix          => a.xml_prefix
         ,p_versionid           => a.versionid
      )
      BULK COLLECT INTO def_pool
      FROM (
         SELECT
          aa.definition
         ,aa.definition_type
         ,aa.definition_desc
         ,aa.xml_name
         ,aa.xml_namespace
         ,aa.xml_prefix
         ,aa.versionid
         FROM (
            SELECT
             aaa.definition
            ,aaa.definition_type
            ,aaa.definition_desc
            ,aaa.xml_name
            ,aaa.xml_namespace
            ,aaa.xml_prefix
            ,aaa.versionid
            FROM
            dz_swagger_definition aaa
            WHERE
            (aaa.versionid,aaa.definition,aaa.definition_type) IN (
               SELECT 
                bbbb.versionid
               ,bbbb.response_schema_def
               ,bbbb.response_schema_type
               FROM 
               dz_swagger_path_resp bbbb
               WHERE
                   bbbb.versionid           = self.versionid
               AND bbbb.swagger_path        = self.swagger_path
               AND bbbb.swagger_http_method = self.swagger_http_method
               AND bbbb.swagger_response    = self.swagger_response
            )
            OR (aaa.versionid,aaa.definition) IN (
               SELECT
                ddd.versionid
               ,ddd.property_target 
               FROM 
               dz_swagger_def_prop ccc
               JOIN
               dz_swagger_property ddd
               ON
               ccc.property_id = ddd.property_id
               WHERE 
                   ccc.versionid = self.versionid
               AND ddd.versionid = self.versionid
               AND ddd.property_target IS NOT NULL
               START WITH (ccc.versionid,ccc.definition,ccc.definition_type) IN (
                  SELECT 
                   cccc.versionid
                  ,cccc.response_schema_def
                  ,cccc.response_schema_type
                  FROM 
                  dz_swagger_path_resp cccc
                  WHERE
                      cccc.versionid           = self.versionid
                  AND cccc.swagger_path        = self.swagger_path
                  AND cccc.swagger_http_method = self.swagger_http_method
                  AND cccc.swagger_response    = self.swagger_response
                  AND cccc.response_schema_type = 'object'
               )
               CONNECT BY PRIOR 
               ddd.property_target = ccc.definition
               GROUP BY 
                ddd.versionid
               ,ddd.property_target
            )
         ) aa      
      ) a;
      
      --------------------------------------------------------------------------
      -- Step 120
      -- Add the properties to the definitions
      --------------------------------------------------------------------------
      FOR i IN 1 .. def_pool.COUNT
      LOOP   
         SELECT dz_swagger_property_typ(
             p_property_id          => a.property_id
            ,p_property             => b.property
            ,p_property_type	      => b.property_type
            ,p_property_format      => b.property_format
            ,p_property_allow_null  => b.property_allow_null
            ,p_property_title       => b.property_title
            ,p_property_exp_string  => b.property_exp_string
            ,p_property_exp_number  => b.property_exp_number
            ,p_property_description => b.property_description
            ,p_property_target      => b.property_target
            ,p_property_required    => a.property_required
            ,p_xml_name             => b.xml_name
            ,p_xml_namespace        => b.xml_namespace
            ,p_xml_prefix           => b.xml_prefix 
            ,p_xml_attribute        => b.xml_attribute 
            ,p_xml_wrapped          => b.xml_wrapped
            ,p_xml_array_name       => b.xml_array_name
            ,p_versionid            => a.versionid
         )
         BULK COLLECT INTO def_pool(i).swagger_properties
         FROM
         dz_swagger_def_prop a
         LEFT JOIN
         dz_swagger_property b
         ON
         a.property_id = b.property_id
         WHERE
             a.versionid       = def_pool(i).versionid
         AND b.versionid       = def_pool(i).versionid
         AND a.definition      = def_pool(i).definition
         AND a.definition_type = def_pool(i).definition_type
         ORDER BY
         a.property_order;
         
         IF  def_pool(i).swagger_properties IS NOT NULL
         AND def_pool(i).swagger_properties.COUNT = 1
         AND def_pool(i).swagger_properties(1).property_type = 'reference'
         THEN
            def_pool(i).inline_def := 'TRUE';
         
         ELSE
            def_pool(i).inline_def := 'FALSE';
            
         END IF;
         
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 130
      -- Load the response subobjects
      --------------------------------------------------------------------------
      BEGIN
         SELECT dz_swagger_definition_typ(
             p_definition          => a.definition
            ,p_definition_type     => a.definition_type
            ,p_definition_desc     => a.definition_desc
            ,p_inline_def          => a.inline_def
            ,p_xml_name            => a.xml_name
            ,p_xml_namespace       => a.xml_namespace
            ,p_xml_prefix          => a.xml_prefix
            ,p_versionid           => a.versionid
            ,p_swagger_properties  => a.swagger_properties
         )
         INTO 
         self.response_schema_obj
         FROM
         TABLE(def_pool) a
         WHERE
         (a.versionid,a.definition,a.definition_type) IN (
            SELECT 
             b.versionid
            ,b.response_schema_def
            ,b.response_schema_type 
            FROM
            dz_swagger_path_resp b
            WHERE
                b.versionid           = self.versionid
            AND b.swagger_path        = self.swagger_path
            AND b.swagger_http_method = self.swagger_http_method
            AND b.swagger_response    = self.swagger_response
         );

      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
            
      END;
        
      --------------------------------------------------------------------------
      -- Step 140
      -- Filter the defs down to only objects
      --------------------------------------------------------------------------
      SELECT
      dz_swagger_definition_typ(
          p_definition          => a.definition
         ,p_definition_type     => a.definition_type
         ,p_definition_desc     => a.definition_desc
         ,p_inline_def          => a.inline_def
         ,p_xml_name            => a.xml_name
         ,p_xml_namespace       => a.xml_namespace
         ,p_xml_prefix          => a.xml_prefix
         ,p_versionid           => a.versionid
         ,p_swagger_properties  => a.swagger_properties
      )
      BULK COLLECT INTO self.swagger_defs
      FROM 
      TABLE(def_pool) a
      WHERE
      a.definition_type IN ('object');
      
      RETURN;
      
   EXCEPTION
   
      WHEN NO_DATA_FOUND
      THEN
         RETURN;
         
      WHEN OTHERS
      THEN
         RAISE;
   
   END dz_swagger_jsonsch_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print      IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print  NUMBER := p_pretty_print;
      clb_output        CLOB;
      str_pad           VARCHAR2(1 Char);
      str_pad1          VARCHAR2(1 Char);
      str_pad2          VARCHAR2(1 Char);
      ary_required      MDSYS.SDO_STRING2_ARRAY;
      int_counter       PLS_INTEGER;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      IF self.response_schema_obj IS NULL
      THEN
         RETURN NULL;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Add the left bracket
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output := dz_json_util.pretty('{',NULL);
         str_pad := '';
         
      ELSE
         clb_output := dz_json_util.pretty('{',-1);
         str_pad := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- 
      --------------------------------------------------------------------------
      str_pad1 := str_pad;
      
      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             '$schema'
            ,'http://json-schema.org/draft-04/schema#'
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      str_pad1 := ',';
      
      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'title'
            ,self.swagger_path || ' ' 
             || self.swagger_http_method || ' ' 
             || self.swagger_response || ' - ' 
             || self.versionid
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      str_pad1 := ',';

      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'type'
            ,'object'
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      str_pad1 := ',';
      
      --------------------------------------------------------------------------
      -- Step 80
      -- 
      --------------------------------------------------------------------------
      IF self.response_schema_obj.swagger_properties IS NOT NULL
      AND self.response_schema_obj.swagger_properties.COUNT > 0
      THEN
         str_pad2 := str_pad;
            
         ary_required := MDSYS.SDO_STRING2_ARRAY();
         int_counter := 1;
      
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('properties',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         
         FOR i IN 1 .. self.response_schema_obj.swagger_properties.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad2 || self.response_schema_obj.swagger_properties(i).toJSON(
                   p_pretty_print => num_pretty_print + 2
                  ,p_jsonschema   => 'TRUE'
                )
               ,num_pretty_print + 2
            );
            str_pad2 := ',';
            
            IF self.response_schema_obj.swagger_properties(i).property_required = 'TRUE'
            THEN
               ary_required.EXTEND();
               ary_required(int_counter) := self.response_schema_obj.swagger_properties(i).property;
               int_counter := int_counter + 1;

            END IF;
            
         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1
         );
         str_pad1 := ',';
            
         --------------------------------------------------------------------------
         -- Step 70
         -- 
         --------------------------------------------------------------------------
         IF ary_required IS NOT NULL
         AND ary_required.COUNT > 0
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad1 || dz_json_main.value2json(
                   'required'
                  ,ary_required
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );
            str_pad1 := ',';
         
         END IF;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 90
      -- Add the defs
      --------------------------------------------------------------------------
      IF self.swagger_defs IS NULL
      OR self.swagger_defs.COUNT = 0
      THEN
         NULL;

      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('definitions',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         str_pad1 := ',';
         
         str_pad2 := str_pad;
         FOR i IN 1 .. self.swagger_defs.COUNT
         LOOP
            IF self.swagger_defs(i).inline_def = 'FALSE'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad2 || '"' || dz_swagger_util.dzcondense(
                      self.swagger_defs(i).versionid
                     ,self.swagger_defs(i).definition
                   ) || '": ' || self.swagger_defs(i).toJSON(
                      p_pretty_print => num_pretty_print + 2
                     ,p_jsonschema   => 'TRUE'
                   )
                  ,num_pretty_print + 2
               );
               str_pad2 := ',';
               
            END IF;

         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      --
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'additionalProperties'
            ,FALSE
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      str_pad1 := ',';
   
      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_PARM_TYP.tps;

CREATE OR REPLACE TYPE dz_swagger_parm_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid           VARCHAR2(40 Char)
   ,swagger_parm_id     VARCHAR2(255 Char)
   ,swagger_parm	      VARCHAR2(255 Char)
   ,parm_description    VARCHAR2(4000 Char)
   ,parm_type           VARCHAR2(255 Char)
   ,parm_default_string VARCHAR2(255 Char)
   ,parm_default_number NUMBER
   ,parm_required       VARCHAR2(255 Char)
   ,parm_undocumented   VARCHAR2(5 Char)
   ,swagger_path        VARCHAR2(255 Char)
   ,swagger_http_method VARCHAR2(255 Char)
   ,path_param_sort     NUMBER
   ,param_sort          NUMBER
   ,inline_parm         VARCHAR2(5 Char)
   ,parm_enums_string   MDSYS.SDO_STRING2_ARRAY
   ,parm_enums_number   MDSYS.SDO_NUMBER_ARRAY

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_parm_typ
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_parm_typ(
       p_swagger_parm_id      IN  VARCHAR2
      ,p_swagger_parm         IN  VARCHAR2
      ,p_parm_description     IN  VARCHAR2
      ,p_parm_type            IN  VARCHAR2
      ,p_parm_default_string  IN  VARCHAR2
      ,p_parm_default_number  IN  NUMBER
      ,p_parm_required        IN  VARCHAR2
      ,p_parm_undocumented    IN  VARCHAR2
      ,p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_path_param_sort      IN  NUMBER
      ,p_param_sort           IN  NUMBER
      ,p_inline_parm          IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print      IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
       p_pretty_print     IN  NUMBER   DEFAULT 0
      ,p_array_marker     IN  VARCHAR  DEFAULT 'FALSE'
   ) RETURN CLOB
   
);
/

GRANT EXECUTE ON dz_swagger_parm_typ TO public;

--
--*************************--
PROMPT DZ_SWAGGER_PARM_TYP.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_parm_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_parm_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_parm_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_parm_typ(
       p_swagger_parm_id      IN  VARCHAR2
      ,p_swagger_parm         IN  VARCHAR2
      ,p_parm_description     IN  VARCHAR2
      ,p_parm_type            IN  VARCHAR2
      ,p_parm_default_string  IN  VARCHAR2
      ,p_parm_default_number  IN  NUMBER
      ,p_parm_required        IN  VARCHAR2
      ,p_parm_undocumented    IN  VARCHAR2
      ,p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_path_param_sort      IN  NUMBER
      ,p_param_sort           IN  NUMBER
      ,p_inline_parm          IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.swagger_parm_id      := p_swagger_parm_id;
      self.swagger_parm         := p_swagger_parm;
      self.parm_description     := p_parm_description;
      self.parm_type            := p_parm_type;
      self.parm_default_string  := p_parm_default_string;
      self.parm_default_number  := p_parm_default_number;
      self.parm_required        := p_parm_required;
      self.parm_undocumented    := p_parm_undocumented;
      self.swagger_path         := p_swagger_path;
      self.swagger_http_method  := p_swagger_http_method;
      self.path_param_sort      := p_path_param_sort;
      self.param_sort           := p_param_sort;
      self.inline_parm          := p_inline_parm;
      self.versionid            := p_versionid;
      
      SELECT
       a.enum_value_string
      ,a.enum_value_number
      BULK COLLECT INTO 
       self.parm_enums_string
      ,self.parm_enums_number
      FROM
      dz_swagger_parm_enum a
      WHERE
          a.versionid = p_versionid
      AND a.swagger_parm_id = p_swagger_parm_id
      ORDER BY
      a.enum_value_order;
      
      IF self.parm_enums_string.COUNT > 0
      AND self.parm_enums_string(1) IS NULL
      THEN
         self.parm_enums_string := MDSYS.SDO_STRING2_ARRAY();
         
      END IF;
      
      RETURN; 
      
   END dz_swagger_parm_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_enums        VARCHAR2(32000 Char);
      str_temp         VARCHAR2(4000 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty('{',NULL);
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add base attributes
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          ' ' || dz_json_main.value2json(
             'name'
            ,self.swagger_parm
            ,num_pretty_print + 1
         )
         ,p_pretty_print + 1
      ) || dz_json_util.pretty(
          ',' || dz_json_main.value2json(
              'in'
             ,'query'
             ,num_pretty_print + 1
          )
         ,p_pretty_print + 1
      );
      
      IF self.parm_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                 'description'
                ,self.parm_description
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional enum array
      --------------------------------------------------------------------------
      IF self.parm_enums_string IS NOT NULL
      AND self.parm_enums_string.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                 'enum'
                ,self.parm_enums_string
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
      
      ELSIF self.parm_enums_number IS NOT NULL
      AND self.parm_enums_number.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                 'enum'
                ,self.parm_enums_number
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional default value
      --------------------------------------------------------------------------
      IF self.parm_default_string IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'default'
               ,self.parm_default_string
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
      
      ELSIF self.parm_default_number IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'default'
               ,self.parm_default_number
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add base attributes
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          ',' || dz_json_main.value2json(
             'type'
            ,self.parm_type
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add base attributes
      --------------------------------------------------------------------------
      IF LOWER(self.parm_required) = 'true'
      THEN
         str_temp := 'true';
         
      ELSE
         str_temp := 'false';
      
      END IF;
      
      clb_output := clb_output || dz_json_util.pretty(
          ',' || dz_json_main.formatted2json(
              'required'
             ,str_temp
             ,num_pretty_print + 1
          )
         ,num_pretty_print + 1
      );

      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   ----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
       p_pretty_print     IN  NUMBER   DEFAULT 0
      ,p_array_marker     IN  VARCHAR  DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      num_pretty_print  NUMBER := p_pretty_print;
      str_pad           VARCHAR2(2 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      IF p_array_marker = 'TRUE'
      THEN
         str_pad := '- ';
         num_pretty_print := num_pretty_print + 1;
         
      ELSE
         str_pad := NULL;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml name to description
      --------------------------------------------------------------------------
      clb_output := dz_json_util.pretty_str(
          str_pad || 'name: ' || dz_swagger_util.yaml_text(self.swagger_parm,num_pretty_print)
         ,p_pretty_print
         ,'  '
      ) || dz_json_util.pretty_str(
          'in: query'
         ,num_pretty_print
         ,'  '
      );
      
      IF self.parm_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'description: ' || dz_swagger_util.yaml_text(self.parm_description,num_pretty_print)
            ,num_pretty_print
            ,'  '
         );
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the enums if required 
      --------------------------------------------------------------------------
      IF self.parm_enums_string IS NOT NULL
      AND self.parm_enums_string.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'enum: '
            ,num_pretty_print
            ,'  '
         );
         
         FOR i IN 1 .. self.parm_enums_string.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty_str(
                '- ' || dz_swagger_util.yaml_text(self.parm_enums_string(i),num_pretty_print)
               ,num_pretty_print
               ,'  '
            );
         
         END LOOP;
 
      ELSIF self.parm_enums_number IS NOT NULL
      AND self.parm_enums_number.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'enum: '
            ,num_pretty_print
            ,'  '
         );
         
         FOR i IN 1 .. self.parm_enums_number.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                '- ' || dz_json_main.json_format(self.parm_enums_number(i))
               ,num_pretty_print
               ,'  '
            );
         
         END LOOP;
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional default value
      --------------------------------------------------------------------------
      IF self.parm_default_string IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'default: ' || dz_swagger_util.yaml_text(self.parm_default_string,num_pretty_print)
            ,num_pretty_print
            ,'  '
         );
      
      ELSIF self.parm_default_number IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'default: ' || dz_json_main.json_format(self.parm_default_number)
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Finish the type and required elements
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'type: ' || self.parm_type
         ,num_pretty_print
         ,'  '
      );
         
      IF self.parm_required IS NOT NULL
      AND self.parm_required = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'required: true'
            ,num_pretty_print
            ,'  '
         );
      
      ELSE
         clb_output := clb_output || dz_json_util.pretty_str(
             'required: false'
            ,num_pretty_print
            ,'  '
         );
      
      END IF;
         
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_PARM_LIST.tps;

CREATE OR REPLACE TYPE dz_swagger_parm_list FORCE                                       
AS 
TABLE OF dz_swagger_parm_typ;
/

GRANT EXECUTE ON dz_swagger_parm_list TO public;

--
--*************************--
PROMPT DZ_SWAGGER_RESPONSE_TYP.tps;

CREATE OR REPLACE TYPE dz_swagger_response_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid            VARCHAR2(40 Char)
   ,swagger_path         VARCHAR2(255 Char)
   ,swagger_http_method  VARCHAR2(255 Char)
   ,swagger_response     VARCHAR2(255 Char)
   ,response_description VARCHAR2(4000 Char)
   ,response_schema_def  VARCHAR2(255 Char)  
   ,response_schema_type VARCHAR2(255 Char) 
   ,response_schema_obj  dz_swagger_definition_typ    
  
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_response_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_response_typ(
       p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_swagger_response     IN  VARCHAR2
      ,p_response_description IN  VARCHAR2
      ,p_response_schema_def  IN  VARCHAR2
      ,p_response_schema_type IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
        p_pretty_print      IN  NUMBER   DEFAULT NULL
    ) RETURN CLOB

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_response_typ TO public;

--
--*************************--
PROMPT DZ_SWAGGER_RESPONSE_TYP.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_response_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_response_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN;
      
   END dz_swagger_response_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_response_typ(
       p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_swagger_response     IN  VARCHAR2
      ,p_response_description IN  VARCHAR2
      ,p_response_schema_def  IN  VARCHAR2
      ,p_response_schema_type IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.swagger_path         := p_swagger_path;
      self.swagger_http_method  := p_swagger_http_method;
      self.swagger_response     := p_swagger_response;
      self.response_description := p_response_description;
      self.versionid            := p_versionid;
      self.response_schema_def  := p_response_schema_def;
      self.response_schema_type := p_response_schema_type;
      
      RETURN;
          
   END dz_swagger_response_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_schema       VARCHAR2(4000 Char);
      str_pad          VARCHAR2(1 Char);
      str_pad1         VARCHAR2(1 Char);
      str_pad2         VARCHAR2(1 Char);
      str_description  VARCHAR2(4000);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty('{',NULL);
         str_pad  := '';
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         str_pad  := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add base attributes
      --------------------------------------------------------------------------
      str_pad1 := str_pad;
      
      IF self.response_description IS NULL
      THEN
         str_description := 'Results';
         
      ELSE
         str_description := self.response_description;

      END IF;
      
      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'description'
            ,str_description
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      ); 
      str_pad1 := ',';
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Build schema object
      --------------------------------------------------------------------------
      IF  self.response_schema_type = 'object'
      AND self.response_schema_obj IS NOT NULL
      THEN
         IF self.response_schema_obj.inline_def = 'FALSE'
         THEN
            str_pad2 := str_pad;
            
            IF num_pretty_print IS NULL
            THEN
               str_schema := dz_json_util.pretty('{',NULL);
               
            ELSE
               str_schema := dz_json_util.pretty('{',-1);
               
            END IF;
            
            str_schema := str_schema || dz_json_util.pretty(
                str_pad2 || dz_json_main.value2json(
                   '$ref'
                  ,'#/definitions/' || dz_swagger_util.dzcondense(
                      self.versionid
                     ,self.response_schema_obj.definition
                   )
                  ,num_pretty_print + 2
               )
               ,num_pretty_print + 2
            ) || dz_json_util.pretty(
                '}'
               ,num_pretty_print + 1,NULL,NULL
            );
            str_pad2 := ',';
            
            clb_output := clb_output || dz_json_util.pretty(
                str_pad1 || dz_json_main.formatted2json(
                    'schema'
                   ,str_schema
                   ,num_pretty_print + 1
                )
               ,num_pretty_print + 1
            );
            str_pad1 := ',';
            
         ELSIF self.response_schema_obj.inline_def = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty(
               str_pad1 || '"schema": ' || self.response_schema_obj.toJSON(
                  p_pretty_print => num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );   
            str_pad1 := ',';
         
         END IF;
         
      ELSIF self.response_schema_type = 'file'
      THEN
         str_pad2 := str_pad;
         
         IF num_pretty_print IS NULL
         THEN
            str_schema := dz_json_util.pretty('{',NULL);
            
         ELSE
            str_schema := dz_json_util.pretty('{',-1);
            
         END IF;
         
         str_schema := str_schema || dz_json_util.pretty(
             str_pad2 || '"type": "file"'
            ,num_pretty_print + 2
         ) || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1,NULL,NULL
         );
         str_pad2 := ',';
         
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.formatted2json(
                 'schema'
                ,str_schema
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';
            
      END IF;

      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB
   AS
      clb_output       CLOB;
      num_pretty_print NUMBER := p_pretty_print;
      str_description  VARCHAR2(4000);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Do the optional elements
      --------------------------------------------------------------------------
      clb_output := '';
      
      IF self.response_description IS NULL
      THEN
         str_description := 'Results';
         
      ELSE
         str_description := self.response_description;
         
      END IF;
      
      clb_output := clb_output || dz_json_util.pretty(
          'description: ' || dz_swagger_util.yaml_text(
              str_description
             ,num_pretty_print
          )
         ,num_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Do the schema object
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'schema: '
         ,num_pretty_print
         ,'  '
      );
      
      IF  self.response_schema_type = 'object'
      AND self.response_schema_obj IS NOT NULL
      THEN
         IF self.response_schema_obj.inline_def = 'FALSE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                '"$ref": "#/definitions/' || dz_swagger_util.dzcondense(
                   self.versionid
                  ,self.response_schema_obj.definition
                ) || '"'
               ,num_pretty_print + 1
               ,'  '
            );
            
         ELSIF self.response_schema_obj.inline_def = 'TRUE'
         THEN
            clb_output := clb_output || self.response_schema_obj.toYAML(
               p_pretty_print => num_pretty_print + 1
            );
            
         END IF;
            
      ELSIF self.response_schema_type = 'file'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'type: file'
            ,num_pretty_print + 1
            ,'  '
         );
            
      END IF;
          
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_RESPONSE_LIST.tps;

CREATE OR REPLACE TYPE dz_swagger_response_list FORCE                                       
AS 
TABLE OF dz_swagger_response_typ;
/

GRANT EXECUTE ON dz_swagger_response_list TO public;

--
--*************************--
PROMPT DZ_SWAGGER_METHOD_TYP.tps;

CREATE OR REPLACE TYPE dz_swagger_method_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid           VARCHAR2(40 Char)
   ,swagger_path        VARCHAR2(255 Char)
   ,swagger_http_method VARCHAR2(255 Char)
   ,path_summary        VARCHAR2(4000 Char)
   ,path_description    VARCHAR2(4000 Char)
   ,method_path_parms   dz_swagger_parm_list
   ,method_tags         MDSYS.SDO_STRING2_ARRAY
   ,method_responses    dz_swagger_response_list
  
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_method_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_method_typ(
       p_swagger_path        IN  VARCHAR2
      ,p_swagger_http_method IN  VARCHAR2
      ,p_path_summary        IN  VARCHAR2
      ,p_path_description    IN  VARCHAR2
      ,p_versionid           IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print      IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_method_typ TO public;

--
--*************************--
PROMPT DZ_SWAGGER_METHOD_TYP.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_method_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_method_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_method_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_method_typ(
       p_swagger_path        IN  VARCHAR2
      ,p_swagger_http_method IN  VARCHAR2
      ,p_path_summary        IN  VARCHAR2
      ,p_path_description    IN  VARCHAR2
      ,p_versionid           IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.swagger_path        := p_swagger_path;
      self.swagger_http_method := p_swagger_http_method;
      self.path_summary        := p_path_summary;
      self.path_description    := p_path_description;
      self.versionid           := p_versionid;

      RETURN; 
      
   END dz_swagger_method_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_pad1         VARCHAR2(1 Char);
      str_pad2         VARCHAR2(1 Char);
      str_pad3         VARCHAR2(1 Char);
      str_parms        VARCHAR2(32000 Char);
      str_temp         VARCHAR2(32000 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty('{',NULL);
         str_pad  := '';
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         str_pad  := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Add base attributes
      --------------------------------------------------------------------------
      str_pad1 := str_pad;
      
      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'summary'
            ,self.path_summary
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      str_pad1 := ',';
      
      IF self.path_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'description'
                ,self.path_description
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add parms array
      --------------------------------------------------------------------------
      IF self.method_path_parms IS NULL
      OR self.method_path_parms.COUNT = 0
      THEN
         str_parms := 'null';
         
      ELSE
         str_pad2 := str_pad;
         
         IF num_pretty_print IS NULL
         THEN
            str_parms := dz_json_util.pretty('[',NULL);
            
         ELSE
            str_parms := dz_json_util.pretty('[',-1);
            
         END IF;
         
         FOR i IN 1 .. self.method_path_parms.COUNT
         LOOP
         
            IF  self.method_path_parms(i).parm_undocumented = 'FALSE'
            THEN
               IF self.method_path_parms(i).inline_parm = 'TRUE'
               THEN
                  str_temp := self.method_path_parms(i).toJSON(
                     p_pretty_print => num_pretty_print + 2
                  );
                  
               ELSE
                  str_pad3 := str_pad;
                  
                  IF num_pretty_print IS NULL
                  THEN
                     str_temp := dz_json_util.pretty('{',NULL);
                     
                  ELSE
                     str_temp := dz_json_util.pretty('{',-1);
                     
                  END IF;
                  
                  str_temp := str_temp || dz_json_util.pretty(
                     str_pad3 || dz_json_main.value2json(
                         '$ref'
                        ,'#/parameters/' || self.method_path_parms(i).swagger_parm
                        ,num_pretty_print + 3
                     )
                     ,num_pretty_print + 3
                  );
                  str_pad3 := ',';
                  
                  str_temp := str_temp || dz_json_util.pretty(
                      '}'
                     ,num_pretty_print + 2,NULL,NULL
                  );
               
               END IF;
            
               str_parms := str_parms || dz_json_util.pretty(
                   str_pad2 || str_temp
                  ,num_pretty_print + 2
               );
               str_pad2 := ',';
               
            END IF;
         
         END LOOP;
         
         str_parms := str_parms || dz_json_util.pretty(
             ']'
            ,num_pretty_print + 1,NULL,NULL
         );
         
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.formatted2json(
                 'parameters'
                ,str_parms
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';
      
      END IF;

      --------------------------------------------------------------------------
      -- Step 70
      -- Add the optional tags
      --------------------------------------------------------------------------
      IF self.method_tags IS NOT NULL
      AND self.method_tags.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'tags'
                ,self.method_tags
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add responses
      --------------------------------------------------------------------------
      IF self.method_responses IS NULL
      OR self.method_responses.COUNT = 0
      THEN
         NULL;

      ELSE
         str_pad2 := str_pad;
         
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('responses',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         
         FOR i IN 1 .. self.method_responses.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad2 || dz_json_main.json_format(
                  self.method_responses(i).swagger_response
               ) || ': ' || self.method_responses(i).toJSON(
                  p_pretty_print => num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );
            str_pad2 := ',';

         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   ----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      num_pretty_print  NUMBER := p_pretty_print;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Do the optional elements
      --------------------------------------------------------------------------
      clb_output := '';
      IF self.path_summary IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'summary: ' || dz_swagger_util.yaml_text(self.path_summary,num_pretty_print)
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      IF self.path_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'description: ' || dz_swagger_util.yaml_text(self.path_description,num_pretty_print)
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Do the parameter array
      --------------------------------------------------------------------------
      IF  self.method_path_parms IS NOT NULL
      AND self.method_path_parms.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'parameters: '
            ,num_pretty_print
            ,'  '
         );
         
         FOR i IN 1 .. self.method_path_parms.COUNT
         LOOP 
            IF self.method_path_parms(i).parm_undocumented = 'FALSE'
            THEN            
               IF self.method_path_parms(i).inline_parm = 'TRUE'
               THEN
                  clb_output := clb_output || self.method_path_parms(i).toYAML(
                      num_pretty_print
                     ,'TRUE'
                  );
                  
               ELSE
                  clb_output := clb_output || dz_json_util.pretty(
                      '- "$ref": "#/parameters/' || self.method_path_parms(i).swagger_parm || '"'
                     ,num_pretty_print
                     ,'  '
                  );
               
               END IF;
               
            END IF;
         
         END LOOP;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Do the tags array
      --------------------------------------------------------------------------
      IF  self.method_tags IS NOT NULL
      AND self.method_tags.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'tags: '
            ,num_pretty_print
            ,'  '
         );
         
         FOR i IN 1 .. self.method_tags.COUNT
         LOOP 
            clb_output := clb_output || dz_json_util.pretty(
                '- ' || dz_swagger_util.yaml_text(self.method_tags(i),num_pretty_print)
               ,num_pretty_print
               ,'  '
            );
         
         END LOOP;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Do the responses array
      --------------------------------------------------------------------------
      IF  self.method_responses IS NOT NULL
      AND self.method_responses.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'responses: '
            ,num_pretty_print
            ,'  '
         );
         
         FOR i IN 1 .. self.method_responses.COUNT
         LOOP 
            clb_output := clb_output || dz_json_util.pretty(
                '''' || self.method_responses(i).swagger_response || ''': '
               ,num_pretty_print + 1
               ,'  '
            ) || self.method_responses(i).toYAML(
               num_pretty_print + 2
            );
         
         END LOOP;
         
      END IF;
          
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_METHOD_LIST.tps;

CREATE OR REPLACE TYPE dz_swagger_method_list FORCE                                       
AS 
TABLE OF dz_swagger_method_typ;
/

GRANT EXECUTE ON dz_swagger_method_list TO public;

--
--*************************--
PROMPT DZ_SWAGGER_PATH_TYP.tps;

CREATE OR REPLACE TYPE dz_swagger_path_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid         VARCHAR2(40 Char)
   ,swagger_path      VARCHAR2(255 Char)
   ,swagger_methods   dz_swagger_method_list
  
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_path_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_path_typ(
       p_swagger_path        IN VARCHAR2
      ,p_versionid          IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
       p_pretty_print     IN  NUMBER   DEFAULT 0
      ,p_array_marker     IN  VARCHAR  DEFAULT 'FALSE'
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_path_typ TO public;

--
--*************************--
PROMPT DZ_SWAGGER_PATH_TYP.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_path_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_path_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_path_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_path_typ(
       p_swagger_path        IN VARCHAR2
      ,p_versionid          IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.swagger_path := p_swagger_path;
      self.versionid    := p_versionid;
      
      RETURN; 
      
   END dz_swagger_path_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_pad1         VARCHAR2(1 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.swagger_path) || ': {'
            ,NULL
         );
         str_pad := '';
         
      ELSE
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.swagger_path) || ': {'
            ,-1
         );
         str_pad := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add the paths
      --------------------------------------------------------------------------
      str_pad1 := str_pad;
      
      IF self.swagger_methods IS NULL
      OR self.swagger_methods.COUNT = 0
      THEN
         NULL;

      ELSE
         FOR i IN 1 .. self.swagger_methods.COUNT
         LOOP
            IF self.swagger_methods(i).swagger_http_method = 'get/post'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad1 || '"get": ' || self.swagger_methods(i).toJSON(
                     p_pretty_print => num_pretty_print + 1
                  )
                  ,num_pretty_print + 1
               );     
               str_pad1 := ',';
               
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad1 || '"post": ' || self.swagger_methods(i).toJSON(
                      p_pretty_print => num_pretty_print + 1
                  )
                  ,num_pretty_print + 1
               );     
               str_pad1 := ',';
         
            ELSE
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad1 || dz_json_main.json_format(
                     self.swagger_methods(i).swagger_http_method
                  ) || ': ' || self.swagger_methods(i).toJSON(
                     p_pretty_print => num_pretty_print + 1
                  )
                  ,num_pretty_print + 1
               );     
               str_pad1 := ',';
               
            END IF;

         END LOOP;

      END IF;

      --------------------------------------------------------------------------
      -- Step 40
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   ----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
       p_pretty_print     IN  NUMBER   DEFAULT 0
      ,p_array_marker     IN  VARCHAR  DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      clb_output        CLOB := '';
      num_pretty_print  NUMBER := p_pretty_print;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml name to description
      --------------------------------------------------------------------------
      IF self.swagger_methods IS NULL
      OR self.swagger_methods.COUNT = 0
      THEN
         NULL;

      ELSE
         FOR i IN 1 .. self.swagger_methods.COUNT
         LOOP
            IF self.swagger_methods(i).swagger_http_method = 'get/post'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   'get: '
                  ,num_pretty_print
                  ,'  '
               ) || self.swagger_methods(i).toYAML(
                  p_pretty_print => num_pretty_print + 1   
               );
               
               clb_output := clb_output || dz_json_util.pretty(
                   'post: '
                  ,num_pretty_print
                  ,'  '
               ) || self.swagger_methods(i).toYAML(
                  p_pretty_print => num_pretty_print + 1
               );
            
            ELSE
               clb_output := clb_output || dz_json_util.pretty(
                   self.swagger_methods(i).swagger_http_method || ': '
                  ,num_pretty_print
                  ,'  '
               ) || self.swagger_methods(i).toYAML(num_pretty_print + 1);
               
            END IF;
            
         END LOOP;

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;

   END toYAML;
   
END;
/

--
--*************************--
PROMPT DZ_SWAGGER_PATH_LIST.tps;

CREATE OR REPLACE TYPE dz_swagger_path_list FORCE                                       
AS 
TABLE OF dz_swagger_path_typ;
/

GRANT EXECUTE ON dz_swagger_path_list TO public;

--
--*************************--
PROMPT DZ_SWAGGER_TABLE_DEF.tps;

CREATE OR REPLACE TYPE dz_swagger_table_def FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    definition          VARCHAR2(255 Char)
   ,table_owner         VARCHAR2(30 Char)
   ,table_name	         VARCHAR2(30 Char)
   ,column_name         VARCHAR2(30 Char)
   ,json_name           VARCHAR2(255 Char)
   ,column_common       VARCHAR2(30 Char)
   ,data_type           VARCHAR2(30 Char)
   ,json_type           VARCHAR2(30 Char)
   ,position            INTEGER
   ,relative_position   INTEGER
   ,dummy               INTEGER

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_table_def
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_definition           IN  VARCHAR2
      ,p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_json_name            IN  VARCHAR2
      ,p_column_common        IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_json_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
      ,p_relative_position    IN  INTEGER
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_definition           IN  VARCHAR2
      ,p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_json_name            IN  VARCHAR2
      ,p_json_type            IN  VARCHAR2
      ,p_relative_position    IN  INTEGER
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
   ) RETURN SELF AS RESULT

);
/

GRANT EXECUTE ON dz_swagger_table_def TO public;

--
--*************************--
PROMPT DZ_SWAGGER_TABLE_DEF.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_table_def
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_table_def
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_table_def;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_definition           IN  VARCHAR2
      ,p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_json_name            IN  VARCHAR2
      ,p_column_common        IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_json_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
      ,p_relative_position    IN  INTEGER
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.definition           := p_definition;
      self.table_owner          := p_table_owner;
      self.table_name           := p_table_name;
      self.column_name          := p_column_name;
      self.json_name            := p_json_name;
      self.column_common        := p_column_common;
      self.data_type            := p_data_type;
      self.json_type            := p_json_type;
      self.position             := p_position;
      self.relative_position    := p_relative_position;

      RETURN; 
      
   END dz_swagger_table_def;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_definition           IN  VARCHAR2
      ,p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_json_name            IN  VARCHAR2
      ,p_json_type            IN  VARCHAR2
      ,p_relative_position    IN  INTEGER
   ) RETURN SELF AS RESULT
   AS
   BEGIN
   
      self.definition           := p_definition;
      self.table_owner          := p_table_owner;
      self.table_name           := p_table_name;
      self.column_name          := p_column_name;
      self.json_name            := p_json_name;
      self.json_type            := p_json_type;
      self.relative_position    := p_relative_position;
      
      IF self.column_name IS NOT NULL
      THEN
         self.column_common := UPPER(
            REPLACE(self.column_name,'_','')
         );
         
      ELSE
         self.column_common := UPPER(
            REPLACE(self.json_name,'_','')
         );
       
      END IF;
        
      RETURN;
   
   END dz_swagger_table_def;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
   ) RETURN SELF AS RESULT
   AS
   BEGIN
   
      self.table_owner          := p_table_owner;
      self.table_name           := p_table_name;
      self.column_name          := p_column_name;
      self.data_type            := p_data_type;
      self.position             := p_position;
      
      self.column_common := UPPER(
         REPLACE(self.column_name,'_','')
      );
      
      RETURN;
      
   END dz_swagger_table_def;

END;
/

--
--*************************--
PROMPT DZ_SWAGGER_TABLE_DEF_LIST.tps;

CREATE OR REPLACE TYPE dz_swagger_table_def_list FORCE                                       
AS 
TABLE OF dz_swagger_table_def;
/

GRANT EXECUTE ON dz_swagger_table_def_list TO public;

--
--*************************--
PROMPT DZ_SWAGGER_TYP.tps;

CREATE OR REPLACE TYPE dz_swagger_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid           VARCHAR2(40 Char)
   ,path_group_id       VARCHAR2(255 Char)
   ,swagger_info        dz_swagger_info
   ,swagger_host        VARCHAR2(255 Char)
   ,swagger_basepath    VARCHAR2(255 Char)
   ,schemes_https       VARCHAR2(5 Char)
   ,consumes_json       VARCHAR2(5 Char)
   ,consumes_xml        VARCHAR2(5 Char)
   ,produces_json       VARCHAR2(5 Char)
   ,produces_xml        VARCHAR2(5 Char)
   ,swagger_paths       dz_swagger_path_list
   ,swagger_parms       dz_swagger_parm_list
   ,swagger_defs        dz_swagger_definition_list
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_typ(
       p_header_id        IN  VARCHAR2
      ,p_path_group_id    IN  VARCHAR2 DEFAULT NULL
      ,p_versionid        IN  VARCHAR2 DEFAULT NULL
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_typ(
       p_path_group_id       IN  VARCHAR2
      ,p_swagger_info        IN  dz_swagger_info
      ,p_swagger_host        IN  VARCHAR2
      ,p_swagger_basepath    IN  VARCHAR2
      ,p_schemes_https       IN  VARCHAR2
      ,p_consumes_json       IN  VARCHAR2
      ,p_consumes_xml        IN  VARCHAR2
      ,p_produces_json       IN  VARCHAR2
      ,p_produces_xml        IN  VARCHAR2
      ,p_versionid           IN  VARCHAR2
    ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION all_methods
    RETURN dz_swagger_method_list
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION all_responses
    RETURN dz_swagger_response_list
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
       p_pretty_print      IN  NUMBER   DEFAULT NULL
      ,p_host_override_val IN  VARCHAR2 DEFAULT NULL
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_host_override_val IN  VARCHAR2 DEFAULT NULL
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_typ TO public;

--
--*************************--
PROMPT DZ_SWAGGER_TYP.tpb;

CREATE OR REPLACE TYPE BODY dz_swagger_typ
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_typ
   RETURN SELF AS RESULT
   AS
   BEGIN
      RETURN;

   END dz_swagger_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_typ(
       p_header_id        IN  VARCHAR2
      ,p_path_group_id    IN  VARCHAR2 DEFAULT NULL
      ,p_versionid        IN  VARCHAR2 DEFAULT NULL
   ) RETURN SELF AS RESULT
   AS
      str_path_group_id VARCHAR2(4000 Char);
      str_versionid     VARCHAR2(40 Char) := p_versionid;

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      IF p_path_group_id IS NULL
      THEN
         str_path_group_id := p_header_id;

      ELSE
         str_path_group_id := p_path_group_id;

      END IF;

      --------------------------------------------------------------------------
      -- Step 20
      -- Determine the default version if not provided
      --------------------------------------------------------------------------
      IF str_versionid IS NULL
      THEN
         BEGIN
            SELECT
            a.versionid
            INTO str_versionid
            FROM
            dz_swagger_vers a
            WHERE
                a.is_default = 'TRUE'
            AND rownum <= 1;

         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RAISE;

         END;

      END IF;

      --------------------------------------------------------------------------
      -- Step 30
      -- Fetch the header record from dz_swagger_head
      --------------------------------------------------------------------------
      SELECT dz_swagger_typ(
          p_path_group_id       => str_path_group_id
         ,p_swagger_info        => dz_swagger_info(
             p_info_title          => a.info_title
            ,p_info_description    => a.info_description
            ,p_info_termsofservice => a.info_termsofservice
            ,p_info_contact        => dz_swagger_info_contact(
                p_contact_name     => a.info_contact_name
               ,p_contact_url      => a.info_contact_url
               ,p_contact_email    => a.info_contact_email
             )
            ,p_info_license        => dz_swagger_info_license(
                p_license_name     => a.info_license_name
               ,p_license_url      => a.info_license_url
            )
            ,p_info_version        => a.info_version
         )
         ,p_swagger_host        => a.swagger_host
         ,p_swagger_basepath    => a.swagger_basepath
         ,p_schemes_https       => a.schemes_https
         ,p_consumes_json       => a.consumes_json
         ,p_consumes_xml        => a.consumes_xml
         ,p_produces_json       => a.produces_json
         ,p_produces_xml        => a.produces_xml
         ,p_versionid           => a.versionid
      )
      INTO self
      FROM
      dz_swagger_head a
      WHERE
          a.versionid = str_versionid
      AND a.header_id = p_header_id;

      RETURN;

   END dz_swagger_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_typ(
       p_path_group_id       IN  VARCHAR2
      ,p_swagger_info        IN  dz_swagger_info
      ,p_swagger_host        IN  VARCHAR2
      ,p_swagger_basepath    IN  VARCHAR2
      ,p_schemes_https       IN  VARCHAR2
      ,p_consumes_json       IN  VARCHAR2
      ,p_consumes_xml        IN  VARCHAR2
      ,p_produces_json       IN  VARCHAR2
      ,p_produces_xml        IN  VARCHAR2
      ,p_versionid           IN  VARCHAR2
   ) RETURN SELF AS RESULT
   AS
      ary_groups MDSYS.SDO_STRING2_ARRAY;
      parm_pool  dz_swagger_parm_list;
      def_pool   dz_swagger_definition_list;

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------

      --------------------------------------------------------------------------
      -- Step 20
      -- Load the object
      --------------------------------------------------------------------------
      self.path_group_id       := p_path_group_id;
      self.swagger_info        := p_swagger_info;
      self.swagger_host        := p_swagger_host;
      self.swagger_basepath    := p_swagger_basepath;
      self.schemes_https       := p_schemes_https;
      self.consumes_json       := p_consumes_json;
      self.consumes_xml        := p_consumes_xml;
      self.produces_json       := p_produces_json;
      self.produces_xml        := p_produces_xml;
      self.versionid           := p_versionid;

      --------------------------------------------------------------------------
      -- Step 30
      -- Parse the group id
      --------------------------------------------------------------------------
      ary_groups := dz_json_util.gz_split(
          p_str   => p_path_group_id
         ,p_regex => ','
      );

      --------------------------------------------------------------------------
      -- Step 40
      -- Bail if a problem with the groups
      --------------------------------------------------------------------------
      IF ary_groups IS NULL
      AND ary_groups.COUNT = 0
      THEN
         RETURN;

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Pull the list of paths
      --------------------------------------------------------------------------
      SELECT dz_swagger_path_typ(
          p_swagger_path => a.swagger_path
         ,p_versionid    => a.versionid
      )
      BULK COLLECT INTO
      self.swagger_paths
      FROM
      dz_swagger_path a
      WHERE
         a.versionid = self.versionid
      AND (
            ary_groups(1) = 'ALL'
         OR a.path_group_id IN (SELECT * FROM TABLE(ary_groups))
      )
      GROUP BY
       a.versionid
      ,a.swagger_path
      ORDER BY
      MAX(a.path_order);

      IF self.swagger_paths IS NULL
      OR self.swagger_paths.COUNT = 0
      THEN
         RETURN;

      END IF;

      --------------------------------------------------------------------------
      -- Step 60
      -- Load the paths subobjects
      --------------------------------------------------------------------------
      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         SELECT dz_swagger_method_typ(
             p_swagger_path        => a.swagger_path
            ,p_swagger_http_method => a.swagger_http_method
            ,p_path_summary        => a.path_summary
            ,p_path_description    => a.path_description
            ,p_versionid           => a.versionid
         )
         BULK COLLECT INTO
         self.swagger_paths(i).swagger_methods
         FROM (
            SELECT
             aa.versionid
            ,aa.swagger_path
            ,aa.swagger_http_method
            ,aa.path_summary
            ,aa.path_description
            ,ROW_NUMBER() OVER (
               PARTITION BY
                aa.versionid
               ,aa.swagger_path
               ,aa.swagger_http_method
               ORDER BY
                aa.path_order
            ) AS rn
            FROM
            dz_swagger_path aa
            WHERE
                aa.versionid    = self.swagger_paths(i).versionid
            AND aa.swagger_path = self.swagger_paths(i).swagger_path
         ) a
         WHERE
         a.rn = 1;

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 70
      -- Fill the parameter pool
      --------------------------------------------------------------------------
      SELECT dz_swagger_parm_typ(
          p_swagger_parm_id      => a.swagger_parm_id
         ,p_swagger_parm         => a.swagger_parm
         ,p_parm_description     => a.parm_description
         ,p_parm_type            => a.parm_type
         ,p_parm_default_string  => a.parm_default_string
         ,p_parm_default_number  => a.parm_default_number
         ,p_parm_required        => a.parm_required
         ,p_parm_undocumented    => a.parm_undocumented
         ,p_swagger_path         => a.swagger_path
         ,p_swagger_http_method  => a.swagger_http_method
         ,p_path_param_sort      => a.path_param_sort
         ,p_param_sort           => a.param_sort
         ,p_inline_parm          => a.parm_move_inline
         ,p_versionid            => a.versionid
      )
      BULK COLLECT INTO parm_pool
      FROM (
         WITH parms AS (
            SELECT
             bb.swagger_parm_id
            ,bb.swagger_parm
            ,bb.parm_description
            ,bb.parm_type
            ,bb.parm_default_string
            ,bb.parm_default_number
            ,bb.parm_required
            ,bb.parm_undocumented
            ,aa.swagger_path
            ,aa.swagger_http_method
            ,aa.path_param_sort
            ,bb.param_sort
            ,bb.versionid
            FROM
            dz_swagger_path_parm aa
            JOIN
            dz_swagger_parm bb
            ON
            aa.swagger_parm_id = bb.swagger_parm_id
            WHERE
            (aa.versionid,aa.swagger_path,aa.swagger_http_method) IN (
               SELECT
                aaa.versionid
               ,aaa.swagger_path
               ,aaa.swagger_http_method
               FROM
               TABLE(self.all_methods()) aaa
            )
         )
         SELECT
          bb.swagger_parm_id
         ,bb.swagger_parm
         ,bb.parm_description
         ,bb.parm_type
         ,bb.parm_default_string
         ,bb.parm_default_number
         ,bb.parm_required
         ,bb.parm_undocumented
         ,bb.swagger_path
         ,bb.swagger_http_method
         ,bb.path_param_sort
         ,bb.param_sort
         ,CASE WHEN cc.parm_count > 1
          THEN
             'TRUE'
          ELSE
             'FALSE'
          END AS parm_move_inline
         ,bb.versionid
         FROM
         parms bb
         JOIN (
            SELECT
             ccc.swagger_parm
            ,COUNT(*) AS parm_count
            FROM (
               SELECT
                cccc.swagger_parm_id
               ,cccc.swagger_parm
               FROM
               parms cccc
               GROUP BY
                cccc.swagger_parm_id
               ,cccc.swagger_parm
            ) ccc
            GROUP BY
            ccc.swagger_parm
         ) cc
         ON
         bb.swagger_parm = cc.swagger_parm
      ) a;

      --------------------------------------------------------------------------
      -- Step 80
      -- Load the methods subobjects
      --------------------------------------------------------------------------
      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         FOR j IN 1 .. self.swagger_paths(i).swagger_methods.COUNT
         LOOP
            SELECT dz_swagger_parm_typ(
                p_swagger_parm_id      => a.swagger_parm_id
               ,p_swagger_parm         => a.swagger_parm
               ,p_parm_description     => a.parm_description
               ,p_parm_type            => a.parm_type
               ,p_parm_default_string  => a.parm_default_string
               ,p_parm_default_number  => a.parm_default_number
               ,p_parm_required        => a.parm_required
               ,p_parm_undocumented    => a.parm_undocumented
               ,p_swagger_path         => a.swagger_path
               ,p_swagger_http_method  => a.swagger_http_method
               ,p_path_param_sort      => a.path_param_sort
               ,p_param_sort           => a.param_sort
               ,p_inline_parm          => a.inline_parm
               ,p_versionid            => a.versionid
            )
            BULK COLLECT INTO
            self.swagger_paths(i).swagger_methods(j).method_path_parms
            FROM
            TABLE(parm_pool) a
            WHERE
                a.swagger_path        = self.swagger_paths(i).swagger_methods(j).swagger_path
            AND a.swagger_http_method = self.swagger_paths(i).swagger_methods(j).swagger_http_method
            ORDER BY
            a.path_param_sort;

            SELECT
            a.swagger_tag
            BULK COLLECT INTO
            self.swagger_paths(i).swagger_methods(j).method_tags
            FROM
            dz_swagger_path_tags a
            WHERE
                a.versionid           = self.swagger_paths(i).swagger_methods(j).versionid
            AND a.swagger_path        = self.swagger_paths(i).swagger_methods(j).swagger_path
            AND a.swagger_http_method = self.swagger_paths(i).swagger_methods(j).swagger_http_method;

            SELECT dz_swagger_response_typ(
                p_swagger_path         => a.swagger_path
               ,p_swagger_http_method  => a.swagger_http_method
               ,p_swagger_response     => a.swagger_response
               ,p_response_description => a.response_description
               ,p_response_schema_def  => a.response_schema_def
               ,p_response_schema_type => a.response_schema_type
               ,p_versionid            => a.versionid
            )
            BULK COLLECT INTO
            self.swagger_paths(i).swagger_methods(j).method_responses
            FROM
            dz_swagger_path_resp a
            WHERE
                a.versionid           = self.swagger_paths(i).swagger_methods(j).versionid
            AND a.swagger_path        = self.swagger_paths(i).swagger_methods(j).swagger_path
            AND a.swagger_http_method = self.swagger_paths(i).swagger_methods(j).swagger_http_method;

         END LOOP;

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 100
      -- Shrink the pool of parms down to just unique items
      --------------------------------------------------------------------------
      SELECT dz_swagger_parm_typ(
          p_swagger_parm_id      => a.swagger_parm_id
         ,p_swagger_parm         => MAX(a.swagger_parm)
         ,p_parm_description     => MAX(a.parm_description)
         ,p_parm_type            => MAX(a.parm_type)
         ,p_parm_default_string  => MAX(a.parm_default_string)
         ,p_parm_default_number  => MAX(a.parm_default_number)
         ,p_parm_required        => MAX(a.parm_required)
         ,p_parm_undocumented    => MAX(a.parm_undocumented)
         ,p_swagger_path         => NULL
         ,p_swagger_http_method  => NULL
         ,p_path_param_sort      => NULL
         ,p_param_sort           => MAX(a.param_sort)
         ,p_inline_parm          => 'FALSE'
         ,p_versionid            => a.versionid
      )
      BULK COLLECT INTO self.swagger_parms
      FROM
      TABLE(parm_pool) a
      WHERE
      a.inline_parm = 'FALSE'
      GROUP BY
       a.versionid
      ,a.swagger_parm_id
      ORDER BY
      MAX(a.param_sort);

      parm_pool := dz_swagger_parm_list();

      --------------------------------------------------------------------------
      -- Step 110
      -- Get the universe of definitions
      --------------------------------------------------------------------------
      SELECT dz_swagger_definition_typ(
          p_definition          => a.definition
         ,p_definition_type     => a.definition_type
         ,p_definition_desc     => a.definition_desc
         ,p_inline_def          => a.inline_def
         ,p_xml_name            => a.xml_name
         ,p_xml_namespace       => a.xml_namespace
         ,p_xml_prefix          => a.xml_prefix
         ,p_versionid           => a.versionid
      )
      BULK COLLECT INTO def_pool
      FROM (
         SELECT
          aa.definition
         ,aa.definition_type
         ,aa.definition_desc
         ,aa.inline_def
         ,aa.xml_name
         ,aa.xml_namespace
         ,aa.xml_prefix
         ,aa.versionid
         FROM (
            SELECT
             aaa.definition
            ,aaa.definition_type
            ,aaa.definition_desc
            ,'TRUE' AS inline_def
            ,aaa.xml_name
            ,aaa.xml_namespace
            ,aaa.xml_prefix
            ,aaa.versionid
            FROM
            dz_swagger_definition aaa
            WHERE
            (aaa.versionid,aaa.definition,aaa.definition_type) IN (
               SELECT
                bbb.versionid
               ,bbb.response_schema_def
               ,bbb.response_schema_type
               FROM
               TABLE(self.all_responses()) bbb
            )
            UNION ALL SELECT
             aaa.definition
            ,aaa.definition_type
            ,aaa.definition_desc
            ,'FALSE' AS inline_def
            ,aaa.xml_name
            ,aaa.xml_namespace
            ,aaa.xml_prefix
            ,aaa.versionid
            FROM
            dz_swagger_definition aaa
            WHERE
            (aaa.versionid,aaa.definition) IN (
               SELECT
                ddd.versionid
               ,ddd.property_target
               FROM
               dz_swagger_def_prop ccc
               JOIN
               dz_swagger_property ddd
               ON
               ccc.property_id = ddd.property_id
               WHERE
                   ccc.versionid = self.versionid
               AND ddd.versionid = self.versionid
               AND ddd.property_target IS NOT NULL
               START WITH (ccc.versionid,ccc.definition,ccc.definition_type) IN (
                  SELECT
                   cccc.versionid
                  ,cccc.response_schema_def
                  ,cccc.response_schema_type
                  FROM
                  TABLE(self.all_responses()) cccc
                  WHERE
                  cccc.response_schema_type = 'object'
               )
               CONNECT BY PRIOR
               ddd.property_target = ccc.definition
               GROUP BY
                ddd.versionid
               ,ddd.property_target
            )
         ) aa
      ) a;

      --------------------------------------------------------------------------
      -- Step 120
      -- Add the properties to the definitions
      --------------------------------------------------------------------------
      FOR i IN 1 .. def_pool.COUNT
      LOOP
         
         SELECT dz_swagger_property_typ(
             p_property_id          => a.property_id
            ,p_property             => b.property
            ,p_property_type	      => b.property_type
            ,p_property_format      => b.property_format
            ,p_property_allow_null  => b.property_allow_null
            ,p_property_title       => b.property_title
            ,p_property_exp_string  => b.property_exp_string
            ,p_property_exp_number  => b.property_exp_number
            ,p_property_description => b.property_description
            ,p_property_target      => b.property_target
            ,p_property_required    => a.property_required
            ,p_xml_name             => b.xml_name
            ,p_xml_namespace        => b.xml_namespace
            ,p_xml_prefix           => b.xml_prefix
            ,p_xml_attribute        => b.xml_attribute
            ,p_xml_wrapped          => b.xml_wrapped
            ,p_xml_array_name       => b.xml_array_name
            ,p_versionid            => a.versionid
         )
         BULK COLLECT INTO def_pool(i).swagger_properties
         FROM
         dz_swagger_def_prop a
         LEFT JOIN
         dz_swagger_property b
         ON
         a.property_id = b.property_id
         WHERE
             a.versionid       = def_pool(i).versionid
         AND b.versionid       = def_pool(i).versionid
         AND a.definition      = def_pool(i).definition
         AND a.definition_type = def_pool(i).definition_type
         ORDER BY
         a.property_order;

         IF  def_pool(i).swagger_properties IS NOT NULL
         AND def_pool(i).swagger_properties.COUNT > 1
         AND def_pool(i).swagger_properties(1).property_type = 'reference'
         THEN
            def_pool(i).inline_def := 'FALSE';

         END IF;
         
      END LOOP;

      --------------------------------------------------------------------------
      -- Step 130
      -- Load the response subobjects
      --------------------------------------------------------------------------
      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         FOR j IN 1 .. self.swagger_paths(i).swagger_methods.COUNT
         LOOP
            FOR k IN 1 .. self.swagger_paths(i).swagger_methods(j).method_responses.COUNT
            LOOP
               BEGIN
                  SELECT dz_swagger_definition_typ(
                      p_definition          => a.definition
                     ,p_definition_type     => a.definition_type
                     ,p_definition_desc     => a.definition_desc
                     ,p_inline_def          => a.inline_def
                     ,p_xml_name            => a.xml_name
                     ,p_xml_namespace       => a.xml_namespace
                     ,p_xml_prefix          => a.xml_prefix
                     ,p_versionid           => a.versionid
                     ,p_swagger_properties  => a.swagger_properties
                  )
                  INTO
                  self.swagger_paths(i).swagger_methods(j).method_responses(k).response_schema_obj
                  FROM
                  TABLE(def_pool) a
                  WHERE
                      a.definition      = self.swagger_paths(i).swagger_methods(j).method_responses(k).response_schema_def
                  AND a.definition_type = self.swagger_paths(i).swagger_methods(j).method_responses(k).response_schema_type;

               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;

               END;

            END LOOP;

         END LOOP;

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 140
      -- Filter the defs down to only objects
      --------------------------------------------------------------------------
      SELECT
      dz_swagger_definition_typ(
          p_definition          => a.definition
         ,p_definition_type     => a.definition_type
         ,p_definition_desc     => a.definition_desc
         ,p_inline_def          => a.inline_def
         ,p_xml_name            => a.xml_name
         ,p_xml_namespace       => a.xml_namespace
         ,p_xml_prefix          => a.xml_prefix
         ,p_versionid           => a.versionid
         ,p_swagger_properties  => a.swagger_properties
      )
      BULK COLLECT INTO self.swagger_defs
      FROM
      TABLE(def_pool) a
      WHERE
      a.definition_type IN ('object')
      ORDER BY
      a.definition;

      RETURN;

   END dz_swagger_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION all_methods
   RETURN dz_swagger_method_list
   AS
      list_output dz_swagger_method_list;
      int_index   PLS_INTEGER;

   BEGIN
      IF self.swagger_paths IS NULL
      OR self.swagger_paths.COUNT = 0
      THEN
         RETURN NULL;

      END IF;

      int_index   := 0;
      list_output := dz_swagger_method_list();

      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         IF  self.swagger_paths(i).swagger_methods IS NOT NULL
         AND self.swagger_paths(i).swagger_methods.COUNT > 0
         THEN
            FOR j IN 1 .. self.swagger_paths(i).swagger_methods.COUNT
            LOOP
               list_output.EXTEND();
               int_index := int_index + 1;
               list_output(int_index) := self.swagger_paths(i).swagger_methods(j);

            END LOOP;

         END IF;

      END LOOP;

      RETURN list_output;

   END all_methods;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION all_responses
   RETURN dz_swagger_response_list
   AS
      list_output dz_swagger_response_list;
      int_index   PLS_INTEGER;

   BEGIN
      IF self.swagger_paths IS NULL
      OR self.swagger_paths.COUNT = 0
      THEN
         RETURN NULL;

      END IF;

      int_index   := 0;
      list_output := dz_swagger_response_list();

      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         IF  self.swagger_paths(i).swagger_methods IS NOT NULL
         AND self.swagger_paths(i).swagger_methods.COUNT > 0
         THEN
            FOR j IN 1 .. self.swagger_paths(i).swagger_methods.COUNT
            LOOP
               IF  self.swagger_paths(i).swagger_methods(j).method_responses IS NOT NULL
               AND self.swagger_paths(i).swagger_methods(j).method_responses.COUNT > 0
               THEN
                  FOR k IN 1 .. self.swagger_paths(i).swagger_methods(j).method_responses.COUNT
                  LOOP
                     list_output.EXTEND();
                     int_index := int_index + 1;
                     list_output(int_index) := self.swagger_paths(i).swagger_methods(j).method_responses(k);

                  END LOOP;

               END IF;

            END LOOP;

         END IF;

      END LOOP;

      RETURN list_output;

   END all_responses;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print      IN  NUMBER   DEFAULT NULL
      ,p_host_override_val IN  VARCHAR2 DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print  NUMBER := p_pretty_print;
      clb_output        CLOB;
      str_host          VARCHAR2(4000 Char);
      str_pad           VARCHAR2(1 Char);
      str_pad1          VARCHAR2(1 Char);
      str_pad2          VARCHAR2(1 Char);
      ary_schemes       MDSYS.SDO_STRING2_ARRAY;
      ary_consumes      MDSYS.SDO_STRING2_ARRAY;
      ary_produces      MDSYS.SDO_STRING2_ARRAY;
      int_index         PLS_INTEGER;
      c_swagger_version VARCHAR2(4 Char) := '2.0';

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------

      --------------------------------------------------------------------------
      -- Step 20
      -- Add the left bracket
      --------------------------------------------------------------------------
      IF num_pretty_print IS NULL
      THEN
         clb_output := dz_json_util.pretty('{',NULL);
         str_pad := '';

      ELSE
         clb_output := dz_json_util.pretty('{',-1);
         str_pad := ' ';

      END IF;

      --------------------------------------------------------------------------
      -- Step 30
      -- Add base attributes
      --------------------------------------------------------------------------
      str_pad1 := str_pad;

      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'swagger'
            ,c_swagger_version
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      str_pad1 := ',';

      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.formatted2json(
              'info'
             ,self.swagger_info.toJSON(num_pretty_print + 1)
             ,num_pretty_print + 1
          )
         ,num_pretty_print + 1
      );
      str_pad1 := ',';

      --------------------------------------------------------------------------
      -- Step 80
      -- Override the host if needed
      --------------------------------------------------------------------------
      IF p_host_override_val IS NOT NULL
      THEN
         str_host := p_host_override_val;

      ELSE
         str_host := self.swagger_host;

      END IF;

      IF str_host IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'host'
                ,str_host
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 90
      -- Finish base attributes
      --------------------------------------------------------------------------
      IF self.swagger_basepath IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'basePath'
                ,self.swagger_basepath
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 30
      -- Build the schemes array
      --------------------------------------------------------------------------
      int_index := 0;
      ary_schemes := MDSYS.SDO_STRING2_ARRAY();
      IF self.schemes_https = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_schemes.EXTEND();
         ary_schemes(int_index) := 'https';

      END IF;

      IF ary_schemes IS NOT NULL
      AND ary_schemes.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'schemes'
                ,ary_schemes
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the consumes array
      --------------------------------------------------------------------------
      int_index := 0;
      ary_consumes := MDSYS.SDO_STRING2_ARRAY();
      IF self.consumes_json = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_consumes.EXTEND();
         ary_consumes(int_index) := 'application/json';

      END IF;

      IF self.consumes_xml = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_consumes.EXTEND();
         ary_consumes(int_index) := 'application/xml';

      END IF;

      IF ary_consumes IS NOT NULL
      AND ary_consumes.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'consumes'
                ,ary_consumes
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the produces array
      --------------------------------------------------------------------------
      int_index := 0;
      ary_produces := MDSYS.SDO_STRING2_ARRAY();
      IF self.produces_json = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_produces.EXTEND();
         ary_produces(int_index) := 'application/json';

      END IF;

      IF self.produces_xml = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_produces.EXTEND();
         ary_produces(int_index) := 'application/xml';

      END IF;

      IF ary_produces IS NOT NULL
      AND ary_produces.COUNT > 0
      THEN
         clb_output := clb_output ||  dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'produces'
                ,ary_produces
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the parameters
      --------------------------------------------------------------------------
      IF self.swagger_parms IS NULL
      OR self.swagger_parms.COUNT = 0
      THEN
         NULL;

      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('parameters',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         str_pad1 := ',';

         str_pad2 := str_pad;
         FOR i IN 1 .. self.swagger_parms.COUNT
         LOOP
            IF  self.swagger_parms(i).inline_parm = 'FALSE'
            AND self.swagger_parms(i).parm_undocumented = 'FALSE'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad2 || '"' || self.swagger_parms(i).swagger_parm || '": ' || self.swagger_parms(i).toJSON(
                      p_pretty_print => num_pretty_print + 2
                   )
                  ,num_pretty_print + 2
               );
               str_pad2 := ',';

            END IF;

         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 80
      -- Add the paths
      --------------------------------------------------------------------------
      IF self.swagger_paths IS NULL
      OR self.swagger_paths.COUNT = 0
      THEN
         NULL;

      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('paths',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         str_pad1 := ',';

         str_pad2 := str_pad;
         FOR i IN 1 .. self.swagger_paths.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad2 || self.swagger_paths(i).toJSON(
                   p_pretty_print => num_pretty_print + 2
                )
               ,num_pretty_print + 2
            );
            str_pad2 := ',';

         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 90
      -- Add the defs
      --------------------------------------------------------------------------
      IF self.swagger_defs IS NULL
      OR self.swagger_defs.COUNT = 0
      THEN
         NULL;

      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('definitions',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         str_pad1 := ',';

         str_pad2 := str_pad;
         FOR i IN 1 .. self.swagger_defs.COUNT
         LOOP
            IF self.swagger_defs(i).inline_def = 'FALSE'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad2 || '"' || dz_swagger_util.dzcondense(
                      self.swagger_defs(i).versionid
                     ,self.swagger_defs(i).definition
                   ) || '": ' || self.swagger_defs(i).toJSON(
                      p_pretty_print => num_pretty_print + 2
                   )
                  ,num_pretty_print + 2
               );
               str_pad2 := ',';

            END IF;

         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );

      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;

   END toJSON;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
      p_host_override_val IN  VARCHAR2 DEFAULT NULL
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      c_swagger_version VARCHAR2(4 Char) := '2.0';
      str_host          VARCHAR2(4000 Char);
      int_counter       PLS_INTEGER;

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------

      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml
      --------------------------------------------------------------------------
      clb_output := dz_json_util.pretty_str(
          '---'
         ,0
         ,'  '
      ) || dz_json_util.pretty_str(
          'swagger: ' || dz_swagger_util.yaml_text(c_swagger_version,0)
         ,0
         ,'  '
      ) || dz_json_util.pretty_str(
          'info: '
         ,0
         ,'  '
      ) || self.swagger_info.toYAML(1);

      --------------------------------------------------------------------------
      -- Step 30
      -- Override the host if needed
      --------------------------------------------------------------------------
      IF p_host_override_val IS NOT NULL
      THEN
         str_host := p_host_override_val;

      ELSE
         str_host := self.swagger_host;

      END IF;

      IF str_host IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'host: ' || dz_swagger_util.yaml_text(str_host,0)
            ,0
            ,'  '
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 40
      -- Add the optional basepath
      --------------------------------------------------------------------------
      IF self.swagger_basepath IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'basePath: ' || dz_swagger_util.yaml_text(self.swagger_basepath,0)
            ,0
            ,'  '
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the schemes array
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'schemes: '
         ,0
         ,'  '
      );

      IF self.schemes_https = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             '- https'
            ,0
            ,'  '
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 60
      -- Add the consumes array
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'consumes: '
         ,0
         ,'  '
      );

      IF self.consumes_json = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             '- application/json'
            ,0
            ,'  '
         );

      END IF;

      IF self.consumes_xml = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             '- application/xml'
            ,0
            ,'  '
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 70
      -- Add the produces array
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'produces: '
         ,0
         ,'  '
      );

      IF self.produces_json = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             '- application/json'
            ,0
            ,'  '
         );

      END IF;

      IF self.produces_xml = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             '- application/xml'
            ,0
            ,'  '
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 80
      -- Do the parameters
      --------------------------------------------------------------------------
      IF self.swagger_parms IS NOT NULL
      AND self.swagger_parms.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'parameters: '
            ,0
            ,'  '
         );

         FOR i IN 1 .. self.swagger_parms.COUNT
         LOOP
            IF  self.swagger_parms(i).inline_parm = 'FALSE'
            AND self.swagger_parms(i).parm_undocumented = 'FALSE'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   self.swagger_parms(i).swagger_parm || ': '
                  ,1
                  ,'  '
               ) || self.swagger_parms(i).toYAML(2);

            END IF;

         END LOOP;

      END IF;

      --------------------------------------------------------------------------
      -- Step 90
      -- Do the paths
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'paths: '
         ,0
         ,'  '
      );

      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         clb_output := clb_output || dz_json_util.pretty_str(
             '"' || self.swagger_paths(i).swagger_path || '": '
            ,1
            ,'  '
         ) || self.swagger_paths(i).toYAML(2);

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 100
      -- Do the definitions
      --------------------------------------------------------------------------
      IF self.swagger_defs IS NOT NULL
      AND self.swagger_defs.COUNT > 0
      THEN
         int_counter := 0;
         FOR i IN 1 .. self.swagger_defs.COUNT
         LOOP
            IF self.swagger_defs(i).inline_def = 'FALSE'
            THEN
               int_counter := int_counter + 1;

            END IF;

         END LOOP;

         IF int_counter > 0
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'definitions: '
               ,0
               ,'  '
            );

            FOR i IN 1 .. self.swagger_defs.COUNT
            LOOP
               IF self.swagger_defs(i).inline_def = 'FALSE'
               THEN
                  clb_output := clb_output || dz_json_util.pretty(
                      dz_swagger_util.dzcondense(
                         self.swagger_defs(i).versionid
                        ,self.swagger_defs(i).definition
                     ) || ': '
                     ,1
                     ,'  '
                  ) || self.swagger_defs(i).toYAML(2);

               END IF;

            END LOOP;

         END IF;

      END IF;

      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;

   END toYAML;

END;
/

--
--*************************--
PROMPT DZ_SWAGGER_MAINT.pks;

CREATE OR REPLACE PACKAGE dz_swagger_maint
AUTHID CURRENT_USER
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

--
--*************************--
PROMPT DZ_SWAGGER_MAINT.pkb;

CREATE OR REPLACE PACKAGE BODY dz_swagger_maint
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE import_json(
       p_input     IN  CLOB
      ,p_versionid IN  VARCHAR2 DEFAULT NULL
      ,p_headerid  IN  VARCHAR2 DEFAULT 'IMPORT'
      ,p_groupid   IN  VARCHAR2 DEFAULT 'IMPORT'
   )
   AS
      str_versionid           VARCHAR2(255 Char) := p_versionid;
      num_check               NUMBER;
      str_swagger             VARCHAR2(4000 Char);
      str_info                VARCHAR2(4000 Char);
      str_host                VARCHAR2(4000 Char);
      str_basePath            VARCHAR2(4000 Char);
      str_schemes             VARCHAR2(4000 Char);
      str_produces            VARCHAR2(4000 Char);
      str_consumes            VARCHAR2(4000 Char);
      str_info_version        VARCHAR2(4000 Char);
      str_info_title          VARCHAR2(4000 Char);
      str_info_description    VARCHAR2(4000 Char);
      str_info_termsOfService VARCHAR2(4000 Char);
      str_info_contact        VARCHAR2(4000 Char);
      str_info_license        VARCHAR2(4000 Char);
      str_info_contact_name   VARCHAR2(4000 Char);
      str_info_contact_url    VARCHAR2(4000 Char);
      str_info_contact_email  VARCHAR2(4000 Char);
      str_info_license_name   VARCHAR2(4000 Char);
      str_info_license_url    VARCHAR2(4000 Char);
      clb_parameters          CLOB;
      clb_paths               CLOB;
      clb_definitions         CLOB;
      ary_values              MDSYS.SDO_STRING2_ARRAY;
      str_schemes_https       VARCHAR2(5 Char);
      str_consumes_json       VARCHAR2(5 Char);
      str_consumes_xml        VARCHAR2(5 Char);
      str_produces_json       VARCHAR2(5 Char);
      str_produces_xml        VARCHAR2(5 Char);
      
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      IF str_versionid IS NULL
      THEN
         str_versionid := dz_swagger_util.get_guid();
         
      END IF;
      
      SELECT
      COUNT(*)
      INTO num_check
      FROM
      dz_swagger_vers a
      WHERE
      a.versionid = str_versionid;
      
      IF num_check > 0
      THEN
         RAISE_APPLICATION_ERROR(
          -20001
         ,'versionid preexists in dz_swagger tables'
      );
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Bail unless 12c
      --------------------------------------------------------------------------
$IF DBMS_DB_VERSION.version < 12
$THEN
      RAISE_APPLICATION_ERROR(
          -20001
         ,'12c or greater required for JSON parsing'
      );
      
$ELSE

      --------------------------------------------------------------------------
      -- Step 30
      -- Insert the version record
      --------------------------------------------------------------------------
      INSERT INTO dz_swagger_vers(
          versionid
         ,is_default
         ,version_owner
         ,version_created
      ) VALUES (
          str_versionid
         ,'FALSE'
         ,USER
         ,SYSDATE
      );

      --------------------------------------------------------------------------
      -- Step 40
      -- Scrap off the first layer of JSON items
      --------------------------------------------------------------------------
      SELECT
       JSON_VALUE(p_input,'$.swagger'     RETURNING VARCHAR2(4000 Char))
      ,JSON_QUERY(p_input,'$.info'        RETURNING VARCHAR2(4000 Char))
      ,JSON_VALUE(p_input,'$.host'        RETURNING VARCHAR2(4000 Char))
      ,JSON_VALUE(p_input,'$.basePath'    RETURNING VARCHAR2(4000 Char))
      ,JSON_QUERY(p_input,'$.schemes'     )
      ,JSON_QUERY(p_input,'$.consumes'    )
      ,JSON_QUERY(p_input,'$.produces'    )
      ,JSON_QUERY(p_input,'$.parameters'  WITH WRAPPER)
      ,JSON_QUERY(p_input,'$.paths'       )
      ,JSON_QUERY(p_input,'$.definitions' )
      INTO
       str_swagger
      ,str_info   
      ,str_host  
      ,str_basePath 
      ,str_schemes  
      ,str_consumes  
      ,str_produces
      ,clb_parameters 
      ,clb_paths  
      ,clb_definitions
      FROM
      dual;
      
      raise_application_error(-20001,to_char(clb_parameters));
      --------------------------------------------------------------------------
      -- Step 50
      -- Scrap off the info items
      --------------------------------------------------------------------------
      SELECT
       JSON_VALUE(str_info,'$.title'          RETURNING VARCHAR2(4000 Char))
      ,JSON_VALUE(str_info,'$.description'    RETURNING VARCHAR2(4000 Char))
      ,JSON_VALUE(str_info,'$.termsOfService' RETURNING VARCHAR2(4000 Char))
      ,JSON_QUERY(str_info,'$.contact' )
      ,JSON_QUERY(str_info,'$.license' )
      ,JSON_VALUE(str_info,'$.version'        RETURNING VARCHAR2(4000 Char))
      INTO
       str_info_title
      ,str_info_description
      ,str_info_termsOfService
      ,str_info_contact
      ,str_info_license
      ,str_info_version
      FROM
      dual; 
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Scrap deeper into contact
      --------------------------------------------------------------------------
      IF str_info_contact IS NOT NULL
      THEN
         SELECT
          JSON_VALUE(str_info_contact,'$.name'  RETURNING VARCHAR2(4000 Char))
         ,JSON_VALUE(str_info_contact,'$.url'   RETURNING VARCHAR2(4000 Char))
         ,JSON_VALUE(str_info_contact,'$.email' RETURNING VARCHAR2(4000 Char))
         INTO
          str_info_contact_name
         ,str_info_contact_url
         ,str_info_contact_email
         FROM
         dual;
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Scrap deeper into license
      --------------------------------------------------------------------------
      IF str_info_license IS NOT NULL
      THEN
         SELECT
          JSON_VALUE(str_info_license,'$.name'  RETURNING VARCHAR2(4000 Char))
         ,JSON_VALUE(str_info_license,'$.url'   RETURNING VARCHAR2(4000 Char))
         INTO
          str_info_license_name
         ,str_info_license_url
         FROM
         dual;
      
      END IF;

      --------------------------------------------------------------------------
      -- Step 80
      -- Unload the schemes array
      --------------------------------------------------------------------------
      SELECT
      val
      BULK COLLECT INTO ary_values
      FROM
      JSON_TABLE(
         str_schemes,'$[*]'
         COLUMNS (
            "val" VARCHAR2(255 Char) PATH '$'
         )
      );
      
      str_schemes_https := 'FALSE';
      FOR i IN 1 .. ary_values.COUNT
      LOOP
         IF ary_values(i) = 'https'
         THEN
            str_schemes_https := 'TRUE';
            
         END IF;
         
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 90
      -- Unload the consumes array
      --------------------------------------------------------------------------
      SELECT
      val
      BULK COLLECT INTO ary_values
      FROM
      JSON_TABLE(
         str_consumes,'$[*]'
         COLUMNS (
            "val" VARCHAR2(255 Char) PATH '$'
         )
      );
      
      str_consumes_json := 'FALSE';
      str_consumes_xml  := 'FALSE';
      FOR i IN 1 .. ary_values.COUNT
      LOOP
         IF ary_values(i) = 'application/json'
         THEN
            str_consumes_json := 'TRUE';
            
         ELSIF ary_values(i) = 'text/xml'
         THEN
            str_consumes_xml := 'TRUE';
         
         END IF;
         
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 100
      -- Unload the produces array
      --------------------------------------------------------------------------
      SELECT
      val
      BULK COLLECT INTO ary_values
      FROM
      JSON_TABLE(
         str_produces,'$[*]'
         COLUMNS (
            "val" VARCHAR2(255 Char) PATH '$'
         )
      );
      
      str_produces_json := 'FALSE';
      str_produces_xml  := 'FALSE';
      FOR i IN 1 .. ary_values.COUNT
      LOOP
         IF ary_values(i) = 'application/json'
         THEN
            str_produces_json := 'TRUE';
            
         ELSIF ary_values(i) = 'text/xml'
         THEN
            str_produces_xml := 'TRUE';
         
         END IF;
         
      END LOOP;

      --------------------------------------------------------------------------
      -- Step 110
      -- Insert the head record
      --------------------------------------------------------------------------
      INSERT INTO dz_swagger_head(
          header_id
         ,info_title
         ,info_description
         ,info_termsofservice
         ,info_contact_name
         ,info_contact_url
         ,info_contact_email
         ,info_license_name
         ,info_license_url
         ,info_version
         ,swagger_host
         ,swagger_basepath
         ,schemes_https
         ,consumes_json
         ,consumes_xml
         ,produces_json
         ,produces_xml
         ,versionid
      ) VALUES (
          p_headerid
         ,str_info_title
         ,str_info_description
         ,str_info_termsofservice
         ,str_info_contact_name
         ,str_info_contact_url
         ,str_info_contact_email
         ,str_info_license_name
         ,str_info_license_url
         ,str_info_version
         ,str_host
         ,str_basePath
         ,str_schemes_https
         ,str_consumes_json
         ,str_consumes_xml
         ,str_produces_json
         ,str_produces_xml
         ,str_versionid
      );
      
      --------------------------------------------------------------------------
      -- Step 120
      -- Unloads the paths
      --------------------------------------------------------------------------
      dbms_output.put_line(clb_paths);
      /*
      SELECT
      val
      BULK COLLECT INTO ary_values
      FROM
      JSON_TABLE(
         clb_paths,'$[*]'
         COLUMNS (
            "val" VARCHAR2(4000 Char) FORMAT JSON PATH '$.get'
         )
      );
      
      FOR i IN 1 .. ary_values.COUNT
      LOOP
         dbms_output.put_line(ary_values(i));
         
      END LOOP;
*/
$END
   
   END import_json;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE dump_swagger_tables(
       p_filename  IN  VARCHAR2 DEFAULT NULL
      ,p_directory IN  VARCHAR2 DEFAULT 'LOADING_DOCK'
   )
   AS
      str_filename  VARCHAR2(4000 Char) := p_filename;
      str_directory VARCHAR2(30 Char) := p_directory;
      ary_tables    MDSYS.SDO_STRING2_ARRAY;
      clb_list      CLOB;
      num_handle    NUMBER;
      num_check     NUMBER;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      IF str_filename IS NULL
      THEN
         str_filename := 'dz_swagger_' 
                      || SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA') || '_' 
                      || TO_CHAR(SYSTIMESTAMP,'YYYY') 
                      || TO_CHAR(SYSTIMESTAMP,'mm') 
                      || TO_CHAR(SYSTIMESTAMP,'dd');
      
      ELSE
         str_filename := REGEXP_REPLACE(str_filename,'\.dmp$','');
         
      END IF;
      
      IF str_directory IS NULL
      THEN
         str_directory := 'LOADING_DOCK';
         
      END IF;
      
      SELECT
      COUNT(*)
      INTO num_check
      FROM
      all_directories a
      WHERE
      a.directory_name = str_directory;
      
      IF num_check = 0
      THEN
         RAISE_APPLICATION_ERROR(
             -20001
            ,'directory ' || str_directory || ' not found'
         );
         
      END IF;      
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Define the table list
      --------------------------------------------------------------------------
      ary_tables := MDSYS.SDO_STRING2_ARRAY(
          'DZ_SWAGGER_CONDENSE'
         ,'DZ_SWAGGER_DEFINITION'
         ,'DZ_SWAGGER_DEF_PROP'
         ,'DZ_SWAGGER_HEAD'
         ,'DZ_SWAGGER_PARM'
         ,'DZ_SWAGGER_PARM_ENUM'
         ,'DZ_SWAGGER_PATH'
         ,'DZ_SWAGGER_PATH_PARM'
         ,'DZ_SWAGGER_PATH_RESP'
         ,'DZ_SWAGGER_PATH_TAGS'
         ,'DZ_SWAGGER_PROPERTY'
         ,'DZ_SWAGGER_VERS'
      );
      
      FOR i IN 1 .. ary_tables.COUNT
      LOOP
         clb_list := clb_list || '''' || ary_tables(i) || '''';
         
         IF i <> ary_tables.COUNT
         THEN
            clb_list := clb_list || ',';
            
         END IF; 
      
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Dump the tables
      --------------------------------------------------------------------------
      BEGIN
         num_handle := DBMS_DATAPUMP.open(
             operation => 'EXPORT'
            ,job_mode  => 'TABLE'
            ,job_name  => 'EXPORT_DZSWAGGER_' || TO_CHAR(SYSDATE,'YYYY_MMDD_HH24MI')
            ,version   => 'COMPATIBLE'
         );
          
         DBMS_DATAPUMP.add_file(
             handle    => num_handle
            ,filename  => str_filename || '.log'
            ,directory => str_directory
            ,filetype  => DBMS_DATAPUMP.KU$_FILE_TYPE_LOG_FILE
            ,reusefile => 1
         );
               
         DBMS_DATAPUMP.add_file(
             handle    => num_handle
            ,filename  => str_filename || '.dmp'
            ,directory => str_directory
            ,filetype  => DBMS_DATAPUMP.KU$_FILE_TYPE_DUMP_FILE
            ,reusefile => 1
         );
          
         DBMS_DATAPUMP.metadata_filter(
             handle    => num_handle
            ,name      => 'NAME_LIST'
            ,value     => clb_list
         );
         
         DBMS_DATAPUMP.SET_PARAMETER(
             handle    => num_handle
            ,name      => 'COMPRESSION'
            ,value     => 'ALL'
         );

         DBMS_DATAPUMP.start_job(
             handle    => num_handle
         );
          
         DBMS_DATAPUMP.detach(
              handle   => num_handle
         );

      EXCEPTION 
         WHEN OTHERS
         THEN
            BEGIN
               DBMS_DATAPUMP.detach(
                  handle => num_handle
               );
                
            EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
            END;

            RAISE;
                 
      END;
   
   END dump_swagger_tables;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE restore_swagger_tables(
       p_filename  IN  VARCHAR2
      ,p_directory IN  VARCHAR2 DEFAULT 'LOADING_DOCK'
      ,p_action    IN  VARCHAR2 DEFAULT 'TRUNCATE'
   )
   AS
      str_filename  VARCHAR2(4000 Char) := p_filename;
      str_directory VARCHAR2(30 Char)   := p_directory;
      str_action    VARCHAR2(30 Char)   := UPPER(p_action);
      num_handle    NUMBER;
      num_check     NUMBER;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      IF str_directory IS NULL
      THEN
         str_directory := 'LOADING_DOCK';
         
      END IF;
      
      SELECT
      COUNT(*)
      INTO num_check
      FROM
      all_directories a
      WHERE
      a.directory_name = str_directory;
      
      IF num_check = 0
      THEN
         RAISE_APPLICATION_ERROR(
             -20001
            ,'directory ' || str_directory || ' not found'
         );
         
      END IF;  
      
      IF str_action IS NULL
      THEN
         str_action := 'TRUNCATE';
         
      END IF;
      
      str_filename := REGEXP_REPLACE(str_filename,'\.dmp$','');
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Restore the data
      --------------------------------------------------------------------------
      num_handle := DBMS_DATAPUMP.open(
          operation => 'IMPORT'
         ,job_mode  => 'TABLE'
         ,job_name  => 'IMPORT_DZSWAGGER_' || TO_CHAR(SYSDATE,'YYYY_MMDD_HH24MI')
         ,version   => 'COMPATIBLE'
      );
       
      DBMS_DATAPUMP.add_file(
          handle    => num_handle
         ,filename  => str_filename || '.log'
         ,directory => str_directory
         ,filetype  => DBMS_DATAPUMP.KU$_FILE_TYPE_LOG_FILE
         ,reusefile => 1
      );
            
      DBMS_DATAPUMP.add_file(
          handle    => num_handle
         ,filename  => str_filename || '.dmp'
         ,directory => str_directory
         ,filetype  => DBMS_DATAPUMP.KU$_FILE_TYPE_DUMP_FILE
         ,reusefile => 1
      );
      
      DBMS_DATAPUMP.SET_PARAMETER(
          handle    => num_handle
         ,name      => 'TABLE_EXISTS_ACTION'
         ,value     => str_action
      );

      DBMS_DATAPUMP.start_job(
          handle    => num_handle
      );
       
      DBMS_DATAPUMP.detach(
           handle   => num_handle
      );
      
   END restore_swagger_tables;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION validate_path_object_parms(
       p_versionid     IN  VARCHAR2 
      ,p_path_group_id IN  VARCHAR2 DEFAULT NULL
   ) RETURN MDSYS.SDO_STRING2_ARRAY PIPELINED
   AS
      str_versionid           VARCHAR2(255 Char) := p_versionid;
      str_path_group_id       VARCHAR2(255 Char) := p_path_group_id;
      ary_path_groups         MDSYS.SDO_STRING2_ARRAY;
      ary_errors              MDSYS.SDO_STRING2_ARRAY;
      ary_dd_arguments        dz_swagger_argument_list;
      ary_sw_arguments        dz_swagger_argument_list;
      str_last_object_owner   VARCHAR2(255 Char);
      str_last_object_name    VARCHAR2(255 Char);
      str_last_procedure_name VARCHAR2(255 Char);
      int_counter             NUMBER;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      IF str_versionid IS NULL
      THEN
         str_versionid := 'TRUNK';
         
      END IF;
      
      IF str_path_group_id IS NOT NULL
      THEN
         ary_path_groups := dz_json_util.gz_split(
             p_path_group_id
            ,','
         );
         
      ELSE
         str_path_group_id := 'ALL';
         
      END IF;
       
      --------------------------------------------------------------------------
      -- Step 20
      -- Test whether each procedure is available
      --------------------------------------------------------------------------
      SELECT
       'Unable to find ' || b.object_owner || '.' || b.object_name || '.' || b.procedure_name
      BULK COLLECT INTO ary_errors
      FROM
      all_procedures a
      RIGHT JOIN
      dz_swagger_path b
      ON
          a.owner          = b.object_owner
      AND a.object_name    = b.object_name
      AND a.procedure_name = b.procedure_name
      AND NVL(a.overload,-1) = NVL(b.object_overload,-1)
      WHERE
          b.versionid = str_versionid
      AND (
            str_path_group_id = 'ALL' 
         OR b.path_group_id IN (SELECT * FROM TABLE(ary_path_groups))
      )
      AND a.object_name IS NULL
      GROUP BY
       b.object_owner
      ,b.object_name
      ,b.procedure_name
      ,b.object_overload;
   
      FOR i IN 1 .. ary_errors.COUNT
      LOOP
         PIPE ROW(ary_errors(i));
         
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Load the arguments from the data dictionary
      --------------------------------------------------------------------------
      SELECT dz_swagger_argument(
          p_object_owner     => a.owner
         ,p_object_name      => a.object_name
         ,p_procedure_name   => a.procedure_name
         ,p_argument_name    => b.argument_name
         ,p_data_type        => CASE 
             WHEN b.data_type IN ('VARCHAR2','CHAR') 
             THEN 
                'string'
             ELSE
                LOWER(b.data_type)
             END
         ,p_position         => b.position
         ,p_overload         => a.overload
      )
      BULK COLLECT INTO ary_dd_arguments
      FROM
      all_procedures a
      JOIN
      all_arguments b
      ON
          a.owner            = b.owner
      AND a.object_name      = b.package_name
      AND a.procedure_name   = b.object_name
      AND NVL(a.overload,-1) = NVL(b.overload,-1)
      JOIN (
         SELECT
          cc.versionid
         ,MAX(cc.path_group_id) AS path_group_id
         ,cc.object_owner
         ,cc.object_name
         ,cc.procedure_name
         ,cc.object_overload
         FROM
         dz_swagger_path cc
         GROUP BY
          cc.versionid
         ,cc.object_owner
         ,cc.object_name
         ,cc.procedure_name
         ,cc.object_overload
      ) c
      ON
          a.owner          = c.object_owner
      AND a.object_name    = c.object_name
      AND a.procedure_name = c.procedure_name
      AND NVL(a.overload,-1) = NVL(c.object_overload,-1)
      WHERE
          c.versionid = str_versionid
      AND (
            str_path_group_id = 'ALL' 
         OR c.path_group_id IN (SELECT * FROM TABLE(ary_path_groups))
      )
      AND b.position > 0
      ORDER BY
       a.owner
      ,a.object_name
      ,a.procedure_name
      ,b.position;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Load the arguments from the swagger tables
      --------------------------------------------------------------------------
      SELECT dz_swagger_argument(
          p_object_owner     => a.object_owner
         ,p_object_name      => a.object_name
         ,p_procedure_name   => a.procedure_name
         ,p_argument_name    => UPPER(c.swagger_parm)
         ,p_data_type        => c.parm_type
         ,p_position         => NULL
         ,p_overload         => a.object_overload
      )
      BULK COLLECT INTO ary_sw_arguments
      FROM (
         SELECT
          aa.versionid
         ,MAX(aa.path_group_id) AS path_group_id
         ,aa.swagger_path
         ,aa.swagger_http_method
         ,aa.object_owner
         ,aa.object_name
         ,aa.procedure_name
         ,aa.object_overload
         FROM
         dz_swagger_path aa
         GROUP BY
          aa.versionid
         ,aa.swagger_path
         ,aa.swagger_http_method
         ,aa.object_owner
         ,aa.object_name
         ,aa.procedure_name
         ,aa.object_overload
      ) a
      JOIN
      dz_swagger_path_parm b
      ON
          a.versionid           = b.versionid
      AND a.swagger_path        = b.swagger_path
      AND a.swagger_http_method = b.swagger_http_method
      JOIN
      dz_swagger_parm c
      ON
          a.versionid       = c.versionid
      AND b.swagger_parm_id = c.swagger_parm_id
      WHERE
          a.versionid = str_versionid
      AND (
            str_path_group_id = 'ALL' 
         OR a.path_group_id IN (SELECT * FROM TABLE(ary_path_groups))
      )
      ORDER BY
       a.object_owner
      ,a.object_name
      ,a.procedure_name
      ,b.path_param_sort;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Simplify the positioning down to integer sequence
      --------------------------------------------------------------------------
      str_last_object_owner   := NULL;
      str_last_object_name    := NULL;
      str_last_procedure_name := NULL;
      FOR i IN 1 .. ary_sw_arguments.COUNT
      LOOP
      
         IF  ary_sw_arguments(i).object_owner   = str_last_object_owner
         AND ary_sw_arguments(i).object_name    = str_last_object_name
         AND ary_sw_arguments(i).procedure_name = str_last_procedure_name
         THEN
            int_counter := int_counter + 1;
            
         ELSE
            int_counter := 1;
            
         END IF;
         
         ary_sw_arguments(i).position := int_counter;
         
         str_last_object_owner   := ary_sw_arguments(i).object_owner;
         str_last_object_name    := ary_sw_arguments(i).object_name;
         str_last_procedure_name := ary_sw_arguments(i).procedure_name;

      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Compare the two extracts
      --------------------------------------------------------------------------
      SELECT
       'Inconsistent argument ' || a.object_owner || 
          '.' || a.object_name || 
          '.' || a.procedure_name || 
          ' ' || a.argument_name ||
          ' (' || a.position || ') '
      BULK COLLECT INTO ary_errors
      FROM
      TABLE(ary_dd_arguments) a
      LEFT JOIN
      TABLE(ary_sw_arguments) b
      ON
          a.object_owner   = b.object_owner
      AND a.object_name    = b.object_name
      AND a.procedure_name = b.procedure_name
      AND a.argument_name  = b.argument_name
      AND a.data_type      = b.data_type
      AND a.position       = b.position
      WHERE
      b.object_owner IS NULL
      ORDER BY
       a.object_owner
      ,a.object_name
      ,a.procedure_name
      ,a.position;
      
      FOR i IN 1 .. ary_errors.COUNT
      LOOP
         PIPE ROW(ary_errors(i));
         
      END LOOP;   
      
   END validate_path_object_parms;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION validate_def_tables(
       p_versionid     IN  VARCHAR2 DEFAULT NULL
   ) RETURN MDSYS.SDO_STRING2_ARRAY PIPELINED
   AS
      str_versionid           VARCHAR2(255 Char) := p_versionid;
      ary_owners              MDSYS.SDO_STRING2_ARRAY;
      ary_tables              MDSYS.SDO_STRING2_ARRAY;
      ary_problems            MDSYS.SDO_STRING2_ARRAY;
      ary_universe_tmp        dz_swagger_table_def_list;
      ary_universe            dz_swagger_table_def_list;
      ary_table_defs          dz_swagger_table_def_list;
      str_last_def            VARCHAR2(255 Char);
      str_last_owner          VARCHAR2(30 Char);
      str_last_name           VARCHAR2(30 Char);
      int_counter             PLS_INTEGER;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      IF str_versionid IS NULL
      THEN
         str_versionid := 'TRUNK';
         
      END IF;
       
      --------------------------------------------------------------------------
      -- Step 20
      -- Test whether each table is available
      --------------------------------------------------------------------------
      SELECT
       a.table_owner
      ,a.table_name
      BULK COLLECT INTO
       ary_owners
      ,ary_tables
      FROM
      dz_swagger_definition a
      LEFT JOIN (
         SELECT
          aa.owner AS table_owner
         ,aa.table_name
         FROM
         all_tables aa
         UNION ALL
         SELECT
          bb.owner
         ,bb.view_name
         FROM
         all_views bb
      ) b
      ON
          a.table_owner = b.table_owner
      AND a.table_name = b.table_name
      WHERE
          a.versionid = str_versionid
      AND a.table_owner IS NOT NULL
      AND b.table_name IS NULL
      GROUP BY
       a.table_owner
      ,a.table_name;
      
      FOR i IN 1 .. ary_owners.COUNT
      LOOP
         PIPE ROW('Cannot find def source table ' || ary_owners(i) || '.' || ary_tables(i) || '.');
         
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Load the universe of swagger definitions to test
      --------------------------------------------------------------------------
      SELECT
      dz_swagger_table_def(
          p_definition        => a.definition
         ,p_table_owner       => a.table_owner
         ,p_table_name        => a.table_name
         ,p_column_name       => c.column_name
         ,p_json_name         => d.property
         ,p_json_type         => d.property_type
         ,p_relative_position => c.property_order
      )
      BULK COLLECT INTO
      ary_universe_tmp
      FROM
      dz_swagger_definition a
      JOIN (
         SELECT
          aa.owner AS table_owner
         ,aa.table_name
         FROM
         all_tables aa
         UNION ALL
         SELECT
          bb.owner
         ,bb.view_name
         FROM
         all_views bb
      ) b
      ON
          a.table_owner = b.table_owner
      AND a.table_name  = b.table_name
      JOIN
      dz_swagger_def_prop c
      ON
          c.versionid   = a.versionid
      AND c.definition = a.definition 
      JOIN
      dz_swagger_property d
      ON
          d.versionid   = a.versionid
      AND d.property_id = c.property_id 
      WHERE
          a.versionid = str_versionid
      AND a.table_owner IS NOT NULL
      GROUP BY
       a.definition
      ,a.table_owner
      ,a.table_name
      ,c.column_name
      ,d.property
      ,d.property_type
      ,c.property_order
      ORDER BY
       a.definition
      ,a.table_owner
      ,a.table_name
      ,c.property_order;
      
      int_counter  := 1;
      ary_universe := dz_swagger_table_def_list();
      FOR i IN 1 .. ary_universe_tmp.COUNT
      LOOP
         IF ary_universe_tmp(i).column_name IS NULL
         OR ary_universe_tmp(i).column_name <> '__NA__'
         THEN
            ary_universe.EXTEND();
            ary_universe(int_counter) := ary_universe_tmp(i);
            int_counter := int_counter + 1;
            
         END IF;
          
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Determine actual position values
      --------------------------------------------------------------------------
      str_last_def   := NULL;
      str_last_owner := NULL;
      str_last_name  := NULL;
      int_counter    := 0;
      FOR i IN 1 .. ary_universe.COUNT
      LOOP
      
         IF ary_universe(i).definition  <> str_last_def
         OR ary_universe(i).table_owner <> str_last_owner
         OR ary_universe(i).table_name  <> str_last_name
         THEN
            int_counter := 0;  
         
         END IF;
         
         int_counter := int_counter + 1;
         ary_universe(i).position := int_counter;
         
         str_last_def   := ary_universe(i).definition;
         str_last_owner := ary_universe(i).table_owner;
         str_last_name  := ary_universe(i).table_name;
            
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Load the universe of table definitions to test against
      --------------------------------------------------------------------------
      SELECT
      dz_swagger_table_def(
          p_table_owner       => a.table_owner
         ,p_table_name        => a.table_name
         ,p_column_name       => b.column_name
         ,p_data_type         => b.data_type
         ,p_position          => b.column_id
      )
      BULK COLLECT INTO
      ary_table_defs
      FROM (
         SELECT
          aa.owner AS table_owner
         ,aa.table_name
         FROM
         all_tables aa
         UNION ALL
         SELECT
          bb.owner
         ,bb.view_name
         FROM
         all_views bb
      ) a
      JOIN
      all_tab_columns b
      ON
          a.table_owner = b.owner
      AND a.table_name  = b.table_name
      WHERE
      (a.table_owner,a.table_name) IN (
         SELECT
          c.table_owner
         ,c.table_name
         FROM
         TABLE(ary_universe) c
      )
      ORDER BY
       a.table_owner
      ,a.table_name
      ,b.column_id;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Join and look for problems
      --------------------------------------------------------------------------
      SELECT
      a.definition || ' ' || a.json_name || ' at ' || TO_CHAR(a.position) || ' <> ' || a.table_owner || '.' || a.table_name || '.' || a.column_common || '(' || a.column_name || ')'
      BULK COLLECT INTO
      ary_problems
      FROM
      TABLE(ary_universe) a
      LEFT JOIN
      TABLE(ary_table_defs) b
      ON
          a.table_owner   = b.table_owner
      AND a.table_name    = b.table_name
      AND a.column_common = b.column_common
      AND a.position      = b.position
      WHERE
          b.table_owner IS NULL
      ORDER BY
       a.definition
      ,a.table_owner
      ,a.table_name
      ,a.position;
      
      FOR i IN 1 .. ary_problems.COUNT
      LOOP
         IF INSTR(ary_problems(i),'(__NA__)') > 0
         THEN
            NULL;
            
         ELSE
            PIPE ROW(ary_problems(i));
            
         END IF;
      
      END LOOP;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Debugger
      --------------------------------------------------------------------------
      /*
      FOR i IN 1 .. ary_universe.COUNT
      LOOP
         DBMS_OUTPUT.PUT_LINE(
            ary_universe(i).swagger_def || ', ' || 
            ary_universe(i).table_owner || ', ' ||
            ary_universe(i).table_name || ', ' ||
            ary_universe(i).column_common || ', ' ||
            ary_universe(i).position
         );
         
      END LOOP;
      
      DBMS_OUTPUT.PUT_LINE('-----------------');
      
      FOR i IN 1 .. ary_table_defs.COUNT
      LOOP
         DBMS_OUTPUT.PUT_LINE(
            ary_table_defs(i).table_owner || ', ' ||
            ary_table_defs(i).table_name || ', ' ||
            ary_table_defs(i).column_common || ', ' ||
            ary_table_defs(i).position
         );
         
      END LOOP;
      */
      
   END validate_def_tables;

END dz_swagger_maint;
/

--
--*************************--
PROMPT DZ_SWAGGER_TEST.pks;

CREATE OR REPLACE PACKAGE dz_swagger_test
AUTHID DEFINER
AS

   C_CHANGESET CONSTANT VARCHAR2(255 Char) := '2a551e67827bdf8d9e243bd6c168e42d9abd3952';
   C_JENKINS_JOBNM CONSTANT VARCHAR2(255 Char) := 'DZ_SWAGGER';
   C_JENKINS_BUILD CONSTANT NUMBER := 17;
   C_JENKINS_BLDID CONSTANT VARCHAR2(255 Char) := '17';
   
   C_PREREQUISITES CONSTANT MDSYS.SDO_STRING2_ARRAY := MDSYS.SDO_STRING2_ARRAY(
      'DZ_JSON'
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION prerequisites
   RETURN NUMBER;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION version
   RETURN VARCHAR2;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION inmemory_test
   RETURN NUMBER;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION scratch_test
   RETURN NUMBER;
      
END dz_swagger_test;
/

GRANT EXECUTE ON dz_swagger_test TO public;

--
--*************************--
PROMPT DZ_SWAGGER_TEST.pkb;

CREATE OR REPLACE PACKAGE BODY dz_swagger_test
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION prerequisites
   RETURN NUMBER
   AS
      num_check NUMBER;
      
   BEGIN
      
      FOR i IN 1 .. C_PREREQUISITES.COUNT
      LOOP
         SELECT 
         COUNT(*)
         INTO num_check
         FROM 
         user_objects a
         WHERE 
             a.object_name = C_PREREQUISITES(i) || '_TEST'
         AND a.object_type = 'PACKAGE';
         
         IF num_check <> 1
         THEN
            RETURN 1;
         
         END IF;
      
      END LOOP;
      
      RETURN 0;
   
   END prerequisites;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION version
   RETURN VARCHAR2
   AS
   BEGIN
      RETURN '{"CHANGESET":' || C_CHANGESET || ','
      || '"JOBN":"' || C_JENKINS_JOBNM || '",'   
      || '"BUILD":' || C_JENKINS_BUILD || ','
      || '"BUILDID":"' || C_JENKINS_BLDID || '"}';
      
   END version;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION inmemory_test
   RETURN NUMBER
   AS
   BEGIN
      RETURN 0;
      
   END inmemory_test;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION scratch_test
   RETURN NUMBER
   AS
   BEGIN
      RETURN 0;
      
   END scratch_test;

END dz_swagger_test;
/

--
--*************************--
PROMPT DZ_SWAGGER_ISSUES_TRUNK.vw;

CREATE OR REPLACE FORCE VIEW dz_swagger_issues_trunk(
   issue_type
  ,issue_description
)
AS
SELECT 
 'Parameters' AS issue_type
,a.column_value AS issue_description
FROM 
TABLE (dz_swagger_maint.validate_path_object_parms()) a
UNION ALL
SELECT
 'Definitions'
,b.column_value
FROM 
TABLE (dz_swagger_maint.validate_def_tables()) b;

--
--*************************--
PROMPT DZ_SWAGGER_DEFS_TRUNK.vw;

CREATE OR REPLACE VIEW dz_swagger_defs_trunk(
   csv_output
)
AS
SELECT '"endpoint","method","response","parent","name","type","format","example","title","description","last_updated","author","notes"' AS csv_output
FROM 
dual
UNION ALL
SELECT '"'
    || a.swagger_path
    || '","'
    || a.swagger_http_method
    || '","'
    || a.swagger_response
    || '","'
    || a.parent_def
    || '","'
    || a.property
    || '","'
    || a.property_type
    || '","'
    || a.property_format
    || '","'
    || a.property_example
    || '","'
    || a.property_title
    || '","'
    || a.property_description
    || '","'
    || a.property_desc_updated
    || '","'
    || a.property_desc_author
    || '","'
    || a.property_desc_notes
    || '"'
FROM (  
   SELECT 
    aa.swagger_path
   ,aa.swagger_http_method
   ,aa.swagger_response
   ,( SELECT 
      ee.property
      FROM 
      dz_swagger_property ee
      WHERE 
      ee.property_id = bb.priorprop
    ) AS parent_def
   ,bb.property
   ,bb.property_type
   ,bb.property_format
   ,bb.property_example
   ,bb.property_title
   ,REPLACE(bb.property_description,'"','""') AS property_description
   ,bb.property_desc_updated
   ,bb.property_desc_author
   ,REPLACE(bb.property_desc_notes,'"','""') AS property_desc_notes
   ,bb.property_id
   FROM 
   dz_swagger_path_resp aa
   JOIN (
      SELECT 
       CONNECT_BY_ROOT(ccc.definition) AS rootdef
      ,PRIOR ccc.property_id           AS priorprop
      ,LEVEL                           AS rootlevel
      ,ccc.definition
      ,ccc.definition_type
      ,ccc.property_id
      ,ccc.property_order
      ,ddd.property
      ,ddd.property_type
      ,ddd.property_format
      ,CASE
       WHEN ddd.property_exp_number IS NOT NULL
       THEN
         TO_CHAR (ddd.property_exp_number)
       ELSE
         ddd.property_exp_string
       END AS property_example
      ,ddd.property_title
      ,ddd.property_description
      ,ddd.property_desc_updated
      ,ddd.property_desc_author
      ,ddd.property_desc_notes
      ,ddd.property_target
      FROM 
      dz_swagger_def_prop ccc
      JOIN 
      dz_swagger_property ddd
      ON 
      ccc.property_id = ddd.property_id
      WHERE 
          ccc.versionid = 'TRUNK' 
      AND ddd.versionid = 'TRUNK'
      START WITH (
          ccc.versionid
         ,ccc.definition
         ,ccc.definition_type
      ) IN (
         SELECT 
          cccc.versionid
         ,cccc.response_schema_def
         ,cccc.response_schema_type
         FROM 
         dz_swagger_path_resp cccc
         WHERE     
             cccc.versionid = 'TRUNK'
         AND cccc.response_schema_type = 'object'
      )
      CONNECT BY PRIOR ddd.property_target = ccc.definition
      ORDER BY 
       CONNECT_BY_ROOT(ccc.definition)
      ,LEVEL
      ,ccc.definition
      ,ccc.property_order
   ) bb
   ON 
   aa.response_schema_def = bb.rootdef
   WHERE
       aa.versionid = 'TRUNK'
   AND aa.response_schema_type = 'object'
   ORDER BY 
    aa.swagger_path
   ,bb.definition
   ,bb.property_order
) a;

--
--*************************--
PROMPT DZ_SWAGGER_HEADS_TRUNK.vw;

CREATE OR REPLACE VIEW dz_swagger_heads_trunk(
   csv_output
)
AS
SELECT
'"header_id","header_title","header_description","header_version","last_updated","author","notes","component_endpoints"' AS csv_output
FROM 
dual
UNION ALL
SELECT
'"' || a.header_id || '","' || a.info_title || '","' || a.info_description || '","' || a.info_version || '","' || a.info_desc_updated || '","' || a.info_desc_author || '","' || a.info_desc_notes || '","' || a.swagger_path || '"'
FROM (
   SELECT
    aa.header_id || '1' AS sorter
   ,aa.header_id
   ,aa.info_title
   ,aa.info_description 
   ,aa.info_version
   ,aa.info_desc_updated
   ,aa.info_desc_author
   ,aa.info_desc_notes
   ,aa.swagger_path
   FROM (
      SELECT
       aaa.header_id || '1' AS sorter
      ,aaa.header_id
      ,aaa.info_title
      ,REPLACE(aaa.info_description,'"','""') AS info_description
      ,aaa.info_version
      ,aaa.info_desc_updated
      ,aaa.info_desc_author
      ,aaa.info_desc_notes
      ,NULL AS swagger_path
      FROM
      dz_swagger_head aaa
      WHERE
      aaa.versionid = 'TRUNK'
      UNION ALL
      SELECT
       bbb.header_id || '2' AS sorter
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,ccc.swagger_path
      FROM
      dz_swagger_head bbb
      JOIN
      dz_swagger_path ccc
      ON 
          bbb.versionid = ccc.versionid
      AND bbb.header_id = ccc.path_group_id
      WHERE
      bbb.versionid = 'TRUNK'
      UNION ALL
      SELECT
       ddd.header_id || '3' AS sorter
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL AS swagger_path
      FROM
      dz_swagger_head ddd
      WHERE
      ddd.versionid = 'TRUNK'
   ) aa
   ORDER BY
    aa.sorter
   ,aa.swagger_path
) a;

--
--*************************--
PROMPT DZ_SWAGGER_PARMS_TRUNK.vw;

CREATE OR REPLACE VIEW dz_swagger_parms_trunk(
   csv_output
)
AS
SELECT
'"endpoint","name","description","data_type","default_value","enum_values","required","last_updated","author","notes","internal_id"' AS csv_output
FROM 
dual
UNION ALL
SELECT
'"' || a.swagger_path || '","' || a.swagger_parm || '","' || a.parm_description || '","' 
|| a.parm_type || '","' || a.parm_default || '","' || a.parameter_enum_values || '","' || a.parm_required || '","' 
|| a.parm_desc_updated || '","' || a.parm_desc_author || '","' || a.parm_desc_notes|| '","' || a.swagger_parm_id || '"'
FROM (
   SELECT
    aa.swagger_path || '2' AS sorter
   ,bb.path_param_sort
   ,NULL AS swagger_path
   ,cc.swagger_parm
   ,REPLACE(cc.parm_description,'"','""') AS parm_description
   ,cc.parm_type
   ,CASE 
    WHEN cc.parm_type IN ('number')
    THEN
       TO_CHAR(cc.parm_default_number)
    ELSE
       cc.parm_default_string
    END AS parm_default
   ,(
      SELECT 
      LISTAGG(aaa.enum_value,',') WITHIN GROUP (ORDER BY aaa.enum_value) 
      FROM (
         SELECT
         aaaa.swagger_parm_id
         ,CASE 
          WHEN aaaa.enum_value_number IS NOT NULL
          THEN
            TO_CHAR(aaaa.enum_value_number)
          ELSE
            aaaa.enum_value_string
          END AS enum_value
         FROM
         dz_swagger_parm_enum aaaa
      ) aaa
      WHERE
      aaa.swagger_parm_id = bb.swagger_parm_id
    ) AS parameter_enum_values
   ,cc.parm_required
   ,cc.parm_desc_updated
   ,cc.parm_desc_author
   ,cc.parm_desc_notes
   ,cc.swagger_parm_id
   FROM (
      SELECT
       aaa.versionid
      ,aaa.swagger_path
      FROM
      dz_swagger_path aaa
      GROUP BY
       aaa.versionid
      ,aaa.swagger_path
   ) aa
   JOIN
   dz_swagger_path_parm bb
   ON
       bb.versionid = aa.versionid
   AND bb.swagger_path = aa.swagger_path
   JOIN
   dz_swagger_parm cc
   ON
       cc.versionid = aa.versionid
   AND cc.swagger_parm_id = bb.swagger_parm_id
   WHERE
       aa.versionid = 'TRUNK'
   AND cc.parm_undocumented = 'FALSE'
   UNION ALL
   SELECT
    aa.swagger_path || '1' AS sorter
   ,0 AS path_param_sort
   ,aa.swagger_path
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   FROM
   dz_swagger_path aa
   WHERE
   aa.versionid = 'TRUNK'
   GROUP BY
    aa.versionid
   ,aa.swagger_path
   ORDER BY
    1
   ,2
) a;

--
--*************************--
PROMPT DZ_SWAGGER_PATHS_TRUNK.vw;

CREATE OR REPLACE VIEW dz_swagger_paths_trunk(
   csv_output
)
AS
SELECT
'"path","summary","description","last_updated","author","notes"' AS csv_output
FROM 
dual
UNION ALL
SELECT
'"' || a.swagger_path || '","' || a.path_summary || '","' || a.path_description || '","' || a.path_desc_updated || '","' || a.path_desc_author|| '","' || a.path_desc_notes || '"'
FROM (
   SELECT
    aa.swagger_path
   ,REPLACE(aa.path_summary,'"','""') AS path_summary
   ,REPLACE(aa.path_description,'"','""') AS path_description
   ,aa.path_desc_updated
   ,aa.path_desc_author
   ,aa.path_desc_notes
   FROM
   dz_swagger_path aa
   WHERE
   aa.versionid = 'TRUNK'
   GROUP BY
    aa.swagger_path
   ,REPLACE(aa.path_summary,'"','""')
   ,REPLACE(aa.path_description,'"','""')
   ,aa.path_desc_updated
   ,aa.path_desc_author
   ,aa.path_desc_notes
   ORDER BY
    aa.swagger_path
) a;

--
--*************************--
PROMPT DZ_SWAGGER_RESP_TRUNK.vw;

CREATE OR REPLACE VIEW dz_swagger_resp_trunk(
   csv_output
)
AS
SELECT
'"path","method","response","description","last_updated","author","notes"' AS csv_output
FROM 
dual
UNION ALL
SELECT
'"' || a.swagger_path || '","' || a.swagger_http_method || '","' || a.swagger_response || '","' || a.response_description || '","' || a.response_desc_updated || '","' || a.response_desc_author|| '","' || a.response_desc_notes || '"'
FROM (
   SELECT
    aa.swagger_path
   ,aa.swagger_http_method
   ,aa.swagger_response
   ,REPLACE(aa.response_description,'"','""') AS response_description
   ,aa.response_desc_updated
   ,aa.response_desc_author
   ,aa.response_desc_notes
   FROM
   dz_swagger_path_resp aa
   WHERE
   aa.versionid = 'TRUNK'
   ORDER BY
   aa.swagger_path
) a;

--
--*************************--
PROMPT sqlplus_footer.sql;

SHOW ERROR;

DECLARE
   l_num_errors PLS_INTEGER;

BEGIN

   SELECT
   COUNT(*)
   INTO l_num_errors
   FROM
   user_errors a
   WHERE
   a.name LIKE 'DZ_SWAGGER%';

   IF l_num_errors <> 0
   THEN
      RAISE_APPLICATION_ERROR(-20001,'COMPILE ERROR');

   END IF;

   l_num_errors := DZ_SWAGGER_TEST.inmemory_test();

   IF l_num_errors <> 0
   THEN
      RAISE_APPLICATION_ERROR(-20001,'INMEMORY TEST ERROR');

   END IF;

END;
/

EXIT;
