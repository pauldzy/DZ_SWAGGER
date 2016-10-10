CREATE OR REPLACE TYPE dz_swagger_info FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    info_title          VARCHAR2(255 Char)
   ,info_description    VARCHAR2(255 Char)
   ,info_termsofservice VARCHAR2(255 Char)
   ,info_contact        dz_swagger_info_contact
   ,info_license        dz_swagger_info_license
   ,info_version        VARCHAR2(255 Char)
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info 
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_info(
       p_info_title          IN  VARCHAR2
      ,p_info_description    IN  VARCHAR2
      ,p_info_termsofservice IN  VARCHAR2
      ,p_info_contact        IN  dz_swagger_info_contact
      ,p_info_license        IN  dz_swagger_info_license
      ,p_info_version        IN  VARCHAR2
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION isNULL
    RETURN VARCHAR2
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print         IN  NUMBER   DEFAULT NULL
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print         IN  NUMBER   DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_info TO public;

