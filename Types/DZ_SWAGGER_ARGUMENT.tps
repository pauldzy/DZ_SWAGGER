CREATE OR REPLACE TYPE dz_swagger_argument FORCE
AUTHID DEFINER 
AS OBJECT (
    object_owner        VARCHAR2(30 Char)
   ,object_name	      VARCHAR2(30 Char)
   ,procedure_name      VARCHAR2(30 Char)
   ,argument_name       VARCHAR2(30 Char)
   ,data_type           VARCHAR2(30 Char)
   ,position            INTEGER
   ,overload            INTEGER
   ,dummy               INTEGER

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_argument
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_argument(
       p_object_owner         IN  VARCHAR2
      ,p_object_name          IN  VARCHAR2
      ,p_procedure_name       IN  VARCHAR2
      ,p_argument_name        IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
      ,p_overload             IN  INTEGER
   ) RETURN SELF AS RESULT

);
/

GRANT EXECUTE ON dz_swagger_argument TO public;

