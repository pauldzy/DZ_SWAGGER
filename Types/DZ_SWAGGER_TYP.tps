CREATE OR REPLACE TYPE dz_swagger_typ FORCE
AUTHID DEFINER 
AS OBJECT (
    versionid           VARCHAR2(40 Char)
   ,path_group_id       VARCHAR2(255 Char)
   ,swagger_info        dz_swagger_info
   ,swagger_host        VARCHAR2(255 Char)
   ,swagger_basepath    VARCHAR2(255 Char)
   ,schemes_https       VARCHAR2(5 Char)
   ,consumes_json       VARCHAR2(5 Char)
   ,consumes_xml        VARCHAR2(5 Char)
   ,consumes_form       VARCHAR2(5 Char)
   ,produces_json       VARCHAR2(5 Char)
   ,produces_xml        VARCHAR2(5 Char)
   ,swagger_paths       dz_swagger_path_list
   ,swagger_parms       dz_swagger_parm_list
   ,swagger_defs        dz_swagger_definition_list
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_typ(
       p_header_id        IN  VARCHAR2
      ,p_path_group_id    IN  VARCHAR2 DEFAULT NULL
      ,p_versionid        IN  VARCHAR2 DEFAULT NULL
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_typ(
       p_path_group_id       IN  VARCHAR2
      ,p_swagger_info        IN  dz_swagger_info
      ,p_swagger_host        IN  VARCHAR2
      ,p_swagger_basepath    IN  VARCHAR2
      ,p_schemes_https       IN  VARCHAR2
      ,p_consumes_json       IN  VARCHAR2
      ,p_consumes_xml        IN  VARCHAR2
      ,p_consumes_form       IN  VARCHAR2
      ,p_produces_json       IN  VARCHAR2
      ,p_produces_xml        IN  VARCHAR2
      ,p_versionid           IN  VARCHAR2
    ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION all_methods
    RETURN dz_swagger_method_list
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION all_responses
    RETURN dz_swagger_response_list
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
       p_pretty_print      IN  NUMBER   DEFAULT NULL
      ,p_host_override_val IN  VARCHAR2 DEFAULT NULL
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_host_override_val IN  VARCHAR2 DEFAULT NULL
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_typ TO public;

