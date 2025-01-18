-- Drop the sequence if it exists
DROP SEQUENCE BB_IDBASKETITEM_SEQ;

-- Drop the table if it exists
DROP TABLE BB_BASKETITEM;

-- Check if the sequence exists
SELECT SEQUENCE_NAME FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'BB_IDBASKETITEM_SEQ';

-- Check if the table exists
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME = 'BB_BASKETITEM';




CREATE SEQUENCE BB_IDBASKETITEM_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE TABLE BB_BASKETITEM (
    IDBASKETITEM NUMBER PRIMARY KEY,
    IDBASKET NUMBER NOT NULL,
    IDPRODUCT NUMBER NOT NULL,
    PRICE NUMBER(10, 2) NOT NULL,
    QUANTITY NUMBER NOT NULL,
    SIZE_CODE NUMBER NOT NULL,
    FORM_CODE NUMBER NOT NULL
);

CREATE OR REPLACE PROCEDURE BASKET_ADD_SP (
    p_idproduct IN NUMBER,
    p_idbasket IN NUMBER,
    p_price IN NUMBER,
    p_quantity IN NUMBER,
    p_size_code IN NUMBER,
    p_form_code IN NUMBER
) AS
BEGIN
    INSERT INTO BB_BASKETITEM (
        IDBASKETITEM,
        IDBASKET,
        IDPRODUCT,
        PRICE,
        QUANTITY,
        SIZE_CODE,
        FORM_CODE
    )
    VALUES (
        BB_IDBASKETITEM_SEQ.NEXTVAL, -- Primary Key
        p_idbasket,
        p_idproduct,
        p_price,
        p_quantity,
        p_size_code,
        p_form_code
    );

    COMMIT; -- Save the transaction
    DBMS_OUTPUT.PUT_LINE('Item successfully added to basket!');
END;
/

SET SERVEROUTPUT ON;

BEGIN
    BASKET_ADD_SP(
        p_idproduct => 8,
        p_idbasket => 14,
        p_price => 10.80,
        p_quantity => 1,
        p_size_code => 2,
        p_form_code => 4
    );
END;
/


SELECT * FROM BB_BASKETITEM;




PROMPT Jalu Chaudhary

