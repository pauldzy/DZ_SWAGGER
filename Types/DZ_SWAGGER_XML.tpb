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

