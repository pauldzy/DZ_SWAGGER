CREATE OR REPLACE TYPE BODY dz_swagger_path_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_path_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_path_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_path_typ(
       p_swagger_path        IN VARCHAR2
      ,p_versionid          IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.swagger_path := p_swagger_path;
      self.versionid    := p_versionid;
      
      RETURN; 
      
   END dz_swagger_path_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_pad1         VARCHAR2(1 Char);
      
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
             dz_json_main.json_format(self.swagger_path) || ': {'
            ,NULL
         );
         str_pad := '';
         
      ELSE
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.swagger_path) || ': {'
            ,-1
         );
         str_pad := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add the paths
      --------------------------------------------------------------------------
      str_pad1 := str_pad;
      
      IF self.swagger_methods IS NULL
      OR self.swagger_methods.COUNT = 0
      THEN
         NULL;

      ELSE
         FOR i IN 1 .. self.swagger_methods.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad1 || dz_json_main.json_format(
                  self.swagger_methods(i).swagger_http_method
               ) || ': ' || self.swagger_methods(i).toJSON(
                  p_pretty_print => num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );     
            str_pad1 := ',';

         END LOOP;

      END IF;

      --------------------------------------------------------------------------
      -- Step 40
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
           
   END toJSON;
   
   ----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
       p_pretty_print     IN  NUMBER   DEFAULT 0
      ,p_array_marker     IN  VARCHAR  DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      clb_output        CLOB := '';
      num_pretty_print  NUMBER := p_pretty_print;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml name to description
      --------------------------------------------------------------------------
      IF self.swagger_methods IS NULL
      OR self.swagger_methods.COUNT = 0
      THEN
         NULL;

      ELSE
         FOR i IN 1 .. self.swagger_methods.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                self.swagger_methods(i).swagger_http_method || ': '
               ,num_pretty_print
               ,'  '
            ) || self.swagger_methods(i).toYAML(num_pretty_print + 1);
            
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

