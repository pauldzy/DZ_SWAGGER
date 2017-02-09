CREATE OR REPLACE TYPE dz_swagger_jsonsch_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid             VARCHAR2(40 Char)
   ,swagger_path          VARCHAR2(255 Char)
   ,swagger_http_method   VARCHAR2(255 Char)
   ,swagger_response      VARCHAR2(255 Char)
   ,response_schema_obj   dz_swagger_definition_typ
   ,swagger_defs          dz_swagger_definition_list
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_jsonsch_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_jsonsch_typ(
       p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_swagger_response     IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
       p_pretty_print      IN  NUMBER   DEFAULT NULL
    ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_jsonsch_typ TO public;

