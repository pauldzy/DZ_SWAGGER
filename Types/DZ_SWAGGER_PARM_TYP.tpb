CREATE OR REPLACE TYPE BODY dz_swagger_parm_typ
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_parm_typ
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_parm_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_parm_typ(
       p_swagger_parm_id      IN  VARCHAR2
      ,p_swagger_parm         IN  VARCHAR2
      ,p_parm_description     IN  VARCHAR2
      ,p_parm_type            IN  VARCHAR2
      ,p_parm_default_string  IN  VARCHAR2
      ,p_parm_default_number  IN  NUMBER
      ,p_parm_required        IN  VARCHAR2
      ,p_parm_undocumented    IN  VARCHAR2
      ,p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_parameter_in_type    IN  VARCHAR2
      ,p_path_param_sort      IN  NUMBER
      ,p_param_sort           IN  NUMBER
      ,p_inline_parm          IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.swagger_parm_id      := p_swagger_parm_id;
      self.swagger_parm         := p_swagger_parm;
      self.parm_description     := p_parm_description;
      self.parm_type            := p_parm_type;
      self.parm_default_string  := p_parm_default_string;
      self.parm_default_number  := p_parm_default_number;
      self.parm_required        := p_parm_required;
      self.parm_undocumented    := p_parm_undocumented;
      self.swagger_path         := p_swagger_path;
      self.swagger_http_method  := p_swagger_http_method;
      self.parameter_in_type    := p_parameter_in_type;
      self.path_param_sort      := p_path_param_sort;
      self.param_sort           := p_param_sort;
      self.inline_parm          := p_inline_parm;
      self.versionid            := p_versionid;
      
      IF self.parameter_in_type = 'query'
      THEN
         self.parameter_ref_id := 'q.' || self.swagger_parm;
         
      ELSIF self.parameter_in_type = 'formData'
      THEN
         self.parameter_ref_id := 'f.' || self.swagger_parm;
         
      ELSE
         self.parameter_ref_id := self.swagger_parm;
         
      END IF;
      
      SELECT
       a.enum_value_string
      ,a.enum_value_number
      BULK COLLECT INTO 
       self.parm_enums_string
      ,self.parm_enums_number
      FROM
      dz_swagger_parm_enum a
      WHERE
          a.versionid = p_versionid
      AND a.swagger_parm_id = p_swagger_parm_id
      ORDER BY
      a.enum_value_order;
      
      IF self.parm_enums_string.COUNT > 0
      AND self.parm_enums_string(1) IS NULL
      THEN
         self.parm_enums_string := MDSYS.SDO_STRING2_ARRAY();
         
      END IF;
      
      RETURN; 
      
   END dz_swagger_parm_typ;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      num_pretty_print NUMBER := p_pretty_print;
      clb_output       CLOB;
      str_pad          VARCHAR2(1 Char);
      str_enums        VARCHAR2(32000 Char);
      str_temp         VARCHAR2(4000 Char);
      
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
      -- Add name attribute
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          ' ' || dz_json_main.value2json(
             'name'
            ,self.swagger_parm
            ,num_pretty_print + 1
         )
         ,p_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add in attribute
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
         ',' || dz_json_main.value2json(
              'in'
             ,self.parameter_in_type
             ,num_pretty_print + 1
          )
         ,p_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Add optional description
      --------------------------------------------------------------------------     
      IF self.parm_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                 'description'
                ,self.parm_description
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Add optional enum array
      --------------------------------------------------------------------------
      IF self.parm_enums_string IS NOT NULL
      AND self.parm_enums_string.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                 'enum'
                ,self.parm_enums_string
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
      
      ELSIF self.parm_enums_number IS NOT NULL
      AND self.parm_enums_number.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                 'enum'
                ,self.parm_enums_number
                ,num_pretty_print + 1
             )
            ,num_pretty_print + 1
         );
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Add optional default value
      --------------------------------------------------------------------------
      IF self.parm_default_string IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'default'
               ,self.parm_default_string
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
      
      ELSIF self.parm_default_number IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.value2json(
                'default'
               ,self.parm_default_number
               ,num_pretty_print + 1
            )
            ,num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Add type attributes
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          ',' || dz_json_main.value2json(
             'type'
            ,self.parm_type
            ,num_pretty_print + 1
         )
         ,num_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 90
      -- Add required attribute
      --------------------------------------------------------------------------
      IF LOWER(self.parm_required) = 'true'
      THEN
         str_temp := 'true';
         
      ELSE
         str_temp := 'false';
      
      END IF;
      
      clb_output := clb_output || dz_json_util.pretty(
          ',' || dz_json_main.formatted2json(
              'required'
             ,str_temp
             ,num_pretty_print + 1
          )
         ,num_pretty_print + 1
      );

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
   
   ----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toYAML(
       p_pretty_print     IN  NUMBER   DEFAULT 0
      ,p_array_marker     IN  VARCHAR  DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      num_pretty_print  NUMBER := p_pretty_print;
      str_pad           VARCHAR2(2 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------
      IF p_array_marker = 'TRUE'
      THEN
         str_pad := '- ';
         num_pretty_print := num_pretty_print + 1;
         
      ELSE
         str_pad := NULL;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml name attribute
      --------------------------------------------------------------------------
      clb_output := dz_json_util.pretty_str(
          str_pad || 'name: ' || dz_swagger_util.yaml_text(self.swagger_parm,num_pretty_print)
         ,p_pretty_print
         ,'  '
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the yaml in attribute 
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'in: ' || dz_swagger_util.yaml_text(self.parameter_in_type,num_pretty_print)
         ,num_pretty_print
         ,'  '
      );
      
      IF self.parm_description IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'description: ' || dz_swagger_util.yaml_text(self.parm_description,num_pretty_print)
            ,num_pretty_print
            ,'  '
         );
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Write the enums if required 
      --------------------------------------------------------------------------
      IF self.parm_enums_string IS NOT NULL
      AND self.parm_enums_string.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'enum: '
            ,num_pretty_print
            ,'  '
         );
         
         FOR i IN 1 .. self.parm_enums_string.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty_str(
                '- ' || dz_swagger_util.yaml_text(self.parm_enums_string(i),num_pretty_print)
               ,num_pretty_print
               ,'  '
            );
         
         END LOOP;
 
      ELSIF self.parm_enums_number IS NOT NULL
      AND self.parm_enums_number.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'enum: '
            ,num_pretty_print
            ,'  '
         );
         
         FOR i IN 1 .. self.parm_enums_number.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                '- ' || dz_json_main.json_format(self.parm_enums_number(i))
               ,num_pretty_print
               ,'  '
            );
         
         END LOOP;
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add optional default value
      --------------------------------------------------------------------------
      IF self.parm_default_string IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'default: ' || dz_swagger_util.yaml_text(self.parm_default_string,num_pretty_print)
            ,num_pretty_print
            ,'  '
         );
      
      ELSIF self.parm_default_number IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'default: ' || dz_json_main.json_format(self.parm_default_number)
            ,num_pretty_print
            ,'  '
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Finish the type and required elements
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'type: ' || self.parm_type
         ,num_pretty_print
         ,'  '
      );
         
      IF self.parm_required IS NOT NULL
      AND self.parm_required = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'required: true'
            ,num_pretty_print
            ,'  '
         );
      
      ELSE
         clb_output := clb_output || dz_json_util.pretty_str(
             'required: false'
            ,num_pretty_print
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

