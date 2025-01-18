-- drop table customer 
SELECT column_name 
FROM USER_TAB_COLUMNS
WHERE table_name = 'CUSTOMERS';

COLUMN CUSTOMER_ID FORMAT 9999
COLUMN CUSTOMER_NAME FORMAT A30
COLUMN CITY FORMAT A15
COLUMN STATE FORMAT A10
COLUMN ZIP FORMAT A10

SELECT CUSTOMER_ID, CUSTOMER_NAME, CITY, STATE, ZIP 
FROM CUSTOMERS;


BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE customer_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN  
            RAISE;
        END IF;
END;
/


DECLARE
    max_id NUMBER;
BEGIN
    SELECT NVL(MAX(CUSTOMER_ID), 1000) INTO max_id FROM CUSTOMERS; -- Start from 1001 if table is empty
    EXECUTE IMMEDIATE 'CREATE SEQUENCE customer_seq START WITH ' || (max_id + 1) || ' INCREMENT BY 1 NOCYCLE NOCACHE';
END;
/



ALTER TABLE CUSTOMERS ADD (ZIP VARCHAR2(10));


INSERT INTO CUSTOMERS (CUSTOMER_ID, CUSTOMER_NAME, ZIP)
VALUES (customer_seq.NEXTVAL, 'Frank Shoulders', 23567);


SELECT MAX(CUSTOMER_ID) FROM CUSTOMERS;

SELECT * FROM CUSTOMERS WHERE CUSTOMER_NAME = 'Frank Shoulders';

DROP SEQUENCE MY_FIRST_SEQ;

CREATE SEQUENCE MY_FIRST_SEQ
START WITH 5
INCREMENT BY -3
MINVALUE -1000  --  minimum value to -1000
MAXVALUE 10
NOCYCLE;



SELECT MY_FIRST_SEQ.NEXTVAL FROM dual; -- first call 

SELECT MY_FIRST_SEQ.NEXTVAL FROM dual;  -- second call

SELECT MY_FIRST_SEQ.NEXTVAL FROM dual; -- third call



  
CREATE BITMAP INDEX idx_customers_state ON CUSTOMERS (STATE);

SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'CUSTOMERS'
ORDER BY INDEX_NAME;



DROP INDEX idx_customers_state;


Prompt Jalu Chaudhary