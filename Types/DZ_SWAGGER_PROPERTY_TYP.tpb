CREATE OR REPLACE TYPE BODY dz_swagger_property_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_property_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_property_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_property_typ(
       p_property_id          IN  VARCHAR2
      ,p_property             IN  VARCHAR2
      ,p_property_type	      IN  VARCHAR2
      ,p_property_title       IN  VARCHAR2
      ,p_property_format      IN  VARCHAR2
      ,p_property_allow_null  IN  VARCHAR2
      ,p_property_exp_string  IN  VARCHAR2
      ,p_property_exp_number  IN  NUMBER
      ,p_property_description IN  VARCHAR2
      ,p_property_target      IN  VARCHAR2
      ,p_property_required    IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_xml_attribute        IN  VARCHAR2
      ,p_xml_wrapped          IN  VARCHAR2
      ,p_xml_array_name       IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.property_id          := TRIM(p_property_id);
      self.property             := TRIM(p_property);
      self.property_type        := TRIM(p_property_type);
      self.property_title       := TRIM(p_property_title);
      self.property_format      := TRIM(p_property_format);
      self.property_allow_null  := TRIM(p_property_allow_null);
      self.property_exp_string  := TRIM(p_property_exp_string);
      self.property_exp_number  := p_property_exp_number;
      self.property_description := TRIM(p_property_description);
      self.property_target      := TRIM(p_property_target);
      self.property_required    := TRIM(p_property_required);
      self.xml_name             := TRIM(p_xml_name);
      self.xml_namespace        := TRIM(p_xml_namespace);
      self.xml_prefix           := TRIM(p_xml_prefix);
      self.xml_attribute        := TRIM(p_xml_attribute);
      self.xml_wrapped          := TRIM(p_xml_wrapped);
      self.xml_array_name       := TRIM(p_xml_array_name);
      self.versionid            := p_versionid;
      
      RETURN; 
      
   END dz_swagger_property_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print      IN  INTEGER  DEFAULT NULL
      ,p_jsonschema        IN  VARCHAR2 DEFAULT 'FALSE'
      ,p_zap_override      IN  VARCHAR2 DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      int_pretty_print PLS_INTEGER := p_pretty_print;
      str_jsonschema   VARCHAR2(4000 Char) := UPPER(p_jsonschema);
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_pad2         VARCHAR2(1 Char);
      ary_types        MDSYS.SDO_STRING2_ARRAY;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      IF str_jsonschema IS NULL
      OR str_jsonschema NOT IN ('TRUE','FALSE')
      THEN
         str_jsonschema := 'FALSE';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Build the wrapper
      --------------------------------------------------------------------------
      IF int_pretty_print IS NULL
      THEN
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.property) || ':{'
            ,NULL
         );
         str_pad  := '';
         str_pad2 := '';
         
      ELSE
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.property) || ': {'
            ,-1
         );
         str_pad  := ' ';
         str_pad2 := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add base attributes
      --------------------------------------------------------------------------
      IF self.property_type = 'reference'
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad || dz_json_main.value2json(
                '$ref'
               ,'#/definitions/' || dz_swagger_util.dzcondense(
                  self.versionid 
                 ,self.property_target
                )
               ,int_pretty_print + 1
            )
            ,int_pretty_print + 1
         );
         str_pad := ',';
         
      ELSE
         IF self.property_allow_null = 'TRUE'
         AND str_jsonschema = 'TRUE'
         THEN
            ary_types := MDSYS.SDO_STRING2_ARRAY();
            ary_types.EXTEND(2);
            ary_types(1) := self.property_type;
            ary_types(2) := 'null';
            
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'type'
                  ,ary_types
                  ,int_pretty_print + 1
               )
               ,int_pretty_print + 1
            );
            str_pad := ',';
            
         ELSE   
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'type'
                  ,self.property_type
                  ,int_pretty_print + 1
               )
               ,int_pretty_print + 1
            );
            str_pad := ',';
            
         END IF;
         
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional format 
      --------------------------------------------------------------------------
         IF self.property_format IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'format'
                  ,self.property_format
                  ,int_pretty_print + 1
               )
               ,int_pretty_print + 1
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional title 
      --------------------------------------------------------------------------
         IF self.property_title IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'title'
                  ,self.property_title
                  ,int_pretty_print + 1
               )
               ,int_pretty_print + 1
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Add optional example 
      --------------------------------------------------------------------------
         IF p_zap_override = 'FALSE'
         THEN
            IF  str_jsonschema = 'FALSE'
            AND self.property_exp_string IS NOT NULL
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad || dz_json_main.value2json(
                      'example'
                     ,self.property_exp_string
                     ,int_pretty_print + 1
                  )
                  ,int_pretty_print + 1
               );

            ELSIF str_jsonschema = 'FALSE'
            AND   self.property_exp_number IS NOT NULL
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad || dz_json_main.value2json(
                      'example'
                     ,self.property_exp_number
                     ,int_pretty_print + 1
                  )
                  ,int_pretty_print + 1
               );
               
            END IF;
            
         END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional description
      --------------------------------------------------------------------------
         IF  self.property_description IS NOT NULL
         AND p_zap_override = 'FALSE'
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.value2json(
                   'description'
                  ,self.property_description
                  ,int_pretty_print + 1
               )
               ,int_pretty_print + 1
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add optional array item
      --------------------------------------------------------------------------
         IF self.property_type = 'array' 
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                str_pad || dz_json_main.fastname('items',int_pretty_print) || '{'
               ,int_pretty_print + 1
            );
            
            IF LOWER(self.property_target) IN ('string','number','integer','boolean')
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                  str_pad2 || dz_json_main.value2json(
                      'type'
                     ,LOWER(self.property_target)
                     ,int_pretty_print + 2
                  )
                  ,int_pretty_print + 2
               );
               str_pad2 := ',';
                  
               IF self.xml_array_name IS NOT NULL
               AND str_jsonschema = 'FALSE'
               THEN
                  clb_output := clb_output || dz_json_util.pretty(
                      str_pad2 || dz_json_main.formatted2json(
                         'xml'
                        ,dz_swagger_xml(
                           p_xml_name => self.xml_array_name
                         ).toJSON(int_pretty_print + 2)
                        ,int_pretty_print + 2
                      )
                     ,int_pretty_print + 2
                  );
                  str_pad2 := ',';
                  
               END IF;

            ELSE
               clb_output := clb_output || dz_json_util.pretty(
                  str_pad2 || dz_json_main.value2json(
                      '$ref'
                     ,'#/definitions/' || dz_swagger_util.dzcondense(
                         self.versionid
                        ,self.property_target
                      )
                     ,int_pretty_print + 2
                  )
                  ,int_pretty_print + 2
               );
               str_pad2 := ',';
               
            END IF;
            
            clb_output := clb_output || dz_json_util.pretty(
                '}'
               ,int_pretty_print + 1
            );

         END IF;
         
      --------------------------------------------------------------------------
      -- Step 90 
      -- Add optional xml tag items
      --------------------------------------------------------------------------
         IF str_jsonschema = 'FALSE'
         THEN   
            IF self.xml_name      IS NOT NULL
            OR self.xml_namespace IS NOT NULL
            OR self.xml_prefix    IS NOT NULL
            OR self.xml_attribute = 'TRUE'
            OR self.xml_wrapped   = 'TRUE'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad2 || dz_json_main.formatted2json(
                      'xml'
                     ,dz_swagger_xml(
                         p_xml_name      => self.xml_name
                        ,p_xml_namespace => self.xml_namespace
                        ,p_xml_prefix    => self.xml_prefix
                        ,p_xml_attribute => self.xml_attribute
                        ,p_xml_wrapped   => self.xml_wrapped
                      ).toJSON(
                        p_pretty_print => int_pretty_print + 1
                      )
                     ,int_pretty_print + 1
                   )
                  ,int_pretty_print + 1
               );
               
            END IF;
            
         END IF;
         
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
      clb_output        CLOB;
      int_pretty_print  PLS_INTEGER := p_pretty_print;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml name to description
      --------------------------------------------------------------------------
      IF self.property_type = 'reference' 
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             '"$ref": "#/definitions/' || dz_swagger_util.dzcondense(
                 self.versionid
                ,self.property_target
             ) || '" '
            ,int_pretty_print + 1
            ,'  '
         );
         
      ELSE       
         clb_output := clb_output || dz_json_util.pretty_str(
             'type: ' || self.property_type
            ,int_pretty_print + 1
            ,'  '
         );
         
         IF self.property_format IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'format: ' || self.property_format
               ,int_pretty_print + 1
               ,'  '
            );

         END IF;
         
         IF self.property_title IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'title: ' || dz_swagger_util.yaml_text(
                   self.property_title
                  ,int_pretty_print + 1
               )
               ,int_pretty_print + 1
               ,'  '
            );

         END IF;
         
         -----------------------------------------------------------------------
         IF p_zap_override = 'FALSE'
         THEN
            IF self.property_exp_string IS NOT NULL
            THEN
               clb_output := clb_output || dz_json_util.pretty_str(
                   'example: ' || dz_swagger_util.yaml_text(
                      self.property_exp_string
                     ,int_pretty_print + 1
                  )
                  ,int_pretty_print + 1
                  ,'  '
               );

            ELSIF self.property_exp_number IS NOT NULL
            THEN
               clb_output := clb_output || dz_json_util.pretty_str(
                   'example: ' || dz_swagger_util.yaml_text(
                      self.property_exp_number
                     ,int_pretty_print + 1
                  )
                  ,int_pretty_print + 1
                  ,'  '
               );
               
            END IF;
            
         END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional description
      --------------------------------------------------------------------------
         IF  self.property_description IS NOT NULL
         AND p_zap_override = 'FALSE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'description: ' || dz_swagger_util.yaml_text(
                   self.property_description
                  ,int_pretty_print + 1
               )
               ,int_pretty_print + 1
               ,'  '
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add optional array item
      --------------------------------------------------------------------------
         IF self.property_type = 'array' 
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'items: '
               ,int_pretty_print + 1
               ,'  '
            );

            IF LOWER(self.property_target) IN ('string','number','integer','boolean')
            THEN
               clb_output := clb_output || dz_json_util.pretty_str(
                   'type: ' || LOWER(self.property_target) || ' '
                  ,int_pretty_print + 2
                  ,'  '
               );
               
               IF self.xml_array_name IS NOT NULL
               THEN
                  clb_output := clb_output || dz_json_util.pretty_str(
                      'xml: '
                     ,int_pretty_print + 2
                     ,'  '
                  ) || dz_swagger_xml(
                     p_xml_name => self.xml_array_name
                  ).toYAML(
                     int_pretty_print + 3
                  );
               
               END IF;
            
            ELSE
               clb_output := clb_output || dz_json_util.pretty_str(
                   '"$ref": "#/definitions/' || dz_swagger_util.dzcondense(
                       self.versionid
                      ,self.property_target
                   ) || '" '
                  ,int_pretty_print + 2
                  ,'  '
               );
            
            END IF;
         
         END IF;
         
      --------------------------------------------------------------------------
      -- Step 90 
      -- Add optional xml tag items
      --------------------------------------------------------------------------   
         IF self.xml_name      IS NOT NULL
         OR self.xml_namespace IS NOT NULL
         OR self.xml_prefix    IS NOT NULL
         OR self.xml_attribute = 'TRUE'
         OR self.xml_wrapped   = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'xml: '
               ,int_pretty_print + 1
               ,'  '
            ) || dz_swagger_xml(
                p_xml_name      => self.xml_name
               ,p_xml_namespace => self.xml_namespace
               ,p_xml_prefix    => self.xml_prefix
               ,p_xml_attribute => self.xml_attribute
               ,p_xml_wrapped   => self.xml_wrapped
            ).toYAML(
               int_pretty_print + 2
            );
         
         END IF;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough it out
      --------------------------------------------------------------------------
      RETURN clb_output;
      
   END toYAML;
   
END;
/

