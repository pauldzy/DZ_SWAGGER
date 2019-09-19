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
         ,p_definition_title    => a.definition_title
         ,p_definition_desc     => a.definition_desc
         ,p_inline_def          => NULL
         ,p_xml_name            => a.xml_name
         ,p_xml_namespace       => a.xml_namespace
         ,p_xml_prefix          => a.xml_prefix
         ,p_xml_wrapped         => a.xml_wrapped
         ,p_versionid           => a.versionid
      )
      BULK COLLECT INTO def_pool
      FROM (
         SELECT
          aa.definition
         ,aa.definition_type
         ,aa.definition_title
         ,aa.definition_desc
         ,aa.xml_name
         ,aa.xml_namespace
         ,aa.xml_prefix
         ,aa.xml_wrapped
         ,aa.versionid
         FROM (
            SELECT
             aaa.definition
            ,aaa.definition_type
            ,aaa.definition_title
            ,aaa.definition_desc
            ,aaa.xml_name
            ,aaa.xml_namespace
            ,aaa.xml_prefix
            ,aaa.xml_wrapped
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
            ,p_definition_title    => a.definition_title
            ,p_definition_desc     => a.definition_desc
            ,p_inline_def          => a.inline_def
            ,p_xml_name            => a.xml_name
            ,p_xml_namespace       => a.xml_namespace
            ,p_xml_prefix          => a.xml_prefix
            ,p_xml_wrapped         => a.xml_wrapped
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
         ,p_definition_title    => a.definition_title
         ,p_definition_desc     => a.definition_desc
         ,p_inline_def          => a.inline_def
         ,p_xml_name            => a.xml_name
         ,p_xml_namespace       => a.xml_namespace
         ,p_xml_prefix          => a.xml_prefix
         ,p_xml_wrapped         => a.xml_wrapped
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
       p_pretty_print      IN  INTEGER  DEFAULT NULL
   ) RETURN CLOB
   AS
      int_pretty_print  PLS_INTEGER := p_pretty_print;
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
      IF int_pretty_print IS NULL
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
            ,int_pretty_print + 1
         )
         ,int_pretty_print + 1
      );
      str_pad1 := ',';
      
      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'title'
            ,self.swagger_path || ' ' 
             || self.swagger_http_method || ' ' 
             || self.swagger_response || ' - ' 
             || self.versionid
            ,int_pretty_print + 1
         )
         ,int_pretty_print + 1
      );
      str_pad1 := ',';

      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'type'
            ,'object'
            ,int_pretty_print + 1
         )
         ,int_pretty_print + 1
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
             str_pad1 || dz_json_main.fastname('properties',int_pretty_print) || '{'
            ,int_pretty_print + 1
         );
         
         FOR i IN 1 .. self.response_schema_obj.swagger_properties.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad2 || self.response_schema_obj.swagger_properties(i).toJSON(
                   p_pretty_print => int_pretty_print + 2
                  ,p_jsonschema   => 'TRUE'
                )
               ,int_pretty_print + 2
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
            ,int_pretty_print + 1
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
                  ,int_pretty_print + 1
               )
               ,int_pretty_print + 1
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
             str_pad1 || dz_json_main.fastname('definitions',int_pretty_print) || '{'
            ,int_pretty_print + 1
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
                      p_pretty_print => int_pretty_print + 2
                     ,p_jsonschema   => 'TRUE'
                   )
                  ,int_pretty_print + 2
               );
               str_pad2 := ',';
               
            END IF;

         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,int_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      --
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'additionalProperties'
            ,FALSE
            ,int_pretty_print + 1
         )
         ,int_pretty_print + 1
      );
      str_pad1 := ',';
   
      --------------------------------------------------------------------------
      -- Step 100
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,int_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
END;
/

