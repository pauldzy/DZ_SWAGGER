CREATE OR REPLACE FORCE VIEW dz_swagger_issues_trunk(
   issue_type
  ,issue_description
)
AS
SELECT 
 'Parameters' AS issue_type
,a.column_value AS issue_description
FROM 
TABLE (dz_swagger_maint.validate_path_object_parms()) a
UNION ALL
SELECT
 'Definitions'
,b.column_value
FROM 
TABLE (dz_swagger_maint.validate_def_tables()) b;

