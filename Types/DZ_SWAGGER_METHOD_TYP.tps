CREATE OR REPLACE TYPE dz_swagger_method_typ FORCE
AUTHID DEFINER 
AS OBJECT (
    versionid           VARCHAR2(40 Char)
   ,swagger_path        VARCHAR2(255 Char)
   ,swagger_http_method VARCHAR2(255 Char)
   ,path_summary        VARCHAR2(4000 Char)
   ,path_description    VARCHAR2(4000 Char)
   ,consumes_json       VARCHAR2(5 Char)
   ,consumes_xml        VARCHAR2(5 Char)
   ,consumes_form       VARCHAR2(5 Char)
   ,produces_json       VARCHAR2(5 Char)
   ,produces_xml        VARCHAR2(5 Char)
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
      ,p_consumes_json       IN  VARCHAR2
      ,p_consumes_xml        IN  VARCHAR2
      ,p_consumes_form       IN  VARCHAR2
      ,p_produces_json       IN  VARCHAR2
      ,p_produces_xml        IN  VARCHAR2
      ,p_versionid           IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
       p_pretty_print        IN  INTEGER  DEFAULT NULL
      ,p_zap_override        IN  VARCHAR2 DEFAULT 'FALSE'
   ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
       p_pretty_print        IN  INTEGER  DEFAULT 0
      ,p_zap_override        IN  VARCHAR2 DEFAULT 'FALSE'
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_method_typ TO public;

