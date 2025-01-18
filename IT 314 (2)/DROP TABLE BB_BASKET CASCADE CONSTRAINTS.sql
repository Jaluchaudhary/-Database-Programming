DROP TABLE BB_BASKET CASCADE CONSTRAINTS;
DROP TABLE BB_PROMOLIST CASCADE CONSTRAINTS;

CREATE TABLE BB_BASKET (
    IDSHOPPER NUMBER(10),
    BASKET_CREATION_DATE DATE
);

CREATE TABLE BB_PROMOLIST (
    IDSHOPPER NUMBER(10),
    PROMO_MONTH VARCHAR2(3),
    PROMO_YEAR NUMBER(4),
    PROMO_FLAG NUMBER(1),
    USED CHAR(1)
);


INSERT INTO BB_BASKET (IDSHOPPER, BASKET_CREATION_DATE)
VALUES (21, TO_DATE('10-JAN-2012', 'DD-MON-YYYY'));

INSERT INTO BB_BASKET (IDSHOPPER, BASKET_CREATION_DATE)
VALUES (26, TO_DATE('05-FEB-2012', 'DD-MON-YYYY'));

INSERT INTO BB_BASKET (IDSHOPPER, BASKET_CREATION_DATE)
VALUES (30, TO_DATE('20-MAR-2012', 'DD-MON-YYYY'));

COMMIT;


SET SERVEROUTPUT ON;

BEGIN
    PROMO_SHIP_SP(
        p_cutoff_date => TO_DATE('15-FEB-12', 'DD-MON-YY'),
        p_month => 'APR',
        p_year => 2012
    );
END;
/


CREATE OR REPLACE PROCEDURE PROMO_SHIP_SP (
    p_cutoff_date IN DATE,    -- Input cutoff date (e.g., '15-FEB-12')
    p_month IN VARCHAR2,      -- Month for the promotion (e.g., 'APR')
    p_year IN NUMBER          -- Year for the promotion (e.g., 2012)
)
IS
BEGIN

    INSERT INTO BB_PROMOLIST (IDSHOPPER, PROMO_MONTH, PROMO_YEAR, PROMO_FLAG, USED)
    SELECT DISTINCT b.IDSHOPPER,   
           p_month,                
           p_year,                 
           1,                      
           'N'                     
    FROM BB_BASKET b
    WHERE b.BASKET_CREATION_DATE <= p_cutoff_date;

    COMMIT;

   
    DBMS_OUTPUT.PUT_LINE('Promotion applied for customers not shopping since ' || TO_CHAR(p_cutoff_date, 'DD-MON-YYYY'));
END PROMO_SHIP_SP;
/

SELECT * FROM BB_PROMOLIST;


prompt Jalu Chaudhary

