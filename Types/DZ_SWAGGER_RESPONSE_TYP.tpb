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
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.swagger_response) || ': {'
            ,NULL
         );
         
      ELSE
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.swagger_response) || ': {'
            ,-1
         );
         
      END IF;
      str_pad := ' ';
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add base attributes
      --------------------------------------------------------------------------
      IF self.response_description IS NULL
      THEN
         str_description := 'Results';
         
      ELSE
         str_description := self.response_description;

      END IF;
      
      clb_output := clb_output || dz_json_util.pretty(
          str_pad || dz_json_main.value2json(
             'description'
            ,str_description
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      ); 
      str_pad := ',';
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Build schema object
      --------------------------------------------------------------------------
      IF  self.response_schema_type = 'object'
      AND self.response_schema_obj IS NOT NULL
      THEN
         IF self.response_schema_obj.inline_def = 'FALSE'
         THEN
         
            IF num_pretty_print IS NULL
            THEN
               str_schema := dz_json_util.pretty('{',NULL);
               
            ELSE
               str_schema := dz_json_util.pretty('{',-1);
               
            END IF;
            
            str_schema := str_schema || dz_json_util.pretty(
                ' ' || dz_json_main.value2json(
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
            
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.formatted2json(
                    'schema'
                   ,str_schema
                   ,num_pretty_print + 1
                )
               ,num_pretty_print + 1
            );
            
            str_pad := ',';
            
         ELSIF self.response_schema_obj.inline_def = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty(
               str_pad || '"schema": ' || self.response_schema_obj.toJSON(
                  p_pretty_print => num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );   
            
            str_pad := ',';
         
         END IF;
         
      ELSIF self.response_schema_type = 'file'
      THEN
         IF num_pretty_print IS NULL
         THEN
            str_schema := dz_json_util.pretty('{',NULL);
            
         ELSE
            str_schema := dz_json_util.pretty('{',-1);
            
         END IF;
         
         str_schema := str_schema || dz_json_util.pretty(
             ' "type": "file"'
            ,num_pretty_print + 2
         ) || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1,NULL,NULL
         );
         
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.formatted2json(
                 'schema'
                ,str_schema
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
      RETURN REGEXP_REPLACE(
          clb_output
         ,'\n$'
         ,''
      );
      
   END toYAML;
   
END;
/

