CREATE OR REPLACE TYPE dz_swagger_definition_typ FORCE
AUTHID DEFINER 
AS OBJECT (
    versionid            VARCHAR2(40 Char)
   ,definition           VARCHAR2(255 Char)
   ,definition_title     VARCHAR2(255 Char)
   ,definition_type      VARCHAR2(255 Char)
   ,definition_desc      VARCHAR2(4000 Char)
   ,inline_def           VARCHAR2(5 Char)
   ,swagger_properties   dz_swagger_property_list
   ,xml_name             VARCHAR2(255 Char)
   ,xml_namespace        VARCHAR2(2000 Char)
   ,xml_prefix           VARCHAR2(255 Char)
   ,xml_wrapped          VARCHAR2(5 Char)
   ,dummy                INTEGER

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_definition_typ
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_definition_typ(
       p_definition           IN  VARCHAR2
      ,p_definition_type      IN  VARCHAR2
      ,p_definition_title     IN  VARCHAR2
      ,p_definition_desc      IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_xml_wrapped          IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_definition_typ(
       p_definition           IN  VARCHAR2
      ,p_definition_type      IN  VARCHAR2
      ,p_definition_title     IN  VARCHAR2
      ,p_definition_desc      IN  VARCHAR2
      ,p_inline_def           IN  VARCHAR2
      ,p_xml_name             IN  VARCHAR2
      ,p_xml_namespace        IN  VARCHAR2
      ,p_xml_prefix           IN  VARCHAR2
      ,p_xml_wrapped          IN  VARCHAR2
      ,p_versionid            IN  VARCHAR2
      ,p_swagger_properties   IN  dz_swagger_property_list
   ) RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toJSON(
       p_pretty_print         IN  INTEGER  DEFAULT NULL
      ,p_jsonschema           IN  VARCHAR2 DEFAULT 'FALSE'
      ,p_zap_override         IN  VARCHAR2 DEFAULT 'FALSE'      
   ) RETURN CLOB
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,MEMBER FUNCTION toYAML(
       p_pretty_print         IN  INTEGER  DEFAULT 0
      ,p_zap_override         IN  VARCHAR2 DEFAULT 'FALSE'
   ) RETURN CLOB

);
/

GRANT EXECUTE ON dz_swagger_definition_typ TO public;

