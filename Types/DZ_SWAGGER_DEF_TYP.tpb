CREATE OR REPLACE TYPE BODY dz_swagger_def_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_def_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_def_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_def_typ(
       p_swagger_def          IN  VARCHAR2
      ,p_swagger_def_type     IN  VARCHAR2
      ,p_swagger_def_xml_name IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.swagger_def          := p_swagger_def;
      self.swagger_def_type     := p_swagger_def_type;
      self.swagger_def_xml_name := p_swagger_def_xml_name;
      self.inline_def           := p_inline_def;
      self.versionid            := p_versionid;
      
      RETURN; 
      
   END dz_swagger_def_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_def_typ(
       p_swagger_def          IN  VARCHAR2
      ,p_swagger_def_type     IN  VARCHAR2
      ,p_swagger_def_xml_name IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
      ,p_swagger_def_props    IN  dz_swagger_def_prop_list
   ) RETURN SELF AS RESULT 
   AS
   BEGIN 
   
      self.swagger_def          := p_swagger_def;
      self.swagger_def_type     := p_swagger_def_type;
      self.swagger_def_xml_name := p_swagger_def_xml_name;
      self.inline_def           := p_inline_def;
      self.versionid            := p_versionid;
      self.swagger_def_props    := p_swagger_def_props;
      
      RETURN; 
      
   END dz_swagger_def_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
      p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_xml          VARCHAR2(32000 Char);
      
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
      -- Add base attributes
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          ' ' || dz_json_main.value2json(
             'type'
            ,self.swagger_def_type
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional xml object
      --------------------------------------------------------------------------
      IF self.swagger_def_xml_name IS NOT NULL
      THEN
         IF num_pretty_print IS NULL
         THEN
            str_xml := dz_json_util.pretty('{',NULL);
            
         ELSE
            str_xml := dz_json_util.pretty('{',-1);
            
         END IF;
         
         str_xml := str_xml || dz_json_util.pretty(
             ' ' || dz_json_main.value2json(
                'name'
               ,self.swagger_def_xml_name
               ,num_pretty_print + 2
            )
            ,num_pretty_print + 2
         ) || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1,NULL,NULL
         );   
      
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.formatted2json(
                 'xml'
                ,str_xml
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add properties
      --------------------------------------------------------------------------
      IF self.swagger_def_props IS NULL
      OR self.swagger_def_props.COUNT = 0
      THEN
         NULL;

      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.fastname('properties',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         
         str_pad := ' ';

         FOR i IN 1 .. self.swagger_def_props.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || self.swagger_def_props(i).toJSON(
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
      -- Do the type element
      --------------------------------------------------------------------------
      clb_output := dz_json_util.pretty_str(
          'type: ' || self.swagger_def_type
         ,num_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add optional xml object
      --------------------------------------------------------------------------
      IF self.swagger_def_xml_name IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'xml: '
            ,num_pretty_print
            ,'  '
         ) || dz_json_util.pretty(
             'name: ' || dz_swagger_util.yaml_text(
                 self.swagger_def_xml_name
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add the properties
      --------------------------------------------------------------------------         
      clb_output := clb_output || dz_json_util.pretty_str(
          'properties: '
         ,num_pretty_print
         ,'  '
      );
       
      FOR i IN 1 .. self.swagger_def_props.COUNT
      LOOP
         clb_output := clb_output || dz_json_util.pretty_str(
             self.swagger_def_props(i).def_property || ': '
            ,num_pretty_print + 1
            ,'  '
         ) || self.swagger_def_props(i).toYAML(num_pretty_print + 1);
 
      END LOOP;
      
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