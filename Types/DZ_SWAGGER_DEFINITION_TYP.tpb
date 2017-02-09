CREATE OR REPLACE TYPE BODY dz_swagger_definition_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_definition_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_definition_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_definition_typ(
       p_definition           IN  VARCHAR2
      ,p_definition_type      IN  VARCHAR2
      ,p_definition_desc      IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.definition           := p_definition;
      self.definition_type      := p_definition_type;
      self.definition_desc      := p_definition_desc;
      self.inline_def           := p_inline_def;
      self.xml_name             := TRIM(p_xml_name);
      self.xml_namespace        := TRIM(p_xml_namespace);
      self.xml_prefix           := TRIM(p_xml_prefix);
      self.versionid            := p_versionid;
      
      RETURN; 
      
   END dz_swagger_definition_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_definition_typ(
       p_definition           IN  VARCHAR2
      ,p_definition_type      IN  VARCHAR2
      ,p_definition_desc      IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
      ,p_swagger_properties   IN  dz_swagger_property_list
   ) RETURN SELF AS RESULT 
   AS
   BEGIN 
   
      self.definition           := p_definition;
      self.definition_type      := p_definition_type;
      self.definition_desc      := p_definition_desc;
      self.inline_def           := p_inline_def;
      self.xml_name             := TRIM(p_xml_name);
      self.xml_namespace        := TRIM(p_xml_namespace);
      self.xml_prefix           := TRIM(p_xml_prefix);
      self.versionid            := p_versionid;
      self.swagger_properties   := p_swagger_properties;
      
      RETURN; 
      
   END dz_swagger_definition_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
      p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_pad2         VARCHAR2(1 Char);
      ary_required     MDSYS.SDO_STRING2_ARRAY;
      int_counter      PLS_INTEGER;
      
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
         str_pad2 := '';
         
      ELSE
         clb_output  := dz_json_util.pretty('{',-1);
         str_pad  := ' ';
         str_pad2 := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add base attributes
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          str_pad || dz_json_main.value2json(
             'type'
            ,self.definition_type
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      str_pad := ',';
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional description object
      --------------------------------------------------------------------------
      IF self.definition_desc IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                'description'
               ,self.definition_desc
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         str_pad := ',';
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional xml object
      --------------------------------------------------------------------------
      IF self.xml_name      IS NOT NULL
      OR self.xml_namespace IS NOT NULL
      OR self.xml_prefix    IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.formatted2json(
                'xml'
               ,dz_swagger_xml(
                   p_xml_name      => self.xml_name
                  ,p_xml_namespace => self.xml_namespace
                  ,p_xml_prefix    => self.xml_prefix
                ).toJSON(
                  p_pretty_print => num_pretty_print + 1
                )
               ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         str_pad := ',';
         
      END IF;
  
      --------------------------------------------------------------------------
      -- Step 60
      -- Add properties
      --------------------------------------------------------------------------
      IF self.swagger_properties IS NULL
      OR self.swagger_properties.COUNT = 0
      THEN
         NULL;

      ELSE
         ary_required := MDSYS.SDO_STRING2_ARRAY();
         int_counter := 1;
      
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.fastname('properties',num_pretty_print) || '{'
            ,num_pretty_print + 1
         );
         str_pad := ',';
         
         FOR i IN 1 .. self.swagger_properties.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad2 || self.swagger_properties(i).toJSON(
                   p_pretty_print => num_pretty_print + 2
                )
               ,num_pretty_print + 2
            );
            str_pad2 := ',';
            
            IF self.swagger_properties(i).property_required = 'TRUE'
            THEN
               ary_required.EXTEND();
               ary_required(int_counter) := self.swagger_properties(i).property;
               int_counter := int_counter + 1;

            END IF;
            
         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,num_pretty_print + 1
         );
         
      --------------------------------------------------------------------------
      -- Step 70
      -- Add properties required array
      --------------------------------------------------------------------------
         IF ary_required IS NOT NULL
         AND ary_required.COUNT > 0
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'required'
                  ,ary_required
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );
            str_pad := ',';
         
         END IF;
      
      END IF;
        
      --------------------------------------------------------------------------
      -- Step 80
      -- Add the left bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,num_pretty_print,NULL,NULL
      );
      
      --------------------------------------------------------------------------
      -- Step 90
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
      boo_required      BOOLEAN;
      
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
          'type: ' || self.definition_type
         ,num_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add optional description object
      --------------------------------------------------------------------------
      IF self.definition_desc IS NOT NULL
      THEN
         clb_output := dz_json_util.pretty_str(
             'description: ' || self.definition_desc
            ,num_pretty_print
            ,'  '
         );
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional xml object
      --------------------------------------------------------------------------
      IF self.xml_name      IS NOT NULL
      OR self.xml_namespace IS NOT NULL
      OR self.xml_prefix    IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'xml: '
            ,num_pretty_print
            ,'  '
         ) || dz_swagger_xml(
             p_xml_name      => self.xml_name
            ,p_xml_namespace => self.xml_namespace
            ,p_xml_prefix    => self.xml_prefix
         ).toYAML(
            num_pretty_print + 1
         );
      
      END IF; 
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add the properties
      --------------------------------------------------------------------------
      boo_required := FALSE;
      
      IF self.swagger_properties IS NULL
      OR self.swagger_properties.COUNT = 0
      THEN
         NULL;

      ELSE      
         clb_output := clb_output || dz_json_util.pretty_str(
             'properties: '
            ,num_pretty_print
            ,'  '
         );
          
         FOR i IN 1 .. self.swagger_properties.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty_str(
                self.swagger_properties(i).property || ': '
               ,num_pretty_print + 1
               ,'  '
            ) || self.swagger_properties(i).toYAML(num_pretty_print + 1);
            
            IF self.swagger_properties(i).property_required = 'TRUE'
            THEN
               boo_required := TRUE;
               
            END IF;
    
         END LOOP;
         
      --------------------------------------------------------------------------
      -- Step 70
      -- Add properties required array
      --------------------------------------------------------------------------
         IF boo_required
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'required: '
               ,num_pretty_print
               ,'  '
            );
            
            FOR i IN 1 .. self.swagger_properties.COUNT
            LOOP
               IF self.swagger_properties(i).property_required = 'TRUE'
               THEN
                  clb_output := clb_output || dz_json_util.pretty_str(
                      '- ' || self.swagger_properties(i).property
                     ,num_pretty_print
                     ,'  '
                  );
                  
               END IF;
               
            END LOOP;
         
         END IF;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/