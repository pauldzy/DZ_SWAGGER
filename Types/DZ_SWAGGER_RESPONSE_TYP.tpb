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
       p_pretty_print      IN  INTEGER  DEFAULT NULL
      ,p_zap_override      IN  VARCHAR2 DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      int_pretty_print PLS_INTEGER := p_pretty_print;
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
      IF int_pretty_print IS NULL
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
            ,int_pretty_print + 1
         )
         ,int_pretty_print + 1
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
            
            IF int_pretty_print IS NULL
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
                  ,int_pretty_print + 2
               )
               ,int_pretty_print + 2
            ) || dz_json_util.pretty(
                '}'
               ,int_pretty_print + 1,NULL,NULL
            );
            str_pad2 := ',';
            
            clb_output := clb_output || dz_json_util.pretty(
                str_pad1 || dz_json_main.formatted2json(
                    'schema'
                   ,str_schema
                   ,int_pretty_print + 1
                )
               ,int_pretty_print + 1
            );
            str_pad1 := ',';
            
         ELSIF self.response_schema_obj.inline_def = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty(
               str_pad1 || '"schema": ' || self.response_schema_obj.toJSON(
                   p_pretty_print => int_pretty_print + 1
                  ,p_zap_override => p_zap_override
               )
               ,int_pretty_print + 1
            );   
            str_pad1 := ',';
         
         END IF;
         
      ELSIF self.response_schema_type = 'file'
      THEN
         str_pad2 := str_pad;
         
         IF int_pretty_print IS NULL
         THEN
            str_schema := dz_json_util.pretty('{',NULL);
            
         ELSE
            str_schema := dz_json_util.pretty('{',-1);
            
         END IF;
         
         str_schema := str_schema || dz_json_util.pretty(
             str_pad2 || '"type": "file"'
            ,int_pretty_print + 2
         ) || dz_json_util.pretty(
             '}'
            ,int_pretty_print + 1,NULL,NULL
         );
         str_pad2 := ',';
         
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.formatted2json(
                 'schema'
                ,str_schema
                ,int_pretty_print + 1
             )
            ,int_pretty_print + 1
         );
         str_pad1 := ',';
            
      END IF;

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
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
       p_pretty_print      IN  INTEGER  DEFAULT 0
      ,p_zap_override      IN  VARCHAR2 DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      clb_output       CLOB;
      int_pretty_print PLS_INTEGER := p_pretty_print;
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
             ,int_pretty_print
          )
         ,int_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Do the schema object
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'schema: '
         ,int_pretty_print
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
               ,int_pretty_print + 1
               ,'  '
            );
            
         ELSIF self.response_schema_obj.inline_def = 'TRUE'
         THEN
            clb_output := clb_output || self.response_schema_obj.toYAML(
                p_pretty_print => int_pretty_print + 1
               ,p_zap_override => p_zap_override
            );
            
         END IF;
            
      ELSIF self.response_schema_type = 'file'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'type: file'
            ,int_pretty_print + 1
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

