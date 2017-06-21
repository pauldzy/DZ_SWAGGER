CREATE OR REPLACE TYPE dz_swagger_response_typ FORCE
AUTHID DEFINER 
AS OBJECT (
    versionid            VARCHAR2(40 Char)
   ,swagger_path         VARCHAR2(255 Char)
   ,swagger_http_method  VARCHAR2(255 Char)
   ,swagger_response     VARCHAR2(255 Char)
   ,response_description VARCHAR2(4000 Char)
   ,response_schema_def  VARCHAR2(255 Char)  
   ,response_schema_type VARCHAR2(255 Char) 
   ,response_schema_obj  dz_swagger_definition_typ    
  
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_response_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_response_typ(
       p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_swagger_response     IN  VARCHAR2
      ,p_response_description IN  VARCHAR2
      ,p_response_schema_def  IN  VARCHAR2
      ,p_response_schema_type IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
        p_pretty_print      IN  NUMBER   DEFAULT NULL
    ) RETURN CLOB

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print      IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_response_typ TO public;

