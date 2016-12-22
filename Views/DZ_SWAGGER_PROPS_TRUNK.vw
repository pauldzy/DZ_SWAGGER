CREATE OR REPLACE VIEW dz_swagger_defs_trunk(
   csv_output
)
AS
SELECT '"endpoint","method","response","parent","name","type","format","example","title","description","last_updated","author","notes"' AS csv_output
FROM 
dual
UNION ALL
SELECT '"'
    || a.swagger_path
    || '","'
    || a.swagger_http_method
    || '","'
    || a.swagger_response
    || '","'
    || a.parent_def
    || '","'
    || a.def_property
    || '","'
    || a.def_type
    || '","'
    || a.def_format
    || '","'
    || a.def_example
    || '","'
    || a.def_title
    || '","'
    || a.def_description
    || '","'
    || a.def_desc_updated
    || '","'
    || a.def_desc_author
    || '","'
    || a.def_desc_notes
    || '"'
FROM (  
   SELECT 
    aa.swagger_path
   ,aa.swagger_http_method
   ,aa.swagger_response
   ,( SELECT 
      ee.def_property
      FROM 
      dz_swagger_def_props ee
      WHERE 
      ee.def_property_id = bb.priorprop
    ) AS parent_def
   ,bb.def_property
   ,bb.def_type
   ,bb.def_format
   ,bb.def_example
   ,bb.def_title
   ,REPLACE(bb.def_description,'"','""') AS def_description
   ,bb.def_desc_updated
   ,bb.def_desc_author
   ,REPLACE(bb.def_desc_notes,'"','""') AS def_desc_notes
   ,bb.def_property_id
   FROM 
   dz_swagger_path_resp aa
   JOIN (
      SELECT 
       CONNECT_BY_ROOT(ccc.swagger_def) AS rootdef
      ,PRIOR ccc.def_property_id        AS priorprop
      ,LEVEL                            AS rootlevel
      ,ccc.swagger_def
      ,ccc.swagger_def_type
      ,ccc.def_property_id
      ,ccc.def_property_order
      ,ddd.def_property
      ,ddd.def_type
      ,ddd.def_format
      ,CASE
       WHEN ddd.def_example_number IS NOT NULL
       THEN
         TO_CHAR (ddd.def_example_number)
       ELSE
         ddd.def_example_string
       END AS def_example
      ,ddd.def_title
      ,ddd.def_description
      ,ddd.def_desc_updated
      ,ddd.def_desc_author
      ,ddd.def_desc_notes
      ,ddd.def_reference
      FROM 
      dz_swagger_def ccc
      JOIN 
      dz_swagger_def_props ddd
      ON 
      ccc.def_property_id = ddd.def_property_id
      WHERE 
          ccc.versionid = 'TRUNK' 
      AND ddd.versionid = 'TRUNK'
      START WITH (
          ccc.versionid
         ,ccc.swagger_def
         ,ccc.swagger_def_type
      ) IN (
         SELECT 
          cccc.versionid
         ,cccc.response_schema_def
         ,cccc.response_schema_type
         FROM 
         dz_swagger_path_resp cccc
         WHERE     
             cccc.versionid = 'TRUNK'
         AND cccc.response_schema_type = 'object'
      )
      CONNECT BY PRIOR ddd.def_reference = ccc.swagger_def
      ORDER BY 
       CONNECT_BY_ROOT(ccc.swagger_def)
      ,LEVEL
      ,ccc.swagger_def
      ,ccc.def_property_order
   ) bb
   ON 
   aa.response_schema_def = bb.rootdef
   WHERE
       aa.versionid = 'TRUNK'
   AND aa.response_schema_type = 'object'
   ORDER BY 
    aa.swagger_path
   ,bb.swagger_def
   ,bb.def_property_order
) a;

