CREATE OR REPLACE TYPE dz_swagger_xml FORCE
AUTHID DEFINER 
AS OBJECT (
    xml_name            VARCHAR2(255 Char)
   ,xml_namespace       VARCHAR2(2000 Char)
   ,xml_prefix          VARCHAR2(255 Char)
   ,xml_attribute       VARCHAR2(5 Char)
   ,xml_wrapped         VARCHAR2(5 Char)
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_xml
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_xml(
       p_xml_name            IN  VARCHAR2 DEFAULT NULL
      ,p_xml_namespace       IN  VARCHAR2 DEFAULT NULL
      ,p_xml_prefix          IN  VARCHAR2 DEFAULT NULL
      ,p_xml_attribute       IN  VARCHAR2 DEFAULT NULL
      ,p_xml_wrapped         IN  VARCHAR2 DEFAULT NULL
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
      p_pretty_print         IN  INTEGER  DEFAULT NULL
    ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
      p_pretty_print         IN  INTEGER  DEFAULT 0
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_xml TO public;

