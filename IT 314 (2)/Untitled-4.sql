-- Step 1: Run the PL/SQL block
SET SERVEROUTPUT ON;  -- Enable output display

DECLARE 
    lv_shopper_id NUMBER := 22;  -- Initialize the shopper ID
    lv_total      NUMBER;          -- Variable to hold the total purchases
    lv_rating     VARCHAR2(10);    -- Variable to hold the rating

BEGIN
    -- Calculate the total purchases for the specified shopper
    SELECT SUM(total)
    INTO lv_total
    FROM bb_basket  -- Use the correct table name
    WHERE idShopper = lv_shopper_id
      AND orderplaced = 1;  -- Only consider completed orders

    -- Determine the rating using a searched CASE statement
    lv_rating := CASE
                    WHEN lv_total > 200 THEN 'HIGH'
                    WHEN lv_total > 100 THEN 'MID'
                    ELSE 'LOW'
                 END;

    -- Output the results
    DBMS_OUTPUT.PUT_LINE('Shopper ' || lv_shopper_id || ' is rated ' || lv_rating);
    DBMS_OUTPUT.PUT_LINE('SUM (TOTAL): ' || COALESCE(lv_total, 0));  -- Output the total

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No orders found for shopper ' || lv_shopper_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/


SELECT SUM(total)
FROM bb_basket
WHERE idShopper = 22
AND orderplaced = 1
GROUP BY idShopper;

Prompt Jalu Chsudhary