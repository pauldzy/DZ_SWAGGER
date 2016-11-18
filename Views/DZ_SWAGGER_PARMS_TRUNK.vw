CREATE OR REPLACE VIEW dz_swagger_parms_trunk(
   csv_output
)
AS
SELECT
'"endpoint","name","description","data_type","default_value","enum_values","required","last_updated","author","notes","internal_id"' AS csv_output
FROM 
dual
UNION ALL
SELECT
'"' || a.swagger_path || '","' || a.swagger_parm || '","' || a.parm_description || '","' 
|| a.parm_type || '","' || a.parm_default || '","' || a.parameter_enum_values || '","' || a.parm_required || '","' 
|| a.parm_description || '","' || a.parm_desc_updated || '","' || a.parm_desc_author || '","' || a.parm_desc_notes|| '","' || a.swagger_parm_id || '"'
FROM (
   SELECT
    aa.swagger_path || '2' AS sorter
   ,bb.path_param_sort
   ,NULL AS swagger_path
   ,cc.swagger_parm
   ,REPLACE(cc.parm_description,'"','""') AS parm_description
   ,cc.parm_type
   ,CASE 
    WHEN cc.parm_type IN ('number')
    THEN
       TO_CHAR(cc.parm_default_number)
    ELSE
       cc.parm_default_string
    END AS parm_default
   ,(
      SELECT 
      LISTAGG(aaa.enum_value,',') WITHIN GROUP (ORDER BY aaa.enum_value) 
      FROM (
         SELECT
         aaaa.swagger_parm_id
         ,CASE 
          WHEN aaaa.enum_value_number IS NOT NULL
          THEN
            TO_CHAR(aaaa.enum_value_number)
          ELSE
            aaaa.enum_value_string
          END AS enum_value
         FROM
         dz_swagger_parm_enum aaaa
      ) aaa
      WHERE
      aaa.swagger_parm_id = bb.swagger_parm_id
    ) AS parameter_enum_values
   ,cc.parm_required
   ,cc.parm_desc_updated
   ,cc.parm_desc_author
   ,cc.parm_desc_notes
   ,cc.swagger_parm_id
   FROM
   dz_swagger_path aa
   JOIN
   dz_swagger_path_parm bb
   ON
       bb.versionid = aa.versionid
   AND bb.swagger_path = aa.swagger_path
   JOIN
   dz_swagger_parm cc
   ON
       cc.versionid = aa.versionid
   AND cc.swagger_parm_id = bb.swagger_parm_id
   WHERE
       aa.versionid = 'TRUNK'
   AND cc.parm_undocumented = 'FALSE'
   UNION ALL
   SELECT
    aa.swagger_path || '1' AS sorter
   ,0 AS path_param_sort
   ,aa.swagger_path
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   ,NULL
   FROM
   dz_swagger_path aa
   WHERE
   aa.versionid = 'TRUNK'
   ORDER BY
    1
   ,2
) a;
