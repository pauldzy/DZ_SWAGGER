CREATE OR REPLACE TYPE dz_swagger_path_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid         VARCHAR2(40 Char)
   ,swagger_path      VARCHAR2(255 Char)
   ,swagger_methods   dz_swagger_method_list
  
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_path_typ 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_path_typ(
       p_swagger_path        IN VARCHAR2
      ,p_versionid          IN  VARCHAR2
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
       p_pretty_print     IN  NUMBER   DEFAULT 0
      ,p_array_marker     IN  VARCHAR  DEFAULT 'FALSE'
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_path_typ TO public;

