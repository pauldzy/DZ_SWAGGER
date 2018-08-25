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
      ,p_consumes_json       IN  VARCHAR2
      ,p_consumes_xml        IN  VARCHAR2
      ,p_consumes_form       IN  VARCHAR2
      ,p_produces_json       IN  VARCHAR2
      ,p_produces_xml        IN  VARCHAR2
      ,p_versionid           IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.swagger_path        := p_swagger_path;
      self.swagger_http_method := p_swagger_http_method;
      self.path_summary        := p_path_summary;
      self.path_description    := p_path_description;
      self.consumes_json       := p_consumes_json;
      self.consumes_xml        := p_consumes_xml;
      self.consumes_form       := p_consumes_form;
      self.produces_json       := p_produces_json;
      self.produces_xml        := p_produces_xml;
      self.versionid           := p_versionid;

      RETURN; 
      
   END dz_swagger_method_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print  NUMBER := p_pretty_print;
      clb_output        CLOB;
      str_pad           VARCHAR2(1 Char);
      str_pad1          VARCHAR2(1 Char);
      str_pad2          VARCHAR2(1 Char);
      str_pad3          VARCHAR2(1 Char);
      str_parms         VARCHAR2(32000 Char);
      str_temp          VARCHAR2(32000 Char);
      str_summary       VARCHAR2(32000 Char);
      ary_consumes      MDSYS.SDO_STRING2_ARRAY;
      ary_produces      MDSYS.SDO_STRING2_ARRAY;
      int_index         PLS_INTEGER;
      
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
      -- Add Summary attribute, note summary is required
      --------------------------------------------------------------------------
      str_pad1 := str_pad;
      
      IF self.path_summary IS NOT NULL
      THEN
         str_summary := self.path_summary;
         
      ELSE
         str_summary := 'Placeholder';
         
      END IF;
      
      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'summary'
            ,str_summary
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      str_pad1 := ',';
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional description attribute
      --------------------------------------------------------------------------
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
      -- Step 50
      -- Add optional consumes attribute
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
      
      IF self.consumes_form = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_consumes.EXTEND();
         ary_consumes(int_index) := 'application/x-www-form-urlencoded';

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
      -- Step 60
      -- Add the optional produces array
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
      -- Step 70
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
      -- Step 80
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
      -- Step 90
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
      str_summary       VARCHAR2(32000 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      clb_output := '';
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Add the required Summary attribute
      --------------------------------------------------------------------------
      IF self.path_summary IS NOT NULL
      THEN
         str_summary := self.path_summary;
         
      ELSE
         str_summary := 'Placeholder';
         
      END IF;
 
      clb_output := clb_output || dz_json_util.pretty_str(
          'summary: ' || dz_swagger_util.yaml_text(self.path_summary,num_pretty_print)
         ,num_pretty_print
         ,'  '
      );

      --------------------------------------------------------------------------
      -- Step 30
      -- Add the optional description attribute
      --------------------------------------------------------------------------
      IF self.path_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'description: ' || dz_swagger_util.yaml_text(self.path_description,num_pretty_print)
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add the consumes array
      --------------------------------------------------------------------------
      IF self.consumes_json = 'TRUE'
      OR self.consumes_xml = 'TRUE'
      OR self.consumes_form = 'TRUE'
      THEN
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
         
         IF self.consumes_form = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                '- application/x-www-form-urlencoded'
               ,0
               ,'  '
            );

         END IF;
         
      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the produces array
      --------------------------------------------------------------------------
      IF self.produces_json = 'TRUE'
      OR self.produces_xml  = 'TRUE'
      THEN
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
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
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
      -- Step 70
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
      -- Step 80
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
      -- Step 90
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

