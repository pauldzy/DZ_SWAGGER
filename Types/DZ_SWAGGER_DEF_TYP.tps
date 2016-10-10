CREATE OR REPLACE TYPE dz_swagger_def_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid            VARCHAR2(40 Char)
   ,swagger_def          VARCHAR2(255 Char)
   ,swagger_def_type     VARCHAR2(255 Char)
   ,swagger_def_xml_name VARCHAR2(255 Char)
   ,inline_def           VARCHAR2(5 Char)
   ,swagger_def_props    dz_swagger_def_prop_list
   ,dummy                INTEGER

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_def_typ
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_def_typ(
       p_swagger_def          IN  VARCHAR2
      ,p_swagger_def_type     IN  VARCHAR2
      ,p_swagger_def_xml_name IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_def_typ(
       p_swagger_def          IN  VARCHAR2
      ,p_swagger_def_type     IN  VARCHAR2
      ,p_swagger_def_xml_name IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
      ,p_swagger_def_props    IN  dz_swagger_def_prop_list
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

GRANT EXECUTE ON dz_swagger_def_typ TO public;

