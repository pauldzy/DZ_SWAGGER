CREATE OR REPLACE TYPE dz_swagger_method_typ FORCE
AUTHID DEFINER 
AS OBJECT (
    versionid           VARCHAR2(40 Char)
   ,swagger_path        VARCHAR2(255 Char)
   ,swagger_http_method VARCHAR2(255 Char)
   ,path_summary        VARCHAR2(4000 Char)
   ,path_description    VARCHAR2(4000 Char)
   ,method_path_parms   dz_swagger_parm_list
   ,method_tags         MDSYS.SDO_STRING2_ARRAY
   ,method_responses    dz_swagger_response_list
  
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_method_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_method_typ(
       p_swagger_path        IN  VARCHAR2
      ,p_swagger_http_method IN  VARCHAR2
      ,p_path_summary        IN  VARCHAR2
      ,p_path_description    IN  VARCHAR2
      ,p_versionid           IN  VARCHAR2
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

GRANT EXECUTE ON dz_swagger_method_typ TO public;

