DROP TABLE BB_MEMBERS;

CREATE TABLE BB_MEMBERS (
    USER_ID VARCHAR2(50) PRIMARY KEY,
    USER_PASSWORD VARCHAR2(50),
    FIRST_NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(50)
);

-- Insert sample data
INSERT INTO BB_MEMBERS (USER_ID, USER_PASSWORD, FIRST_NAME, LAST_NAME)
VALUES ('rat55', 'kile', 'John', 'Doe');
COMMIT;


CREATE OR REPLACE PROCEDURE MEMBER_CK_SP (
    p_id            IN VARCHAR2,
    p_password      IN VARCHAR2,
    p_check         OUT VARCHAR2
) AS


BEGIN
   
    BEGIN
        SELECT 1
        INTO p_check
        FROM BB_MEMBERS
        WHERE USER_ID = p_id
        AND USER_PASSWORD = p_password;

        
        p_check := 'VALID';

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            
            p_check := 'INVALID';
    END;
END;
/


SET SERVEROUTPUT ON;

DECLARE
    v_check VARCHAR2(10);
BEGIN
  
    MEMBER_CK_SP(p_id => 'rat55', p_password => 'kile', p_check => v_check);
    IF v_check = 'VALID' THEN
        DBMS_OUTPUT.PUT_LINE('Najma ' || v_check || '');
        
        
        DBMS_OUTPUT.PUT_LINE('0');
    ELSE
        DBMS_OUTPUT.PUT_LINE(' ' || v_check || ' ');
    END IF;

    
END;
/



PROMPT Jalu Chaudhary