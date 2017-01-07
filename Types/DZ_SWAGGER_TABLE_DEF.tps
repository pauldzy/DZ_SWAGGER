CREATE OR REPLACE TYPE dz_swagger_table_def FORCE
AUTHID CURRENT_USER 
AS OBJECT (
    definition          VARCHAR2(255 Char)
   ,table_owner         VARCHAR2(30 Char)
   ,table_name	         VARCHAR2(30 Char)
   ,column_name         VARCHAR2(30 Char)
   ,json_name           VARCHAR2(255 Char)
   ,column_common       VARCHAR2(30 Char)
   ,data_type           VARCHAR2(30 Char)
   ,json_type           VARCHAR2(30 Char)
   ,position            INTEGER
   ,relative_position   INTEGER
   ,dummy               INTEGER

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_table_def
    RETURN SELF AS RESULT
    
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_definition           IN  VARCHAR2
      ,p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_json_name            IN  VARCHAR2
      ,p_column_common        IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_json_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
      ,p_relative_position    IN  INTEGER
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_definition           IN  VARCHAR2
      ,p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_json_name            IN  VARCHAR2
      ,p_json_type            IN  VARCHAR2
      ,p_relative_position    IN  INTEGER
   ) RETURN SELF AS RESULT
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ,CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
   ) RETURN SELF AS RESULT

);
/

GRANT EXECUTE ON dz_swagger_table_def TO public;

