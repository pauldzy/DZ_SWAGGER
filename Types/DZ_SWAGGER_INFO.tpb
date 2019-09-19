CREATE OR REPLACE TYPE BODY dz_swagger_info
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_info;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info(
       p_info_title          IN  VARCHAR2
      ,p_info_description    IN  VARCHAR2
      ,p_info_termsofservice IN  VARCHAR2
      ,p_info_contact        IN  dz_swagger_info_contact
      ,p_info_license        IN  dz_swagger_info_license
      ,p_info_version        IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.info_title          := p_info_title;
      self.info_description    := p_info_description;
      self.info_termsofservice := p_info_termsofservice;
      self.info_contact        := p_info_contact;
      self.info_license        := p_info_license;
      self.info_version        := p_info_version;
      
      RETURN; 
      
   END dz_swagger_info;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION isNULL
   RETURN VARCHAR2
   AS
   BEGIN
   
      IF self.info_title IS NOT NULL
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
             'title'
            ,self.info_title
            ,int_pretty_print + 1
         )
         ,int_pretty_print + 1
      );
         
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional description
      --------------------------------------------------------------------------
      IF self.info_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'description'
               ,self.info_description
               ,int_pretty_print + 1
            )
            ,int_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional termsOfService
      --------------------------------------------------------------------------
      IF self.info_termsOfService IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'termsOfService'
               ,self.info_termsOfService
               ,int_pretty_print + 1
            )
            ,int_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Add optional contact object
      --------------------------------------------------------------------------
      IF self.info_contact.isNULL() = 'FALSE'
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.formatted2json(
                'contact'
               ,self.info_contact.toJSON(int_pretty_print + 1)
               ,int_pretty_print + 1
            )
            ,int_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional license object
      --------------------------------------------------------------------------
      IF self.info_license.isNULL() = 'FALSE'
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.formatted2json(
                'license'
               ,self.info_license.toJSON(int_pretty_print + 1)
               ,int_pretty_print + 1
            )
            ,int_pretty_print + 1
         );

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add optional version
      --------------------------------------------------------------------------
      IF self.info_version IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'version'
               ,self.info_version
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
      -- Write the info title
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'title: ' || dz_swagger_util.yaml_text(
             self.info_title
            ,int_pretty_print
         )
         ,int_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the optional info description
      --------------------------------------------------------------------------
      IF self.info_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'description: ' || dz_swagger_util.yaml_text(
                self.info_description
               ,int_pretty_print
            )
            ,int_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Write the optional info termsOfService
      --------------------------------------------------------------------------
      IF self.info_termsOfService IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'termsOfService: ' || dz_swagger_util.yaml_text(
                self.info_termsOfService
               ,int_pretty_print
            )
            ,int_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Write the optional info contact object
      --------------------------------------------------------------------------
      IF self.info_contact.isNULL() = 'FALSE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'contact: ' 
            ,int_pretty_print
            ,'  '
         ) || self.info_contact.toYAML(
            int_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Write the optional info license object
      --------------------------------------------------------------------------
      IF self.info_license.isNULL() = 'FALSE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'license: '
            ,int_pretty_print
            ,'  '
         ) || self.info_license.toYAML(
            int_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Write the optional info version
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'version: ' || dz_swagger_util.yaml_text(
             self.info_version
            ,int_pretty_print
         )
         ,int_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out without final line feed
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

