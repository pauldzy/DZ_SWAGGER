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
       p_pretty_print     IN  INTEGER  DEFAULT NULL
   ) RETURN CLOB
   AS
      int_pretty_print PLS_INTEGER := p_pretty_print;
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
      IF int_pretty_print IS NULL
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
            ,int_pretty_print + 1
         )
         ,int_pretty_print + 1
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
               ,int_pretty_print + 1
            )
            ,int_pretty_print + 1
         );

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
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      int_pretty_print  PLS_INTEGER := p_pretty_print;
      
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
            ,int_pretty_print
         )
         ,int_pretty_print
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
               ,int_pretty_print
            )
            ,int_pretty_print
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

