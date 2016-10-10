CREATE OR REPLACE PACKAGE BODY dz_swagger_setup
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE create_storage_tables(
       p_table_tablespace VARCHAR2 DEFAULT NULL
      ,p_index_tablespace VARCHAR2 DEFAULT NULL
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
      str_sql := 'CREATE TABLE dz_swagger_def('
              || '    swagger_def          VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_def_type     VARCHAR2(255 Char) NOT NULL '
              || '   ,def_property_id      VARCHAR2(255 Char) NOT NULL '
              || '   ,def_property_order   NUMBER NOT NULL '
              || '   ,versionid            VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_def '
              || 'ADD CONSTRAINT dz_swagger_def_pk '
              || 'PRIMARY KEY(versionid,swagger_def,def_property_id) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_def '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_def_c01 '
              || '    CHECK (swagger_def = TRIM(swagger_def)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_c02 '
              || '    CHECK (def_property_id = TRIM(def_property_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_c03 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Build DEF ATTR table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_def_attr('
              || '    swagger_def          VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_def_type     VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_def_xml_name VARCHAR2(255 Char) '
              || '   ,versionid            VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_def_attr '
              || 'ADD CONSTRAINT dz_swagger_def_attr_pk '
              || 'PRIMARY KEY(versionid,swagger_def,swagger_def_type) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_def_attr '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_def_attr_c01 '
              || '    CHECK (swagger_def = TRIM(swagger_def)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_attr_c02 '
              || '    CHECK (swagger_def_xml_name = TRIM(swagger_def_xml_name)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_attr_c03 '
              || '    CHECK (versionid = TRIM(versionid)) '
              || '    ENABLE VALIDATE '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Build DEF PROPS table
      --------------------------------------------------------------------------
      str_sql := 'CREATE TABLE dz_swagger_def_props('
              || '    def_property_id    VARCHAR2(255 Char) NOT NULL '
              || '   ,def_property       VARCHAR2(255 Char) NOT NULL '
              || '   ,def_type           VARCHAR2(255 Char) NOT NULL '
              || '   ,def_reference      VARCHAR2(255 Char) '
              || '   ,def_format         VARCHAR2(255 Char) '
              || '   ,def_title          VARCHAR2(255 Char) '
              || '   ,def_example_string VARCHAR2(255 Char) '
              || '   ,def_example_number NUMBER '
              || '   ,def_description    VARCHAR2(4000 Char) '
              || '   ,versionid          VARCHAR2(40 Char) NOT NULL '
              || ') ';
              
      IF p_table_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'TABLESPACE ' || p_table_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_def_props '
              || 'ADD CONSTRAINT dz_swagger_def_props_pk '
              || 'PRIMARY KEY(versionid,def_property_id) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'ALTER TABLE dz_swagger_def_props '
              || 'ADD( '
              || '    CONSTRAINT dz_swagger_def_props_c01 '
              || '    CHECK (def_property_id = TRIM(def_property_id)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_props_c02 '
              || '    CHECK (def_property = TRIM(def_property)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_props_c03 '
              || '    CHECK (def_reference = TRIM(def_reference)) '
              || '    ENABLE VALIDATE '
              || '   ,CONSTRAINT dz_swagger_def_props_c04 '
              || '    CHECK (versionid = TRIM(versionid)) '
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
              || '    CHECK (swagger_http_method IN (''get'',''post'',''put'',''delete'',''patch'')) '
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
              || '    swagger_path         VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_http_method  VARCHAR2(255 Char) NOT NULL '
              || '   ,swagger_response     VARCHAR2(255 Char) NOT NULL '
              || '   ,response_schema_def  VARCHAR2(255 Char) NOT NULL '
              || '   ,response_schema_type VARCHAR2(255 Char) NOT NULL '
              || '   ,response_description VARCHAR2(4000 Char) '
              || '   ,versionid            VARCHAR2(40 Char) NOT NULL '
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
              || '    CHECK (swagger_http_method IN (''get'',''post'',''put'',''delete'',''patch'')) '
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
              || 'ADD CONSTRAINT dz_swagger_condense_pk '
              || 'PRIMARY KEY(versionid,condense_key,condense_value) ';
              
      IF p_index_tablespace IS NOT NULL
      THEN
         str_sql := str_sql || 'USING INDEX TABLESPACE ' || p_index_tablespace;
      
      END IF;
      
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

END dz_swagger_setup;
/

