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
      
      --------------------------------------------------------------------------
      -- Step 30
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
              || '   ,xml_wrapped             VARCHAR2(5 Char) '
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
      -- Step 40
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
      -- Step 50
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
              || '   ,info_license_url    VARCHAR2(255 Char) '
              || '   ,info_version        VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_host        VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_basepath    VARCHAR2(255 Char) NOT NULL '
              || '   ,schemes_https       VARCHAR2(5 Char) '
              || '   ,consumes_json       VARCHAR2(5 Char) '
              || '   ,consumes_xml        VARCHAR2(5 Char) '
              || '   ,consumes_form       VARCHAR2(5 Char) '
              || '   ,produces_json       VARCHAR2(5 Char) '
              || '   ,produces_xml        VARCHAR2(5 Char) '
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
              || '    CHECK (consumes_form IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c05 '
              || '    CHECK (produces_json IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c06 '
              || '    CHECK (produces_xml IN (''TRUE'',''FALSE'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c07 '
              || '    CHECK (header_id = TRIM(header_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_head_c08 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 60
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
              || '    CHECK (SUBSTR(swagger_parm,2,1) <> ''.'') '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_parm_c07 '
              || '    CHECK (parm_type IN (''number'',''string'')) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Build PARM ENUM table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_parm_enum('
              || '    swagger_parm_id    VARCHAR2(255 Char) NOT NULL '
              || '   ,enum_value_string  VARCHAR2(255 Char) '
              || '   ,enum_value_number  NUMBER '
              || '   ,enum_value_order   INTEGER NOT NULL '
              || '   ,versionid          VARCHAR2(40 Char) NOT NULL '
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
      -- Step 80
      -- Build PATH table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_path('
              || '    path_group_id       VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_path        VARCHAR2(255 Char) NOT NULL '
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
              || 'PRIMARY KEY(versionid,path_group_id,swagger_path) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_path_c01 '
              || '    CHECK (path_group_id = TRIM(path_group_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_c02 '
              || '    CHECK (swagger_path = TRIM(swagger_path)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_c03 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 90
      -- Build PATH METHOD table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_path_method('
              || '    swagger_path        VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_http_method VARCHAR2(255 Char) NOT NULL '
              || '   ,consumes_json       VARCHAR2(5 Char) '
              || '   ,consumes_xml        VARCHAR2(5 Char) '
              || '   ,consumes_form       VARCHAR2(5 Char) '
              || '   ,produces_json       VARCHAR2(5 Char) '
              || '   ,produces_xml        VARCHAR2(5 Char) '
              || '   ,versionid           VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path_method '
              || 'ADD CONSTRAINT dz_swagger_path_method_pk '
              || 'PRIMARY KEY(versionid,swagger_path,swagger_http_method) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path_method '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_path_method_c01 '
              || '    CHECK (swagger_http_method IN (''get'',''post'',''put'',''delete'',''patch'')) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_method_c02 '
              || '    CHECK (swagger_path = TRIM(swagger_path)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_method_c03 '
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
              || '   ,parameter_in_type   VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_parm_id     VARCHAR2(255 Char) NOT NULL '
              || '   ,path_param_sort     INTEGER NOT NULL '
              || '   ,versionid           VARCHAR2(40 Char) NOT NULL '
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
              || '    CHECK (swagger_http_method IN (''get'',''post'',''put'',''delete'',''patch'')) '
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
              || '    CHECK (swagger_http_method IN (''get'',''post'',''put'',''delete'',''patch'')) '
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
              || 'PRIMARY KEY(versionid,swagger_path,swagger_tag) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_path_tags '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_path_tags_c01 '
              || '    CHECK (swagger_path = TRIM(swagger_path)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_path_tags_c02 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 130
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
      -- Step 140
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

