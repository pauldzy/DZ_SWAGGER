CREATE OR REPLACE PACKAGE BODY dz_swagger_util
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_guid
   RETURN VARCHAR2
   AS
      str_sysguid VARCHAR2(40 Char);
      
   BEGIN
   
      str_sysguid := UPPER(RAWTOHEX(SYS_GUID()));
      
      RETURN '{' 
         || SUBSTR(str_sysguid,1,8)  || '-'
         || SUBSTR(str_sysguid,9,4)  || '-'
         || SUBSTR(str_sysguid,13,4) || '-'
         || SUBSTR(str_sysguid,17,4) || '-'
         || SUBSTR(str_sysguid,21,12)|| '}';
   
   END get_guid;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION yaml_text(
       p_input        IN  VARCHAR2 
      ,p_pretty_print IN  NUMBER DEFAULT 0
   ) RETURN VARCHAR2
   AS
      str_output  VARCHAR2(32000 Char) := p_input;
      str_format  VARCHAR2(4000 Char);
      ary_strings MDSYS.SDO_STRING2_ARRAY;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10 
      -- Determine what format to use
      --------------------------------------------------------------------------
      IF INSTR(p_input,CHR(10)) > 0
      OR INSTR(p_input,CHR(13)) > 0
      THEN
         str_format := 'multiline';
         
      ELSIF REGEXP_LIKE(p_input,'\:|\?|\]|\[|\"|\''|\&|\%|\$')
      THEN
         str_format := 'double';
         
      ELSIF REGEXP_LIKE(p_input,'^[-[:digit:],.]+$')
      OR LOWER(p_input) IN ('true','false')      
      THEN
         str_format := 'single';
         
      ELSE
         str_format := 'bare';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20 
      -- Process bare strings
      --------------------------------------------------------------------------
      IF str_format = 'bare'
      THEN
         RETURN str_output;
         
      --------------------------------------------------------------------------
      -- Step 30 
      -- Process single quoted strings
      --------------------------------------------------------------------------
      ELSIF str_format = 'single'
      THEN
         str_output := REGEXP_REPLACE(str_output,'''','''''');
         
         RETURN '''' || str_output || '''';
         
      --------------------------------------------------------------------------
      -- Step 40 
      -- Process double quoted strings
      --------------------------------------------------------------------------
      ELSIF str_format = 'double'
      THEN
         str_output := REGEXP_REPLACE(str_output,CHR(13),'');
         
         str_output := REGEXP_REPLACE(str_output,'"','\"');
         
         RETURN '"' || str_output || '"';
      
      --------------------------------------------------------------------------
      -- Step 50 
      -- Process bar indented strings
      --------------------------------------------------------------------------
      ELSIF str_format = 'multiline'
      THEN
         str_output := REGEXP_REPLACE(str_output,CHR(13),'');
         
         ary_strings := dz_json_util.gz_split(
             str_output
            ,CHR(10)
         );
         
         str_output := dz_json_util.pretty_str(
             '|-'
            ,0
            ,'  '
         );
         
         FOR i IN 1 .. ary_strings.COUNT
         LOOP
            IF i < ary_strings.COUNT
            THEN
               str_output := str_output || dz_json_util.pretty_str(
                   ary_strings(i)
                  ,p_pretty_print + 1
                  ,'  '
               );
               
            ELSE
               str_output := str_output || dz_json_util.pretty_str(
                   ary_strings(i)
                  ,p_pretty_print + 1
                  ,'  '
                  ,NULL
               );

            END IF;
         
         END LOOP;
         
         RETURN str_output;
         
      ELSE
         RAISE_APPLICATION_ERROR(-20001,'err');
      
      END IF;

      
   END yaml_text;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION yaml_text(
       p_input        IN  NUMBER 
      ,p_pretty_print IN  NUMBER DEFAULT 0
   ) RETURN VARCHAR2
   AS
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10 
      -- Simple override
      --------------------------------------------------------------------------
      RETURN TO_CHAR(p_input);

      
   END yaml_text;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION dzcondense(
       p_versionid    IN  VARCHAR2
      ,p_input        IN  VARCHAR2
   ) RETURN VARCHAR2 DETERMINISTIC
   AS
      str_output VARCHAR2(4000) := p_input;
      ary_keys   MDSYS.SDO_STRING2_ARRAY;
      ary_values MDSYS.SDO_STRING2_ARRAY;
      boo_check  BOOLEAN := FALSE;
      
   BEGIN
   
      SELECT
       a.condense_key
      ,a.condense_value
      BULK COLLECT INTO
       ary_keys
      ,ary_values
      FROM
      dz_swagger_condense a
      WHERE
      a.versionid = p_versionid
      ORDER BY
      LENGTH(a.condense_key) DESC;
      
      FOR i IN 1 .. ary_keys.COUNT
      LOOP
      
         IF REGEXP_INSTR(p_input,ary_keys(i)) > 0
         THEN
            str_output := REGEXP_REPLACE(
                p_input
               ,ary_keys(i)
               ,ary_values(i)
            );
            
            boo_check := TRUE;
         
         END IF;
         
         IF boo_check
         THEN
            EXIT;
            
         END IF;
      
      END LOOP;
      
      RETURN str_output;
      
   END dzcondense;

END dz_swagger_util;
/

