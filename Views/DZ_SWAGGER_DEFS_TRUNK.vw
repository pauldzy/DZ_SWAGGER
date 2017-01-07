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
    || a.property
    || '","'
    || a.property_type
    || '","'
    || a.property_format
    || '","'
    || a.property_example
    || '","'
    || a.property_title
    || '","'
    || a.property_description
    || '","'
    || a.property_desc_updated
    || '","'
    || a.property_desc_author
    || '","'
    || a.property_desc_notes
    || '"'
FROM (  
   SELECT 
    aa.swagger_path
   ,aa.swagger_http_method
   ,aa.swagger_response
   ,( SELECT 
      ee.property
      FROM 
      dz_swagger_property ee
      WHERE 
      ee.property_id = bb.priorprop
    ) AS parent_def
   ,bb.property
   ,bb.property_type
   ,bb.property_format
   ,bb.property_example
   ,bb.property_title
   ,REPLACE(bb.property_description,'"','""') AS property_description
   ,bb.property_desc_updated
   ,bb.property_desc_author
   ,REPLACE(bb.property_desc_notes,'"','""') AS property_desc_notes
   ,bb.property_id
   FROM 
   dz_swagger_path_resp aa
   JOIN (
      SELECT 
       CONNECT_BY_ROOT(ccc.definition) AS rootdef
      ,PRIOR ccc.property_id           AS priorprop
      ,LEVEL                           AS rootlevel
      ,ccc.definition
      ,ccc.definition_type
      ,ccc.property_id
      ,ccc.property_order
      ,ddd.property
      ,ddd.property_type
      ,ddd.property_format
      ,CASE
       WHEN ddd.property_exp_number IS NOT NULL
       THEN
         TO_CHAR (ddd.property_exp_number)
       ELSE
         ddd.property_exp_string
       END AS property_example
      ,ddd.property_title
      ,ddd.property_description
      ,ddd.property_desc_updated
      ,ddd.property_desc_author
      ,ddd.property_desc_notes
      ,ddd.property_reference
      FROM 
      dz_swagger_def_prop ccc
      JOIN 
      dz_swagger_property ddd
      ON 
      ccc.property_id = ddd.property_id
      WHERE 
          ccc.versionid = 'TRUNK' 
      AND ddd.versionid = 'TRUNK'
      START WITH (
          ccc.versionid
         ,ccc.definition
         ,ccc.definition_type
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
      CONNECT BY PRIOR ddd.property_reference = ccc.definition
      ORDER BY 
       CONNECT_BY_ROOT(ccc.definition)
      ,LEVEL
      ,ccc.definition
      ,ccc.property_order
   ) bb
   ON 
   aa.response_schema_def = bb.rootdef
   WHERE
       aa.versionid = 'TRUNK'
   AND aa.response_schema_type = 'object'
   ORDER BY 
    aa.swagger_path
   ,bb.definition
   ,bb.property_order
) a;

