CREATE OR REPLACE VIEW dz_swagger_heads_trunk(
   csv_output
)
AS
SELECT
'"header_id","header_title","header_description","header_version","last_updated","author","notes","component_endpoints"' AS csv_output
FROM 
dual
UNION ALL
SELECT
'"' || a.header_id || '","' || a.info_title || '","' || a.info_description || '","' || a.info_version || '","' || a.info_desc_updated || '","' || a.info_desc_author || '","' || a.info_desc_notes || '","' || a.swagger_path || '"'
FROM (
   SELECT
    aa.header_id || '1' AS sorter
   ,aa.header_id
   ,aa.info_title
   ,aa.info_description 
   ,aa.info_version
   ,aa.info_desc_updated
   ,aa.info_desc_author
   ,aa.info_desc_notes
   ,aa.swagger_path
   FROM (
      SELECT
       aaa.header_id || '1' AS sorter
      ,aaa.header_id
      ,aaa.info_title
      ,REPLACE(aaa.info_description,'"','""') AS info_description
      ,aaa.info_version
      ,aaa.info_desc_updated
      ,aaa.info_desc_author
      ,aaa.info_desc_notes
      ,NULL AS swagger_path
      FROM
      dz_swagger_head aaa
      WHERE
      aaa.versionid = 'TRUNK'
      UNION ALL
      SELECT
       bbb.header_id || '2' AS sorter
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,ccc.swagger_path
      FROM
      dz_swagger_head bbb
      JOIN
      dz_swagger_path ccc
      ON 
          bbb.versionid = ccc.versionid
      AND bbb.header_id = ccc.path_group_id
      WHERE
      bbb.versionid = 'TRUNK'
      UNION ALL
      SELECT
       ddd.header_id || '3' AS sorter
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL
      ,NULL AS swagger_path
      FROM
      dz_swagger_head ddd
      WHERE
      ddd.versionid = 'TRUNK'
   ) aa
   ORDER BY
    aa.sorter
   ,aa.swagger_path
) a;

