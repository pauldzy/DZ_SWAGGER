CREATE OR REPLACE TYPE dz_swagger_parm_typ FORCE
AUTHID DEFINER 
AS OBJECT (
    versionid           VARCHAR2(40 Char)
   ,swagger_parm_id     VARCHAR2(255 Char)
   ,swagger_parm	      VARCHAR2(255 Char)
   ,parameter_ref_id    VARCHAR2(255 Char)
   ,parm_description    VARCHAR2(4000 Char)
   ,parm_type           VARCHAR2(255 Char)
   ,parm_default_string VARCHAR2(255 Char)
   ,parm_default_number NUMBER
   ,parm_required       VARCHAR2(255 Char)
   ,parm_undocumented   VARCHAR2(5 Char)
   ,swagger_path        VARCHAR2(255 Char)
   ,swagger_http_method VARCHAR2(255 Char)
   ,parameter_in_type   VARCHAR2(255 Char)
   ,path_param_sort     NUMBER
   ,param_sort          NUMBER
   ,inline_parm         VARCHAR2(5 Char)
   ,parm_enums_string   MDSYS.SDO_STRING2_ARRAY
   ,parm_enums_number   MDSYS.SDO_NUMBER_ARRAY

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_parm_typ
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_parm_typ(
       p_swagger_parm_id      IN  VARCHAR2
      ,p_swagger_parm         IN  VARCHAR2
      ,p_parm_description     IN  VARCHAR2
      ,p_parm_type            IN  VARCHAR2
      ,p_parm_default_string  IN  VARCHAR2
      ,p_parm_default_number  IN  NUMBER
      ,p_parm_required        IN  VARCHAR2
      ,p_parm_undocumented    IN  VARCHAR2
      ,p_swagger_path         IN  VARCHAR2
      ,p_swagger_http_method  IN  VARCHAR2
      ,p_parameter_in_type    IN  VARCHAR2
      ,p_path_param_sort      IN  NUMBER
      ,p_param_sort           IN  NUMBER
      ,p_inline_parm          IN  VARCHAR2
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
       p_pretty_print     IN  NUMBER   DEFAULT 0
      ,p_array_marker     IN  VARCHAR  DEFAULT 'FALSE'
   ) RETURN CLOB
   
);
/

GRANT EXECUTE ON dz_swagger_parm_typ TO public;

