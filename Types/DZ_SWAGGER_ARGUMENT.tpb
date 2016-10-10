CREATE OR REPLACE TYPE BODY dz_swagger_argument
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_argument
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_argument;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_argument(
       p_object_owner         IN  VARCHAR2
      ,p_object_name          IN  VARCHAR2
      ,p_procedure_name       IN  VARCHAR2
      ,p_argument_name        IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
      ,p_overload             IN  INTEGER
   ) RETURN SELF AS RESULT 
   AS 
   BEGIN 
   
      self.object_owner         := p_object_owner;
      self.object_name          := p_object_name;
      self.procedure_name       := p_procedure_name;
      self.argument_name        := p_argument_name;
      self.data_type            := p_data_type;
      self.position             := p_position;
      self.overload             := p_overload;

      RETURN; 
      
   END dz_swagger_argument;

END;
/

