CREATE OR REPLACE TYPE dz_swagger_response_list FORCE                                       
AS 
TABLE OF dz_swagger_response_typ;
/

GRANT EXECUTE ON dz_swagger_response_list TO public;

