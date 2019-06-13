CREATE OR REPLACE PACKAGE dz_swagger_test
AUTHID DEFINER
AS

   C_GITRELEASE    CONSTANT VARCHAR2(255 Char) := 'NULL';
   C_GITCOMMIT     CONSTANT VARCHAR2(255 Char) := 'NULL';
   C_GITCOMMITDATE CONSTANT VARCHAR2(255 Char) := 'NULL';
   C_GITCOMMITAUTH CONSTANT VARCHAR2(255 Char) := 'NULL';
   
   C_PREREQUISITES CONSTANT MDSYS.SDO_STRING2_ARRAY := MDSYS.SDO_STRING2_ARRAY(
      'DZ_JSON'
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION prerequisites
   RETURN NUMBER;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION version
   RETURN VARCHAR2;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION inmemory_test
   RETURN NUMBER;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION scratch_test
   RETURN NUMBER;
      
END dz_swagger_test;
/

GRANT EXECUTE ON dz_swagger_test TO public;

