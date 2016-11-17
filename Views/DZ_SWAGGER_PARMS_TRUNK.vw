CREATE OR REPLACE VIEW dz_swagger_parms_trunk(
    endpoint 
   ,parameter_name
   ,parameter_description
   ,parameter_data_type
   ,parameter_default_value
   ,parameter_enum_values
   ,is_parameter_required
   ,description_last_updated
   ,description_author
   ,description_notes
   ,internal_parm_id
)
AS
SELECT
 a.swagger_path
,c.swagger_parm
,c.parm_description
,c.parm_type
,CASE 
 WHEN c.parm_type IN ('number')
 THEN
    TO_CHAR(c.parm_default_number)
 ELSE
    c.parm_default_string
 END AS parm_default
,(
   SELECT 
   LISTAGG(enum_value,',') WITHIN GROUP (ORDER BY enum_value) 
   FROM (
      SELECT
      aaa.swagger_parm_id
      ,CASE 
       WHEN aaa.enum_value_number IS NOT NULL
       THEN
         TO_CHAR(aaa.enum_value_number)
       ELSE
         aaa.enum_value_string
       END AS enum_value
      FROM
      dz_swagger_parm_enum aaa
   ) aa
   WHERE
   aa.swagger_parm_id = b.swagger_parm_id
 ) AS parameter_enum_values
,c.parm_required
,c.parm_desc_updated
,c.parm_desc_author
,c.parm_desc_notes
,c.swagger_parm_id
FROM
dz_swagger_path a
JOIN
dz_swagger_path_parm b
ON
    b.versionid = a.versionid
AND b.swagger_path = a.swagger_path
JOIN
dz_swagger_parm c
ON
    c.versionid = a.versionid
AND c.swagger_parm_id = b.swagger_parm_id
WHERE
a.versionid = 'TRUNK'
AND c.parm_undocumented = 'FALSE'
ORDER BY
 a.swagger_path
,b.path_param_sort;
