CREATE OR REPLACE VIEW dz_swagger_paths_trunk(
   csv_output
)
AS
SELECT
'"path","summary","description","last_updated","author","notes"' AS csv_output
FROM 
dual
UNION ALL
SELECT
'"' || a.swagger_path || '","' || a.path_summary || '","' || a.path_description || '","' || a.path_desc_updated || '","' || a.path_desc_author|| '","' || a.path_desc_notes || '"'
FROM (
   SELECT
    aa.swagger_path
   ,REPLACE(aa.path_summary,'"','""') AS path_summary
   ,REPLACE(aa.path_description,'"','""') AS path_description
   ,aa.path_desc_updated
   ,aa.path_desc_author
   ,aa.path_desc_notes
   FROM
   dz_swagger_path aa
   WHERE
   aa.versionid = 'TRUNK'
   GROUP BY
    aa.swagger_path
   ,REPLACE(aa.path_summary,'"','""')
   ,REPLACE(aa.path_description,'"','""')
   ,aa.path_desc_updated
   ,aa.path_desc_author
   ,aa.path_desc_notes
   ORDER BY
    aa.swagger_path
) a;

