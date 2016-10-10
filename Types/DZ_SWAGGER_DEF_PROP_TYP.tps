CREATE OR REPLACE TYPE dz_swagger_def_prop_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid            VARCHAR2(40 Char)
   ,def_property_id      VARCHAR2(255 Char)
   ,def_property         VARCHAR2(255 Char)
   ,def_type	          VARCHAR2(255 Char)
   ,def_title            VARCHAR2(255 Char)
   ,def_format           VARCHAR2(255 Char)
   ,def_example_string   VARCHAR2(255 Char)
   ,def_example_number   NUMBER
   ,def_description      VARCHAR2(4000 Char)
   ,def_reference        VARCHAR2(255 Char)
   ,dummy                INTEGER
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_def_prop_typ
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_def_prop_typ(
       p_def_property_id    IN  VARCHAR2
      ,p_def_property       IN  VARCHAR2
      ,p_def_type	          IN  VARCHAR2
      ,p_def_title          IN  VARCHAR2
      ,p_def_format         IN  VARCHAR2
      ,p_def_example_string IN  VARCHAR2
      ,p_def_example_number IN  NUMBER
      ,p_def_description    IN  VARCHAR2
      ,p_def_reference      IN  VARCHAR2
      ,p_versionid          IN  VARCHAR2
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

GRANT EXECUTE ON dz_swagger_def_prop_typ TO PUBLIC;

