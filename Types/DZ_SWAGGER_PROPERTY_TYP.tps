CREATE OR REPLACE TYPE dz_swagger_property_typ FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    versionid            VARCHAR2(40 Char)
   ,property_id          VARCHAR2(255 Char)
   ,property             VARCHAR2(255 Char)
   ,property_type	       VARCHAR2(255 Char)
   ,property_title       VARCHAR2(255 Char)
   ,property_format      VARCHAR2(255 Char)
   ,property_exp_string  VARCHAR2(255 Char)
   ,property_exp_number  NUMBER
   ,property_description VARCHAR2(4000 Char)
   ,property_reference   VARCHAR2(255 Char)
   ,dummy                INTEGER
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_property_typ
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_property_typ(
       p_property_id          IN  VARCHAR2
      ,p_property             IN  VARCHAR2
      ,p_property_type	      IN  VARCHAR2
      ,p_property_title       IN  VARCHAR2
      ,p_property_format      IN  VARCHAR2
      ,p_property_exp_string  IN  VARCHAR2
      ,p_property_exp_number  IN  NUMBER
      ,p_property_description IN  VARCHAR2
      ,p_property_reference   IN  VARCHAR2
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

GRANT EXECUTE ON dz_swagger_property_typ TO PUBLIC;

