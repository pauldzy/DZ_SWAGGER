CREATE OR REPLACE TYPE BODY dz_swagger_typ
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_typ
   RETURN SELF AS RESULT
   AS
   BEGIN
      RETURN;

   END dz_swagger_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_typ(
       p_header_id        IN  VARCHAR2
      ,p_path_group_id    IN  VARCHAR2 DEFAULT NULL
      ,p_versionid        IN  VARCHAR2 DEFAULT NULL
   ) RETURN SELF AS RESULT
   AS
      str_path_group_id VARCHAR2(4000 Char);
      str_versionid     VARCHAR2(40 Char) := p_versionid;

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      IF p_path_group_id IS NULL
      THEN
         str_path_group_id := p_header_id;

      ELSE
         str_path_group_id := p_path_group_id;

      END IF;

      --------------------------------------------------------------------------
      -- Step 20
      -- Determine the default version if not provided
      --------------------------------------------------------------------------
      IF str_versionid IS NULL
      THEN
         BEGIN
            SELECT
            a.versionid
            INTO str_versionid
            FROM
            dz_swagger_vers a
            WHERE
                a.is_default = 'TRUE'
            AND rownum <= 1;

         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RAISE;

         END;

      END IF;

      --------------------------------------------------------------------------
      -- Step 30
      -- Fetch the header record from dz_swagger_head
      --------------------------------------------------------------------------
      SELECT dz_swagger_typ(
          p_path_group_id       => str_path_group_id
         ,p_swagger_info        => dz_swagger_info(
             p_info_title          => a.info_title
            ,p_info_description    => REGEXP_REPLACE(a.info_description,'(' || CHR(10) || '|' || CHR(13) || ')$','')
            ,p_info_termsofservice => a.info_termsofservice
            ,p_info_contact        => dz_swagger_info_contact(
                p_contact_name     => a.info_contact_name
               ,p_contact_url      => a.info_contact_url
               ,p_contact_email    => a.info_contact_email
             )
            ,p_info_license        => dz_swagger_info_license(
                p_license_name     => a.info_license_name
               ,p_license_url      => a.info_license_url
            )
            ,p_info_version        => a.info_version
         )
         ,p_swagger_host        => a.swagger_host
         ,p_swagger_basepath    => a.swagger_basepath
         ,p_schemes_https       => a.schemes_https
         ,p_consumes_json       => a.consumes_json
         ,p_consumes_xml        => a.consumes_xml
         ,p_consumes_form       => a.consumes_form
         ,p_produces_json       => a.produces_json
         ,p_produces_xml        => a.produces_xml
         ,p_versionid           => a.versionid
      )
      INTO self
      FROM
      dz_swagger_head a
      WHERE
          a.versionid = str_versionid
      AND a.header_id = p_header_id;

      RETURN;

   END dz_swagger_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_typ(
       p_path_group_id       IN  VARCHAR2
      ,p_swagger_info        IN  dz_swagger_info
      ,p_swagger_host        IN  VARCHAR2
      ,p_swagger_basepath    IN  VARCHAR2
      ,p_schemes_https       IN  VARCHAR2
      ,p_consumes_json       IN  VARCHAR2
      ,p_consumes_xml        IN  VARCHAR2
      ,p_consumes_form       IN  VARCHAR2
      ,p_produces_json       IN  VARCHAR2
      ,p_produces_xml        IN  VARCHAR2
      ,p_versionid           IN  VARCHAR2
   ) RETURN SELF AS RESULT
   AS
      ary_groups MDSYS.SDO_STRING2_ARRAY;
      parm_pool  dz_swagger_parm_list;
      def_pool   dz_swagger_definition_list;

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------

      --------------------------------------------------------------------------
      -- Step 20
      -- Load the object
      --------------------------------------------------------------------------
      self.path_group_id       := p_path_group_id;
      self.swagger_info        := p_swagger_info;
      self.swagger_host        := p_swagger_host;
      self.swagger_basepath    := p_swagger_basepath;
      self.schemes_https       := p_schemes_https;
      self.consumes_json       := p_consumes_json;
      self.consumes_xml        := p_consumes_xml;
      self.consumes_form       := p_consumes_form;
      self.produces_json       := p_produces_json;
      self.produces_xml        := p_produces_xml;
      self.versionid           := p_versionid;

      --------------------------------------------------------------------------
      -- Step 30
      -- Parse the group id
      --------------------------------------------------------------------------
      ary_groups := dz_json_util.gz_split(
          p_str   => p_path_group_id
         ,p_regex => ','
      );

      --------------------------------------------------------------------------
      -- Step 40
      -- Bail if a problem with the groups
      --------------------------------------------------------------------------
      IF ary_groups IS NULL
      AND ary_groups.COUNT = 0
      THEN
         RETURN;

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Pull the list of paths
      --------------------------------------------------------------------------
      SELECT dz_swagger_path_typ(
          p_swagger_path     => a.swagger_path
         ,p_path_summary     => MAX(a.path_summary)
         ,p_path_description => MAX(a.path_description)
         ,p_versionid        => a.versionid
      )
      BULK COLLECT INTO
      self.swagger_paths
      FROM
      dz_swagger_path a
      WHERE
         a.versionid = self.versionid
      AND (
            ary_groups(1) = 'ALL'
         OR a.path_group_id IN (SELECT * FROM TABLE(ary_groups))
      )
      GROUP BY
       a.versionid
      ,a.swagger_path
      ORDER BY
      MAX(a.path_order);

      IF self.swagger_paths IS NULL
      OR self.swagger_paths.COUNT = 0
      THEN
         RETURN;

      END IF;

      --------------------------------------------------------------------------
      -- Step 60
      -- Load the paths subobjects
      --------------------------------------------------------------------------
      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         SELECT dz_swagger_method_typ(
             p_swagger_path        => a.swagger_path
            ,p_swagger_http_method => a.swagger_http_method
            ,p_path_summary        => self.swagger_paths(i).path_summary
            ,p_path_description    => self.swagger_paths(i).path_description
            ,p_consumes_json       => a.consumes_json
            ,p_consumes_xml        => a.consumes_xml
            ,p_consumes_form       => a.consumes_form
            ,p_produces_json       => a.produces_json
            ,p_produces_xml        => a.produces_xml
            ,p_versionid           => a.versionid
         )
         BULK COLLECT INTO
         self.swagger_paths(i).swagger_methods
         FROM (
            SELECT
             aa.versionid
            ,aa.swagger_path
            ,aa.swagger_http_method
            ,aa.consumes_json
            ,aa.consumes_xml
            ,aa.consumes_form
            ,aa.produces_json
            ,aa.produces_xml
            FROM
            dz_swagger_path_method aa
            WHERE
                aa.versionid    = self.swagger_paths(i).versionid
            AND aa.swagger_path = self.swagger_paths(i).swagger_path
         ) a
         ORDER BY
         a.swagger_http_method;

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 70
      -- Fill the parameter pool
      --------------------------------------------------------------------------
      SELECT dz_swagger_parm_typ(
          p_swagger_parm_id      => a.swagger_parm_id
         ,p_swagger_parm         => a.swagger_parm
         ,p_parm_description     => REGEXP_REPLACE(a.parm_description,'(' || CHR(10) || '|' || CHR(13) || ')$','')
         ,p_parm_type            => a.parm_type
         ,p_parm_default_string  => a.parm_default_string
         ,p_parm_default_number  => a.parm_default_number
         ,p_parm_required        => a.parm_required
         ,p_parm_undocumented    => a.parm_undocumented
         ,p_swagger_path         => a.swagger_path
         ,p_swagger_http_method  => a.swagger_http_method
         ,p_parameter_in_type    => a.parameter_in_type
         ,p_path_param_sort      => a.path_param_sort
         ,p_param_sort           => a.param_sort
         ,p_inline_parm          => a.parm_move_inline
         ,p_versionid            => a.versionid
      )
      BULK COLLECT INTO parm_pool
      FROM (
         WITH parms AS (
            SELECT
             bb.swagger_parm_id
            ,bb.swagger_parm
            ,bb.parm_description
            ,bb.parm_type
            ,bb.parm_default_string
            ,bb.parm_default_number
            ,bb.parm_required
            ,bb.parm_undocumented
            ,aa.swagger_path
            ,aa.swagger_http_method
            ,aa.parameter_in_type
            ,aa.path_param_sort
            ,bb.param_sort
            ,bb.versionid
            FROM
            dz_swagger_path_parm aa
            JOIN
            dz_swagger_parm bb
            ON
            aa.swagger_parm_id = bb.swagger_parm_id
            WHERE
            (aa.versionid,aa.swagger_path,aa.swagger_http_method) IN (
               SELECT
                aaa.versionid
               ,aaa.swagger_path
               ,aaa.swagger_http_method
               FROM
               TABLE(self.all_methods()) aaa
            )
         )
         SELECT
          bb.swagger_parm_id
         ,bb.swagger_parm
         ,bb.parm_description
         ,bb.parm_type
         ,bb.parm_default_string
         ,bb.parm_default_number
         ,bb.parm_required
         ,bb.parm_undocumented
         ,bb.swagger_path
         ,bb.swagger_http_method
         ,bb.parameter_in_type
         ,bb.path_param_sort
         ,bb.param_sort
         ,CASE WHEN cc.parm_count > 1
          THEN
             'TRUE'
          ELSE
             'FALSE'
          END AS parm_move_inline
         ,bb.versionid
         FROM
         parms bb
         JOIN (
            SELECT
             ccc.swagger_parm
            ,ccc.swagger_http_method
            ,COUNT(*) AS parm_count
            FROM (
               SELECT
                cccc.swagger_parm_id
               ,cccc.swagger_parm
               ,cccc.swagger_http_method
               FROM
               parms cccc
               GROUP BY
                cccc.swagger_parm_id
               ,cccc.swagger_parm
               ,cccc.swagger_http_method
            ) ccc
            GROUP BY
             ccc.swagger_parm
            ,ccc.swagger_http_method
         ) cc
         ON
             bb.swagger_parm        = cc.swagger_parm
         AND bb.swagger_http_method = cc.swagger_http_method
      ) a;

      --------------------------------------------------------------------------
      -- Step 80
      -- Load the methods subobjects
      --------------------------------------------------------------------------
      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         FOR j IN 1 .. self.swagger_paths(i).swagger_methods.COUNT
         LOOP
            SELECT dz_swagger_parm_typ(
                p_swagger_parm_id      => a.swagger_parm_id
               ,p_swagger_parm         => a.swagger_parm
               ,p_parm_description     => a.parm_description
               ,p_parm_type            => a.parm_type
               ,p_parm_default_string  => a.parm_default_string
               ,p_parm_default_number  => a.parm_default_number
               ,p_parm_required        => a.parm_required
               ,p_parm_undocumented    => a.parm_undocumented
               ,p_swagger_path         => a.swagger_path
               ,p_swagger_http_method  => a.swagger_http_method
               ,p_parameter_in_type    => a.parameter_in_type
               ,p_path_param_sort      => a.path_param_sort
               ,p_param_sort           => a.param_sort
               ,p_inline_parm          => a.inline_parm
               ,p_versionid            => a.versionid
            )
            BULK COLLECT INTO
            self.swagger_paths(i).swagger_methods(j).method_path_parms
            FROM
            TABLE(parm_pool) a
            WHERE
                a.swagger_path        = self.swagger_paths(i).swagger_methods(j).swagger_path
            AND a.swagger_http_method = self.swagger_paths(i).swagger_methods(j).swagger_http_method
            ORDER BY
            a.path_param_sort;

            SELECT
            a.swagger_tag
            BULK COLLECT INTO
            self.swagger_paths(i).swagger_methods(j).method_tags
            FROM
            dz_swagger_path_tags a
            WHERE
                a.versionid           = self.swagger_paths(i).swagger_methods(j).versionid
            AND a.swagger_path        = self.swagger_paths(i).swagger_methods(j).swagger_path;

            SELECT dz_swagger_response_typ(
                p_swagger_path         => a.swagger_path
               ,p_swagger_http_method  => a.swagger_http_method
               ,p_swagger_response     => a.swagger_response
               ,p_response_description => a.response_description
               ,p_response_schema_def  => a.response_schema_def
               ,p_response_schema_type => a.response_schema_type
               ,p_versionid            => a.versionid
            )
            BULK COLLECT INTO
            self.swagger_paths(i).swagger_methods(j).method_responses
            FROM
            dz_swagger_path_resp a
            WHERE
                a.versionid           = self.swagger_paths(i).swagger_methods(j).versionid
            AND a.swagger_path        = self.swagger_paths(i).swagger_methods(j).swagger_path
            AND a.swagger_http_method = self.swagger_paths(i).swagger_methods(j).swagger_http_method;

         END LOOP;

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 100
      -- Shrink the pool of parms down to just unique items
      --------------------------------------------------------------------------
      SELECT dz_swagger_parm_typ(
          p_swagger_parm_id      => a.swagger_parm_id
         ,p_swagger_parm         => MAX(a.swagger_parm)
         ,p_parm_description     => MAX(a.parm_description)
         ,p_parm_type            => MAX(a.parm_type)
         ,p_parm_default_string  => MAX(a.parm_default_string)
         ,p_parm_default_number  => MAX(a.parm_default_number)
         ,p_parm_required        => MAX(a.parm_required)
         ,p_parm_undocumented    => MAX(a.parm_undocumented)
         ,p_swagger_path         => NULL
         ,p_swagger_http_method  => NULL
         ,p_parameter_in_type    => a.parameter_in_type
         ,p_path_param_sort      => NULL
         ,p_param_sort           => MAX(a.param_sort)
         ,p_inline_parm          => 'FALSE'
         ,p_versionid            => a.versionid
      )
      BULK COLLECT INTO self.swagger_parms
      FROM
      TABLE(parm_pool) a
      WHERE
      a.inline_parm = 'FALSE'
      GROUP BY
       a.versionid
      ,a.swagger_parm_id
      ,a.parameter_in_type
      ORDER BY
      MAX(a.param_sort);

      parm_pool := dz_swagger_parm_list();

      --------------------------------------------------------------------------
      -- Step 110
      -- Get the universe of definitions
      --------------------------------------------------------------------------
      SELECT dz_swagger_definition_typ(
          p_definition          => a.definition
         ,p_definition_type     => a.definition_type
         ,p_definition_title    => a.definition_title
         ,p_definition_desc     => a.definition_desc
         ,p_inline_def          => a.inline_def
         ,p_xml_name            => a.xml_name
         ,p_xml_namespace       => a.xml_namespace
         ,p_xml_prefix          => a.xml_prefix
         ,p_xml_wrapped         => a.xml_wrapped
         ,p_versionid           => a.versionid
      )
      BULK COLLECT INTO def_pool
      FROM (
         SELECT
          aa.definition
         ,aa.definition_type
         ,aa.definition_title
         ,aa.definition_desc
         ,aa.inline_def
         ,aa.xml_name
         ,aa.xml_namespace
         ,aa.xml_prefix
         ,aa.xml_wrapped
         ,aa.versionid
         FROM (
            SELECT
             aaa.definition
            ,aaa.definition_type
            ,aaa.definition_title
            ,aaa.definition_desc
            ,'TRUE' AS inline_def
            ,aaa.xml_name
            ,aaa.xml_namespace
            ,aaa.xml_prefix
            ,aaa.xml_wrapped
            ,aaa.versionid
            FROM
            dz_swagger_definition aaa
            WHERE
            (aaa.versionid,aaa.definition,aaa.definition_type) IN (
               SELECT
                bbb.versionid
               ,bbb.response_schema_def
               ,bbb.response_schema_type
               FROM
               TABLE(self.all_responses()) bbb
            )
            UNION ALL SELECT
             aaa.definition
            ,aaa.definition_type
            ,aaa.definition_title
            ,aaa.definition_desc
            ,'FALSE' AS inline_def
            ,aaa.xml_name
            ,aaa.xml_namespace
            ,aaa.xml_prefix
            ,aaa.xml_wrapped
            ,aaa.versionid
            FROM
            dz_swagger_definition aaa
            WHERE
            (aaa.versionid,aaa.definition) IN (
               SELECT
                ddd.versionid
               ,ddd.property_target
               FROM
               dz_swagger_def_prop ccc
               JOIN
               dz_swagger_property ddd
               ON
               ccc.property_id = ddd.property_id
               WHERE
                   ccc.versionid = self.versionid
               AND ddd.versionid = self.versionid
               AND ddd.property_target IS NOT NULL
               START WITH (ccc.versionid,ccc.definition,ccc.definition_type) IN (
                  SELECT
                   cccc.versionid
                  ,cccc.response_schema_def
                  ,cccc.response_schema_type
                  FROM
                  TABLE(self.all_responses()) cccc
                  WHERE
                  cccc.response_schema_type = 'object'
               )
               CONNECT BY PRIOR
               ddd.property_target = ccc.definition
               GROUP BY
                ddd.versionid
               ,ddd.property_target
            )
         ) aa
      ) a;

      --------------------------------------------------------------------------
      -- Step 120
      -- Add the properties to the definitions
      --------------------------------------------------------------------------
      FOR i IN 1 .. def_pool.COUNT
      LOOP
         
         SELECT dz_swagger_property_typ(
             p_property_id          => a.property_id
            ,p_property             => b.property
            ,p_property_type	      => b.property_type
            ,p_property_format      => b.property_format
            ,p_property_allow_null  => b.property_allow_null
            ,p_property_title       => REGEXP_REPLACE(b.property_title,'(' || CHR(10) || '|' || CHR(13) || ')$','')
            ,p_property_exp_string  => b.property_exp_string
            ,p_property_exp_number  => b.property_exp_number
            ,p_property_description => b.property_description
            ,p_property_target      => b.property_target
            ,p_property_required    => a.property_required
            ,p_xml_name             => b.xml_name
            ,p_xml_namespace        => b.xml_namespace
            ,p_xml_prefix           => b.xml_prefix
            ,p_xml_attribute        => b.xml_attribute
            ,p_xml_wrapped          => b.xml_wrapped
            ,p_xml_array_name       => b.xml_array_name
            ,p_versionid            => a.versionid
         )
         BULK COLLECT INTO def_pool(i).swagger_properties
         FROM
         dz_swagger_def_prop a
         LEFT JOIN
         dz_swagger_property b
         ON
         a.property_id = b.property_id
         WHERE
             a.versionid       = def_pool(i).versionid
         AND b.versionid       = def_pool(i).versionid
         AND a.definition      = def_pool(i).definition
         AND a.definition_type = def_pool(i).definition_type
         ORDER BY
         a.property_order;

         IF  def_pool(i).swagger_properties IS NOT NULL
         AND def_pool(i).swagger_properties.COUNT > 1
         AND def_pool(i).swagger_properties(1).property_type = 'reference'
         THEN
            def_pool(i).inline_def := 'FALSE';

         END IF;
         
      END LOOP;

      --------------------------------------------------------------------------
      -- Step 130
      -- Load the response subobjects
      --------------------------------------------------------------------------
      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         FOR j IN 1 .. self.swagger_paths(i).swagger_methods.COUNT
         LOOP
            FOR k IN 1 .. self.swagger_paths(i).swagger_methods(j).method_responses.COUNT
            LOOP
               BEGIN
                  SELECT dz_swagger_definition_typ(
                      p_definition          => a.definition
                     ,p_definition_type     => a.definition_type
                     ,p_definition_title    => a.definition_title
                     ,p_definition_desc     => a.definition_desc
                     ,p_inline_def          => a.inline_def
                     ,p_xml_name            => a.xml_name
                     ,p_xml_namespace       => a.xml_namespace
                     ,p_xml_prefix          => a.xml_prefix
                     ,p_xml_wrapped         => a.xml_wrapped
                     ,p_versionid           => a.versionid
                     ,p_swagger_properties  => a.swagger_properties
                  )
                  INTO
                  self.swagger_paths(i).swagger_methods(j).method_responses(k).response_schema_obj
                  FROM
                  TABLE(def_pool) a
                  WHERE
                      a.definition      = self.swagger_paths(i).swagger_methods(j).method_responses(k).response_schema_def
                  AND a.definition_type = self.swagger_paths(i).swagger_methods(j).method_responses(k).response_schema_type;

               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;

               END;

            END LOOP;

         END LOOP;

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 140
      -- Filter the defs down to only objects
      --------------------------------------------------------------------------
      SELECT
      dz_swagger_definition_typ(
          p_definition          => a.definition
         ,p_definition_type     => a.definition_type
         ,p_definition_title    => a.definition_title
         ,p_definition_desc     => a.definition_desc
         ,p_inline_def          => a.inline_def
         ,p_xml_name            => a.xml_name
         ,p_xml_namespace       => a.xml_namespace
         ,p_xml_prefix          => a.xml_prefix
         ,p_xml_wrapped         => a.xml_wrapped
         ,p_versionid           => a.versionid
         ,p_swagger_properties  => a.swagger_properties
      )
      BULK COLLECT INTO self.swagger_defs
      FROM
      TABLE(def_pool) a
      WHERE
      a.definition_type IN ('object')
      ORDER BY
      a.definition;

      RETURN;

   END dz_swagger_typ;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION all_methods
   RETURN dz_swagger_method_list
   AS
      list_output dz_swagger_method_list;
      int_index   PLS_INTEGER;

   BEGIN
      IF self.swagger_paths IS NULL
      OR self.swagger_paths.COUNT = 0
      THEN
         RETURN NULL;

      END IF;

      int_index   := 0;
      list_output := dz_swagger_method_list();

      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         IF  self.swagger_paths(i).swagger_methods IS NOT NULL
         AND self.swagger_paths(i).swagger_methods.COUNT > 0
         THEN
            FOR j IN 1 .. self.swagger_paths(i).swagger_methods.COUNT
            LOOP
               list_output.EXTEND();
               int_index := int_index + 1;
               list_output(int_index) := self.swagger_paths(i).swagger_methods(j);

            END LOOP;

         END IF;

      END LOOP;

      RETURN list_output;

   END all_methods;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION all_responses
   RETURN dz_swagger_response_list
   AS
      list_output dz_swagger_response_list;
      int_index   PLS_INTEGER;

   BEGIN
      IF self.swagger_paths IS NULL
      OR self.swagger_paths.COUNT = 0
      THEN
         RETURN NULL;

      END IF;

      int_index   := 0;
      list_output := dz_swagger_response_list();

      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         IF  self.swagger_paths(i).swagger_methods IS NOT NULL
         AND self.swagger_paths(i).swagger_methods.COUNT > 0
         THEN
            FOR j IN 1 .. self.swagger_paths(i).swagger_methods.COUNT
            LOOP
               IF  self.swagger_paths(i).swagger_methods(j).method_responses IS NOT NULL
               AND self.swagger_paths(i).swagger_methods(j).method_responses.COUNT > 0
               THEN
                  FOR k IN 1 .. self.swagger_paths(i).swagger_methods(j).method_responses.COUNT
                  LOOP
                     list_output.EXTEND();
                     int_index := int_index + 1;
                     list_output(int_index) := self.swagger_paths(i).swagger_methods(j).method_responses(k);

                  END LOOP;

               END IF;

            END LOOP;

         END IF;

      END LOOP;

      RETURN list_output;

   END all_responses;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   MEMBER FUNCTION toJSON(
       p_pretty_print      IN  INTEGER  DEFAULT NULL
      ,p_host_override_val IN  VARCHAR2 DEFAULT NULL
      ,p_zap_override      IN  VARCHAR2 DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      int_pretty_print  PLS_INTEGER := p_pretty_print;
      clb_output        CLOB;
      str_host          VARCHAR2(4000 Char);
      str_pad           VARCHAR2(1 Char);
      str_pad1          VARCHAR2(1 Char);
      str_pad2          VARCHAR2(1 Char);
      ary_schemes       MDSYS.SDO_STRING2_ARRAY;
      ary_consumes      MDSYS.SDO_STRING2_ARRAY;
      ary_produces      MDSYS.SDO_STRING2_ARRAY;
      int_index         PLS_INTEGER;
      c_swagger_version VARCHAR2(4 Char) := '2.0';

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------

      --------------------------------------------------------------------------
      -- Step 20
      -- Add the left bracket
      --------------------------------------------------------------------------
      IF int_pretty_print IS NULL
      THEN
         clb_output := dz_json_util.pretty('{',NULL);
         str_pad := '';

      ELSE
         clb_output := dz_json_util.pretty('{',-1);
         str_pad := ' ';

      END IF;

      --------------------------------------------------------------------------
      -- Step 30
      -- Add base attributes
      --------------------------------------------------------------------------
      str_pad1 := str_pad;

      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.value2json(
             'swagger'
            ,c_swagger_version
            ,int_pretty_print + 1
         )
         ,int_pretty_print + 1
      );
      str_pad1 := ',';

      clb_output := clb_output || dz_json_util.pretty(
          str_pad1 || dz_json_main.formatted2json(
              'info'
             ,self.swagger_info.toJSON(int_pretty_print + 1)
             ,int_pretty_print + 1
          )
         ,int_pretty_print + 1
      );
      str_pad1 := ',';

      --------------------------------------------------------------------------
      -- Step 80
      -- Override the host if needed
      --------------------------------------------------------------------------
      IF p_host_override_val IS NOT NULL
      THEN
         str_host := p_host_override_val;

      ELSE
         str_host := self.swagger_host;

      END IF;

      IF str_host IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'host'
                ,str_host
                ,int_pretty_print + 1
             )
            ,int_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 90
      -- Finish base attributes
      --------------------------------------------------------------------------
      IF self.swagger_basepath IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'basePath'
                ,self.swagger_basepath
                ,int_pretty_print + 1
             )
            ,int_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 30
      -- Build the schemes array
      --------------------------------------------------------------------------
      int_index := 0;
      ary_schemes := MDSYS.SDO_STRING2_ARRAY();
      IF self.schemes_https = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_schemes.EXTEND();
         ary_schemes(int_index) := 'https';

      END IF;

      IF ary_schemes IS NOT NULL
      AND ary_schemes.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'schemes'
                ,ary_schemes
                ,int_pretty_print + 1
             )
            ,int_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the consumes array
      --------------------------------------------------------------------------
      int_index := 0;
      ary_consumes := MDSYS.SDO_STRING2_ARRAY();
      IF self.consumes_json = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_consumes.EXTEND();
         ary_consumes(int_index) := 'application/json';

      END IF;

      IF self.consumes_xml = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_consumes.EXTEND();
         ary_consumes(int_index) := 'application/xml';

      END IF;
      
      IF self.consumes_form = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_consumes.EXTEND();
         ary_consumes(int_index) := 'application/x-www-form-urlencoded';

      END IF;

      IF ary_consumes IS NOT NULL
      AND ary_consumes.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'consumes'
                ,ary_consumes
                ,int_pretty_print + 1
             )
            ,int_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the produces array
      --------------------------------------------------------------------------
      int_index := 0;
      ary_produces := MDSYS.SDO_STRING2_ARRAY();
      IF self.produces_json = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_produces.EXTEND();
         ary_produces(int_index) := 'application/json';

      END IF;

      IF self.produces_xml = 'TRUE'
      THEN
         int_index := int_index + 1;
         ary_produces.EXTEND();
         ary_produces(int_index) := 'application/xml';

      END IF;

      IF ary_produces IS NOT NULL
      AND ary_produces.COUNT > 0
      THEN
         clb_output := clb_output ||  dz_json_util.pretty(
             str_pad1 || dz_json_main.value2json(
                 'produces'
                ,ary_produces
                ,int_pretty_print + 1
             )
            ,int_pretty_print + 1
         );
         str_pad1 := ',';

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the parameters
      --------------------------------------------------------------------------
      IF self.swagger_parms IS NULL
      OR self.swagger_parms.COUNT = 0
      THEN
         NULL;

      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('parameters',int_pretty_print) || '{'
            ,int_pretty_print + 1
         );
         str_pad1 := ',';

         str_pad2 := str_pad;
         FOR i IN 1 .. self.swagger_parms.COUNT
         LOOP
            IF  self.swagger_parms(i).inline_parm = 'FALSE'
            AND self.swagger_parms(i).parm_undocumented = 'FALSE'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad2 || '"' || self.swagger_parms(i).parameter_ref_id || '": ' || self.swagger_parms(i).toJSON(
                      p_pretty_print => int_pretty_print + 2
                     ,p_zap_override => p_zap_override
                   )
                  ,int_pretty_print + 2
               );
               str_pad2 := ',';

            END IF;

         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,int_pretty_print + 1
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 80
      -- Add the paths
      --------------------------------------------------------------------------
      IF self.swagger_paths IS NULL
      OR self.swagger_paths.COUNT = 0
      THEN
         NULL;

      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('paths',int_pretty_print) || '{'
            ,int_pretty_print + 1
         );
         str_pad1 := ',';

         str_pad2 := str_pad;
         FOR i IN 1 .. self.swagger_paths.COUNT
         LOOP
            clb_output := clb_output || dz_json_util.pretty(
                str_pad2 || self.swagger_paths(i).toJSON(
                   p_pretty_print => int_pretty_print + 2
                  ,p_zap_override => p_zap_override
                )
               ,int_pretty_print + 2
            );
            str_pad2 := ',';

         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
            ,int_pretty_print + 1
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 90
      -- Add the defs
      --------------------------------------------------------------------------
      IF self.swagger_defs IS NULL
      OR self.swagger_defs.COUNT = 0
      THEN
         NULL;

      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             str_pad1 || dz_json_main.fastname('definitions',int_pretty_print) || '{'
            ,int_pretty_print + 1
         );
         str_pad1 := ',';

         str_pad2 := str_pad;
         FOR i IN 1 .. self.swagger_defs.COUNT
         LOOP
            IF self.swagger_defs(i).inline_def = 'FALSE'
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   str_pad2 || '"' || dz_swagger_util.dzcondense(
                      self.swagger_defs(i).versionid
                     ,self.swagger_defs(i).definition
                   ) || '": ' || self.swagger_defs(i).toJSON(
                      p_pretty_print => int_pretty_print + 2
                   )
                  ,int_pretty_print + 2
               );
               str_pad2 := ',';

            END IF;

         END LOOP;

         clb_output := clb_output || dz_json_util.pretty(
             '}'
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
       p_host_override_val IN  VARCHAR2 DEFAULT NULL
      ,p_zap_override      IN  VARCHAR2 DEFAULT 'FALSE'
   ) RETURN CLOB
   AS
      clb_output        CLOB;
      c_swagger_version VARCHAR2(4 Char) := '2.0';
      str_host          VARCHAR2(4000 Char);
      int_counter       PLS_INTEGER;

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check incoming parameters
      --------------------------------------------------------------------------

      --------------------------------------------------------------------------
      -- Step 20
      -- Write the yaml
      --------------------------------------------------------------------------
      clb_output := dz_json_util.pretty_str(
          '---'
         ,0
         ,'  '
      ) || dz_json_util.pretty_str(
          'swagger: ' || dz_swagger_util.yaml_text(c_swagger_version,0)
         ,0
         ,'  '
      ) || dz_json_util.pretty_str(
          'info: '
         ,0
         ,'  '
      ) || self.swagger_info.toYAML(1);

      --------------------------------------------------------------------------
      -- Step 30
      -- Override the host if needed
      --------------------------------------------------------------------------
      IF p_host_override_val IS NOT NULL
      THEN
         str_host := p_host_override_val;

      ELSE
         str_host := self.swagger_host;

      END IF;

      IF str_host IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'host: ' || dz_swagger_util.yaml_text(str_host,0)
            ,0
            ,'  '
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 40
      -- Add the optional basepath
      --------------------------------------------------------------------------
      IF self.swagger_basepath IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'basePath: ' || dz_swagger_util.yaml_text(self.swagger_basepath,0)
            ,0
            ,'  '
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the schemes array
      --------------------------------------------------------------------------
      IF self.schemes_https = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'schemes: '
            ,0
            ,'  '
         );
         
         clb_output := clb_output || dz_json_util.pretty_str(
             '- https'
            ,1
            ,'  '
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 60
      -- Add the consumes array
      --------------------------------------------------------------------------
      IF self.consumes_json = 'TRUE'
      OR self.consumes_xml = 'TRUE'
      OR self.consumes_form = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'consumes: '
            ,0
            ,'  '
         );

         IF self.consumes_json = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                '- application/json'
               ,1
               ,'  '
            );

         END IF;

         IF self.consumes_xml = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                '- application/xml'
               ,1
               ,'  '
            );

         END IF;
         
         IF self.consumes_form = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                '- application/x-www-form-urlencoded'
               ,1
               ,'  '
            );

         END IF;
         
      END IF;

      --------------------------------------------------------------------------
      -- Step 70
      -- Add the produces array
      --------------------------------------------------------------------------
      IF self.produces_json = 'TRUE'
      OR self.produces_xml  = 'TRUE'
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'produces: '
            ,0
            ,'  '
         );

         IF self.produces_json = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                '- application/json'
               ,1
               ,'  '
            );

         END IF;

         IF self.produces_xml = 'TRUE'
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                '- application/xml'
               ,1
               ,'  '
            );

         END IF;
         
      END IF;

      --------------------------------------------------------------------------
      -- Step 80
      -- Do the parameters
      --------------------------------------------------------------------------
      IF self.swagger_parms IS NOT NULL
      AND self.swagger_parms.COUNT > 0
      THEN
         clb_output := clb_output || dz_json_util.pretty_str(
             'parameters: '
            ,0
            ,'  '
         );

         FOR i IN 1 .. self.swagger_parms.COUNT
         LOOP
            IF  self.swagger_parms(i).inline_parm = 'FALSE'
            AND (
               self.swagger_parms(i).parm_undocumented = 'FALSE' OR p_zap_override = 'TRUE'
            )
            THEN
               clb_output := clb_output || dz_json_util.pretty(
                   self.swagger_parms(i).parameter_ref_id || ': '
                  ,1
                  ,'  '
               ) || self.swagger_parms(i).toYAML(
                   p_pretty_print => 2
                  ,p_zap_override => p_zap_override
               );

            END IF;

         END LOOP;

      END IF;

      --------------------------------------------------------------------------
      -- Step 90
      -- Do the paths
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty_str(
          'paths: '
         ,0
         ,'  '
      );

      FOR i IN 1 .. self.swagger_paths.COUNT
      LOOP
         clb_output := clb_output || dz_json_util.pretty_str(
             '"' || self.swagger_paths(i).swagger_path || '": '
            ,1
            ,'  '
         ) || self.swagger_paths(i).toYAML(
             p_pretty_print => 2
            ,p_zap_override => p_zap_override
         );

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 100
      -- Do the definitions
      --------------------------------------------------------------------------
      IF self.swagger_defs IS NOT NULL
      AND self.swagger_defs.COUNT > 0
      THEN
         int_counter := 0;
         FOR i IN 1 .. self.swagger_defs.COUNT
         LOOP
            IF self.swagger_defs(i).inline_def = 'FALSE'
            THEN
               int_counter := int_counter + 1;

            END IF;

         END LOOP;

         IF int_counter > 0
         THEN
            clb_output := clb_output || dz_json_util.pretty_str(
                'definitions: '
               ,0
               ,'  '
            );

            FOR i IN 1 .. self.swagger_defs.COUNT
            LOOP
               IF self.swagger_defs(i).inline_def = 'FALSE'
               THEN
                  clb_output := clb_output || dz_json_util.pretty(
                      dz_swagger_util.dzcondense(
                         self.swagger_defs(i).versionid
                        ,self.swagger_defs(i).definition
                     ) || ': '
                     ,1
                     ,'  '
                  ) || self.swagger_defs(i).toYAML(
                     p_pretty_print => 2
                  );

               END IF;

            END LOOP;

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

