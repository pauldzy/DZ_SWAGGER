CREATE OR REPLACE TYPE dz_swagger_info_license FORCE
AUTHID DEFINER 
AS OBJECT (
    license_name        VARCHAR2(255 Char)
   ,license_url         VARCHAR2(255 Char)
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info_license
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info_license(
       p_license_name     IN  VARCHAR2
      ,p_license_url      IN  VARCHAR2
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION isNULL
    RETURN VARCHAR2
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print      IN  INTEGER  DEFAULT NULL
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print      IN  INTEGER  DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_info_license TO public;

