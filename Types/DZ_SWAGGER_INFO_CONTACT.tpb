CREATE OR REPLACE TYPE BODY dz_swagger_info_contact
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info_contact
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_info_contact;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_info_contact(
       p_contact_name     IN  VARCHAR2
      ,p_contact_url      IN  VARCHAR2
      ,p_contact_email    IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.contact_name      := p_contact_name;
      self.contact_url       := p_contact_url;
      self.contact_email     := p_contact_email;
      
      RETURN; 
      
   END dz_swagger_info_contact;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION isNULL
   RETURN VARCHAR2
   AS
   BEGIN
   
      IF self.contact_name IS NOT NULL
      THEN
         RETURN 'FALSE';
         
      ELSIF self.contact_url IS NOT NULL
      THEN
         RETURN 'FALSE';
      
      ELSIF self.contact_email IS NOT NULL
      THEN
         RETURN 'FALSE';
      
      ELSE
         RETURN 'TRUE';
         
      END IF;
   
   END isNULL;
   
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
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add name element
      --------------------------------------------------------------------------
      str_pad := ' ';
      
      IF self.contact_name IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'name'
               ,self.contact_name
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         
         str_pad := ',';
         
      END IF;
         
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional url 
      --------------------------------------------------------------------------
      IF self.contact_url IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'url'
               ,self.contact_url
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         
         str_pad := ',';

      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional email 
      --------------------------------------------------------------------------
      IF self.contact_email IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'email'
               ,self.contact_email
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
      -- Write the yaml contact name
      --------------------------------------------------------------------------
      IF self.contact_name IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'name: ' || dz_swagger_util.yaml_text(
                self.contact_name
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the optional contact url
      --------------------------------------------------------------------------
      IF self.contact_url IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'url: ' || dz_swagger_util.yaml_text(
                self.contact_url
               ,num_pretty_print
            )
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the optional contact_email
      --------------------------------------------------------------------------
      IF self.contact_email IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'email: ' || dz_swagger_util.yaml_text(
                self.contact_email
               ,num_pretty_print
            )
            ,num_pretty_print
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

