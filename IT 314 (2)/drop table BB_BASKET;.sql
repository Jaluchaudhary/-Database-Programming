drop table BB_BASKET;
CREATE TABLE BB_BASKET (
    IDBASKET NUMBER PRIMARY KEY,
    SUBTOTAL NUMBER,
    SHIPPING NUMBER,
    TAX NUMBER,
    TOTAL NUMBER
);

-- Insert sample data into the BB_BASKET table
INSERT INTO BB_BASKET (IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL) VALUES (12, 72.4, 8, 3.26, 83.66);
INSERT INTO BB_BASKET (IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL) VALUES (13, 100, 10, 5, 115);
INSERT INTO BB_BASKET (IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL) VALUES (14, 50, 5, 2, 57);

COMMIT; -- Commit the changes to the database

SET SERVEROUTPUT ON;  -- Enable output for DBMS_OUTPUT

DECLARE
    TYPE BasketRecord IS RECORD (
        idbasket  BB_BASKET.IDBASKET%TYPE,
        subtotal  BB_BASKET.SUBTOTAL%TYPE,
        shipping  BB_BASKET.SHIPPING%TYPE,
        tax       BB_BASKET.TAX%TYPE,
        total     BB_BASKET.TOTAL%TYPE
    );

    lv_basket BasketRecord;  -- Variable to hold the record data
    lv_idbasket NUMBER := 12; -- Initialized variable for basket ID

BEGIN
   
    SELECT IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL
    INTO lv_basket
    FROM BB_BASKET
    WHERE IDBASKET = lv_idbasket;

    DBMS_OUTPUT.PUT_LINE(lv_basket.idbasket);
    DBMS_OUTPUT.PUT_LINE(lv_basket.subtotal);
    DBMS_OUTPUT.PUT_LINE(lv_basket.shipping);
    DBMS_OUTPUT.PUT_LINE(lv_basket.tax);
    DBMS_OUTPUT.PUT_LINE(lv_basket.total);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No basket found with ID ' || lv_idbasket);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/


prompt Jalu chaudhary