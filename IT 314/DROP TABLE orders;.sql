DROP TABLE orders;

-- Create the orders table
CREATE TABLE orders (
    order_id      NUMBER PRIMARY KEY,
    customer_id   NUMBER,
    order_date    DATE,
    order_amount  NUMBER(8, 2)
);

-- Insert records into the orders table
INSERT INTO orders (order_id, customer_id, order_date, order_amount)
VALUES (1, 001, TO_DATE('2024-09-25', 'YYYY-MM-DD'), 50);

INSERT INTO orders (order_id, customer_id, order_date, order_amount)
VALUES (2, 002, TO_DATE('2024-09-24', 'YYYY-MM-DD'), 60);

INSERT INTO orders (order_id, customer_id, order_date, order_amount)
VALUES (3, 003, TO_DATE('2024-09-26', 'YYYY-MM-DD'), 70);

INSERT INTO orders (order_id, customer_id, order_date, order_amount)
VALUES (4, 001, TO_DATE('2024-09-30', 'YYYY-MM-DD'), 80);


SELECT 
    customer_id,
    COUNT(order_id) AS TotalOrders,
    AVG(order_amount) AS AverageOrderAmount
FROM 
    orders
WHERE 
    order_date >= TO_DATE('2024-09-01', 'YYYY-MM-DD')
GROUP BY 
    customer_id
HAVING 
    COUNT(order_id) > 1;

SELECT 
    customer_id,
    COUNT(order_id) AS TotalOrders,
    SUM(order_amount) AS TotalOrderAmount
FROM 
    orders
GROUP BY 
    ROLLUP (customer_id);
    
SELECT 
    customer_id,
    order_date,
    COUNT(order_id) AS TotalOrders,
    SUM(order_amount) AS TotalOrderAmount
FROM 
    orders
GROUP BY 
    CUBE (customer_id, order_date);


prompt Jalu Chaudhary
