CREATE OR REPLACE VIEW dz_swagger_resp_trunk(
   csv_output
)
AS
SELECT
'"path","method","response","description","last_updated","author","notes"' AS csv_output
FROM 
dual
UNION ALL
SELECT
'"' || a.swagger_path || '","' || a.swagger_http_method || '","' || a.swagger_response || '","' || a.response_description || '","' || a.response_desc_updated || '","' || a.response_desc_author|| '","' || a.response_desc_notes || '"'
FROM (
   SELECT
    aa.swagger_path
   ,aa.swagger_http_method
   ,aa.swagger_response
   ,REPLACE(aa.response_description,'"','""') AS response_description
   ,aa.response_desc_updated
   ,aa.response_desc_author
   ,aa.response_desc_notes
   FROM
   dz_swagger_path_resp aa
   WHERE
   aa.versionid = 'TRUNK'
   ORDER BY
   aa.swagger_path
) a;

