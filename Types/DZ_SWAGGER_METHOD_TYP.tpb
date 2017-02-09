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
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         
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
         IF num_pretty_print IS NULL
         THEN
            str_parms := dz_json_util.pretty('[',NULL);
            
         ELSE
            str_parms := dz_json_util.pretty('[',-1);
            
         END IF;
         
         str_pad := ' ';
         
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
            
                  IF num_pretty_print IS NULL
                  THEN
                     str_temp := dz_json_util.pretty('{',NULL);
                     
                  ELSE
                     str_temp := dz_json_util.pretty('{',-1);
                     
                  END IF;
                  
                  str_temp := str_temp || dz_json_util.pretty(
                     dz_json_main.value2json(
                         '$ref'
                        ,'#/parameters/' || self.method_path_parms(i).swagger_parm
                        ,num_pretty_print + 3
                     )
                     ,num_pretty_print + 3
                  );
                  
                  str_temp := str_temp || dz_json_util.pretty(
                      '}'
                     ,num_pretty_print + 2,NULL,NULL
                  );
               
               END IF;
            
               str_parms := str_parms || dz_json_util.pretty(
                   str_pad || str_temp
                  ,num_pretty_print + 2
               );
                  
               str_pad := ',';
               
            END IF;
         
         END LOOP;
         
         str_parms := str_parms || dz_json_util.pretty(
             ']'
            ,num_pretty_print + 1,NULL,NULL
         );
      
      END IF;

      --------------------------------------------------------------------------
      -- Step 60
      -- Add base attributes
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          ' ' || dz_json_main.value2json(
             'summary'
            ,self.path_summary
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      ) || dz_json_util.pretty(
          ',' || dz_json_main.value2json(
              'description'
             ,self.path_description
             ,num_pretty_print + 1
          )
         ,num_pretty_print + 1
      ) || dz_json_util.pretty(
          ',' || dz_json_main.formatted2json(
              'parameters'
             ,str_parms
             ,num_pretty_print + 1
          )
         ,num_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add the optional tags
      --------------------------------------------------------------------------
      IF self.method_tags IS NOT NULL
      AND self.method_tags.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                 'tags'
                ,self.method_tags
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add responses
      --------------------------------------------------------------------------
      IF self.method_responses IS NULL
      OR self.method_responses.COUNT = 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.fastname('responses',num_pretty_print) || 'null'
            ,num_pretty_print + 1
         );

      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.fastname('responses',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         
         str_pad := ' ';

         FOR i IN 1 .. self.method_responses.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || self.method_responses(i).toJSON(
                   p_pretty_print => num_pretty_print + 2
                )
               ,num_pretty_print + 2
            );
            
            str_pad := ',';

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

