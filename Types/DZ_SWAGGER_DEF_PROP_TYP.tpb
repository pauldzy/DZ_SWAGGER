CREATE OR REPLACE TYPE BODY dz_swagger_def_prop_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_def_prop_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_def_prop_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_def_prop_typ(
       p_def_property_id    IN  VARCHAR2
      ,p_def_property       IN  VARCHAR2
      ,p_def_type	          IN  VARCHAR2
      ,p_def_title          IN  VARCHAR2
      ,p_def_format         IN  VARCHAR2
      ,p_def_example_string IN  VARCHAR2
      ,p_def_example_number IN  NUMBER
      ,p_def_description    IN  VARCHAR2
      ,p_def_reference      IN  VARCHAR2
      ,p_versionid          IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.def_property_id      := TRIM(p_def_property_id);
      self.def_property         := TRIM(p_def_property);
      self.def_type             := TRIM(p_def_type);
      self.def_title            := TRIM(p_def_title);
      self.def_format           := TRIM(p_def_format);
      self.def_example_string   := TRIM(p_def_example_string);
      self.def_example_number   := p_def_example_number;
      self.def_description      := TRIM(p_def_description);
      self.def_reference        := TRIM(p_def_reference);
      self.versionid            := p_versionid;
      
      RETURN; 
      
   END dz_swagger_def_prop_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      ary_items        MDSYS.SDO_STRING2_ARRAY;
      
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
             dz_json_main.json_format(self.def_property) || ': {'
            ,NULL
         );
         
      ELSE
         clb_output  := dz_json_util.pretty(
             dz_json_main.json_format(self.def_property) || ': {'
            ,-1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add base attributes
      --------------------------------------------------------------------------
      IF self.def_type = 'reference'
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ' ' || dz_json_main.value2json(
                '$ref'
               ,'#/definitions/' || dz_swagger_util.dzcondense(
                  self.versionid 
                 ,self.def_reference
                )
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         
      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             ' ' || dz_json_main.value2json(
                'type'
               ,self.def_type
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional format 
      --------------------------------------------------------------------------
         IF self.def_format IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                ',' || dz_json_main.value2json(
                   'format'
                  ,self.def_format
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional title 
      --------------------------------------------------------------------------
         IF self.def_title IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                ',' || dz_json_main.value2json(
                   'title'
                  ,self.def_title
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Add optional example 
      --------------------------------------------------------------------------
         IF self.def_example_string IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                ',' || dz_json_main.value2json(
                   'example'
                  ,self.def_example_string
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );

         ELSIF self.def_example_number IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                ',' || dz_json_main.value2json(
                   'example'
                  ,self.def_example_number
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );
            
         END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional description
      --------------------------------------------------------------------------
         IF self.def_description IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty(
                ',' || dz_json_main.value2json(
                   'description'
                  ,self.def_description
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add optional array item
      --------------------------------------------------------------------------
         IF self.def_type = 'array' 
         THEN
         
            ary_items := dz_json_util.gz_split(
                self.def_reference
               ,','
            );
            
            clb_output := clb_output || dz_json_util.pretty(
                ',' || dz_json_main.fastname('items',num_pretty_print) || '{'
               ,num_pretty_print + 1
            );
            
            str_pad := ' ';
         
            FOR i IN 1 .. ary_items.COUNT
            LOOP
               clb_output := clb_output || dz_json_util.pretty(
                  str_pad || dz_json_main.value2json(
                      '$ref'
                     ,'#/definitions/' || dz_swagger_util.dzcondense(
                         self.versionid
                        ,ary_items(i)
                      )
                     ,num_pretty_print + 2
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
      ary_items         MDSYS.SDO_STRING2_ARRAY;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml name to description
      --------------------------------------------------------------------------
      IF self.def_type = 'reference' 
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             '"$ref": "#/definitions/' || dz_swagger_util.dzcondense(
                 self.versionid
                ,self.def_reference
             ) || '" '
            ,num_pretty_print + 1
            ,'  '
         );
         
      ELSE         
         clb_output := clb_output || dz_json_util.pretty_str(
             'type: ' || self.def_type
            ,num_pretty_print + 1
            ,'  '
         );
         
         IF self.def_format IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'format: ' || self.def_format
               ,num_pretty_print + 1
               ,'  '
            );

         END IF;
         
         IF self.def_title IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'title: ' || dz_swagger_util.yaml_text(
                   self.def_title
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
               ,'  '
            );

         END IF;
         
         -----------------------------------------------------------------------
         IF self.def_example_string IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'example: ' || dz_swagger_util.yaml_text(
                   self.def_example_string
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
               ,'  '
            );

         ELSIF self.def_example_number IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'example: ' || dz_swagger_util.yaml_text(
                   self.def_example_number
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
               ,'  '
            );
            
         END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional description
      --------------------------------------------------------------------------
         IF self.def_description IS NOT NULL
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'description: ' || dz_swagger_util.yaml_text(
                   def_description
                  ,num_pretty_print + 1
               )
               ,num_pretty_print + 1
               ,'  '
            );

         END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add optional array item
      --------------------------------------------------------------------------
         IF self.def_type = 'array' 
         THEN
         
            clb_output := clb_output || dz_json_util.pretty_str(
                'items: '
               ,num_pretty_print + 1
               ,'  '
            );
            
            ary_items := dz_json_util.gz_split(
                self.def_reference
               ,','
            );
            
            FOR i IN 1 .. ary_items.COUNT
            LOOP
               clb_output := clb_output || dz_json_util.pretty_str(
                   '"$ref": "#/definitions/' || dz_swagger_util.dzcondense(
                       self.versionid
                      ,ary_items(i)
                   ) || '" '
                  ,num_pretty_print + 2
                  ,'  '
               );
                 
            END LOOP;
         
         END IF;
         
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

