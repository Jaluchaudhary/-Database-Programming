-- Step 1: Create the table
CREATE TABLE BB_BASKET (
    idShopper NUMBER,
    total NUMBER,
    orderplaced NUMBER
);

-- Step 2: Insert sample data
INSERT INTO BB_BASKET (idShopper, total, orderplaced) VALUES (22, 100.00, 1);
INSERT INTO BB_BASKET (idShopper, total, orderplaced) VALUES (22, 110.21, 1);
INSERT INTO BB_BASKET (idShopper, total, orderplaced) VALUES (22, 50.00, 0);  -- Not counted
INSERT INTO BB_BASKET (idShopper, total, orderplaced) VALUES (23, 200.00, 1);
INSERT INTO BB_BASKET (idShopper, total, orderplaced) VALUES (24, 90.00, 1);

-- Step 3: Execute the PL/SQL block
-- SET SERVEROUTPUT ON;  -- Enable output display

DECLARE 
    lv_shopper_id NUMBER := 22;  -- Initialize the shopper ID
    lv_total      NUMBER;          -- Variable to hold the total purchases
    lv_rating     VARCHAR2(10);    -- Variable to hold the rating

BEGIN
    -- Calculate the total purchases for the specified shopper
    SELECT SUM(total)
    INTO lv_total
    FROM BB_BASKET  -- Use the correct table name
    WHERE idShopper = lv_shopper_id
      AND orderplaced = 1;  -- Only consider completed orders

    -- Determine the rating based on the total purchases
    IF lv_total IS NULL THEN
        lv_rating := 'LOW';  
        lv_total := 0;       
    ELSIF lv_total > 200 THEN
        lv_rating := 'HIGH';
    ELSIF lv_total > 100 THEN
        lv_rating := 'MID';
    ELSE
        lv_rating := 'LOW';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Shopper ' || lv_shopper_id || ' is rated ' || lv_rating);
    DBMS_OUTPUT.PUT_LINE('SUM (TOTAL): ' || lv_total);  

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No orders found for shopper ' || lv_shopper_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/

Prompt Jalu Chsudhary