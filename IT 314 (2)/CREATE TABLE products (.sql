CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(50),
    price NUMBER
);

-- Insert sample data into the products table
INSERT INTO products (product_id, product_name, price) VALUES (1, 'Coffee', 5.00);
INSERT INTO products (product_id, product_name, price) VALUES (2, 'Tea', 3.50);
INSERT INTO products (product_id, product_name, price) VALUES (3, 'Pastry', 2.50);
INSERT INTO products (product_id, product_name, price) VALUES (4, 'Sandwich', 28.50); -- Product ID 4
INSERT INTO products (product_id, product_name, price) VALUES (5, 'Muffin', 4.00);

COMMIT; -- Commit the changes to the database

SET SERVEROUTPUT ON;  -- Enable output for DBMS_OUTPUT

DECLARE
    lv_spending_amount NUMBER := 100;  -- Initialize the total spending amount
    lv_product_id     NUMBER := 4;      -- Initialize the product ID (test with product ID 4)
    lv_item_cost      NUMBER;            -- Variable to hold the item cost
    lv_qty            NUMBER := 0;        -- Variable to hold the quantity purchased
    lv_total_amount   NUMBER := 0;        -- Variable to hold the total amount spent

BEGIN
    
    SELECT price  
    INTO lv_item_cost
    FROM products  
    WHERE product_id = lv_product_id;  

    
    WHILE lv_total_amount + lv_item_cost <= lv_spending_amount LOOP
        lv_qty := lv_qty + 1;                 
        lv_total_amount := lv_total_amount + lv_item_cost;  
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('qty = ' || lv_qty);
    DBMS_OUTPUT.PUT_LINE('amount = ' || lv_total_amount);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No item found with product ID ' || lv_product_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/

Prompt Jalu Chsudhary