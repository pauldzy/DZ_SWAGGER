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
         ,'DZ_SWAGGER_DEF'
         ,'DZ_SWAGGER_DEF_ATTR'
         ,'DZ_SWAGGER_DEF_PROPS'
         ,'DZ_SWAGGER_HEAD'
         ,'DZ_SWAGGER_PARM'
         ,'DZ_SWAGGER_PARM_ENUM'
         ,'DZ_SWAGGER_PATH'
         ,'DZ_SWAGGER_PATH_PARM'
         ,'DZ_SWAGGER_PATH_RESP'
         ,'DZ_SWAGGER_PATH_TAGS'
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
      dz_swagger_def_attr a
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
          p_swagger_def       => a.swagger_def
         ,p_table_owner       => a.table_owner
         ,p_table_name        => a.table_name
         ,p_column_name       => c.column_name
         ,p_json_name         => d.def_property
         ,p_json_type         => d.def_type
         ,p_relative_position => c.def_property_order
      )
      BULK COLLECT INTO
      ary_universe_tmp
      FROM
      dz_swagger_def_attr a
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
      dz_swagger_def c
      ON
          c.versionid   = a.versionid
      AND c.swagger_def = a.swagger_def 
      JOIN
      dz_swagger_def_props d
      ON
          d.versionid   = a.versionid
      AND d.def_property_id = c.def_property_id 
      WHERE
          a.versionid = str_versionid
      AND a.table_owner IS NOT NULL
      GROUP BY
       a.swagger_def
      ,a.table_owner
      ,a.table_name
      ,c.column_name
      ,d.def_property
      ,d.def_type
      ,c.def_property_order
      ORDER BY
       a.swagger_def
      ,a.table_owner
      ,a.table_name
      ,c.def_property_order;
      
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
      
         IF ary_universe(i).swagger_def <> str_last_def
         OR ary_universe(i).table_owner <> str_last_owner
         OR ary_universe(i).table_name  <> str_last_name
         THEN
            int_counter := 0;  
         
         END IF;
         
         int_counter := int_counter + 1;
         ary_universe(i).position := int_counter;
         
         str_last_def   := ary_universe(i).swagger_def;
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
      a.swagger_def || ' ' || a.json_name || ' at ' || TO_CHAR(a.position) || ' <> ' || a.table_owner || '.' || a.table_name || '.' || a.column_common || '(' || a.column_name || ')'
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
       a.swagger_def
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

