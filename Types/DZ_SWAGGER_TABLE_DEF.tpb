CREATE OR REPLACE TYPE BODY dz_swagger_table_def
AS 

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_table_def
   RETURN SELF AS RESULT 
   AS 
   BEGIN 
      RETURN; 
      
   END dz_swagger_table_def;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_swagger_def          IN  VARCHAR2
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
   AS 
   BEGIN 
   
      self.swagger_def          := p_swagger_def;
      self.table_owner          := p_table_owner;
      self.table_name           := p_table_name;
      self.column_name          := p_column_name;
      self.json_name            := p_json_name;
      self.column_common        := p_column_common;
      self.data_type            := p_data_type;
      self.json_type            := p_json_type;
      self.position             := p_position;
      self.relative_position    := p_relative_position;

      RETURN; 
      
   END dz_swagger_table_def;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_swagger_def          IN  VARCHAR2
      ,p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_json_name            IN  VARCHAR2
      ,p_json_type            IN  VARCHAR2
      ,p_relative_position    IN  INTEGER
   ) RETURN SELF AS RESULT
   AS
   BEGIN
   
      self.swagger_def          := p_swagger_def;
      self.table_owner          := p_table_owner;
      self.table_name           := p_table_name;
      self.column_name          := p_column_name;
      self.json_name            := p_json_name;
      self.json_type            := p_json_type;
      self.relative_position    := p_relative_position;
      
      IF self.column_name IS NOT NULL
      THEN
         self.column_common := UPPER(
            REPLACE(self.column_name,'_','')
         );
         
      ELSE
         self.column_common := UPPER(
            REPLACE(self.json_name,'_','')
         );
       
      END IF;
        
      RETURN;
   
   END dz_swagger_table_def;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   CONSTRUCTOR FUNCTION dz_swagger_table_def(
       p_table_owner          IN  VARCHAR2
      ,p_table_name           IN  VARCHAR2
      ,p_column_name          IN  VARCHAR2
      ,p_data_type            IN  VARCHAR2
      ,p_position             IN  INTEGER
   ) RETURN SELF AS RESULT
   AS
   BEGIN
   
      self.table_owner          := p_table_owner;
      self.table_name           := p_table_name;
      self.column_name          := p_column_name;
      self.data_type            := p_data_type;
      self.position             := p_position;
      
      self.column_common := UPPER(
         REPLACE(self.column_name,'_','')
      );
      
      RETURN;
      
   END dz_swagger_table_def;

END;
/

