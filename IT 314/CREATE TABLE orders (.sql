CREATE TABLE orders (
    order_id NUMBER(5) PRIMARY KEY,  
    customer_id NUMBER(5) NOT NULL,  
    order_date DATE NOT NULL,        
    zip_code NUMBER(5),  
    ISBN NUMBER (10), 
    cost NUMBER (4)            
);
 INSERT INTO orders (order_id, customer_id, order_date)
VALUES (1021, 1009, TO_DATE('2009-07-20', 'YYYY-MM-DD'));
DESCRIBE orders;

INSERT INTO orders (order_id, customer_id, order_date, zip_code)
VALUES (1017, 1008, TO_DATE('2009-07-15', 'YYYY-MM-DD'), 12345);
 
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (1022, 2000, TO_DATE('2009-08-06', 'YYYY-MM-DD'));

INSERT INTO orders (order_id, customer_id, order_date, isbn, cost )
VALUES (1023, 1009, TO_DATE('2009-08-07', 'YYYY-MM-DD','1059831198', 20.00));

UPDATE orders
SET cost = 20.00
WHERE isbn = '1059831198';

SELECT * FROM orders
WHERE isbn = '1059831198';

COMMIT;
-- Delete Order# 1005
DELETE FROM orders
WHERE order_id = 1005;

ROLLBACK;
COMMIT;
prompt Jalu chaudhary