DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE CUSTOMERS CASCADE CONSTRAINTS;

-- Create the CUSTOMERS table
CREATE TABLE CUSTOMERS (
    customer# INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    address VARCHAR(100),
    city VARCHAR(50),
    state CHAR(2),
    zip VARCHAR(10),
    phone VARCHAR(15)
);

-- Create the ORDERS table with a foreign key reference to CUSTOMERS
CREATE TABLE ORDERS (
    order# INT PRIMARY KEY,
    orderdate DATE,
    customer# INT,
    total NUMBER(10,2),
    FOREIGN KEY (customer#) REFERENCES CUSTOMERS(customer#)
);
-- Insert rows into CUSTOMERS
INSERT INTO CUSTOMERS (customer#, fname, lname, address, city, state, zip, phone)
VALUES (1, 'Bonita', 'Morales', 'P.O. BOX 651', 'CityA', 'CA', '12345', '555-1234');

INSERT INTO CUSTOMERS (customer#, fname, lname, address, city, state, zip, phone)
VALUES (2, 'Leila', 'Smith', 'P.O. BOX 66', 'CityB', 'TX', '67890', '555-5678');

INSERT INTO CUSTOMERS (customer#, fname, lname, address, city, state, zip, phone)
VALUES (3, 'Cindy', 'Girard', 'P.O. BOX 851', 'CityC', 'FL', '11223', '555-9876');

INSERT INTO CUSTOMERS (customer#, fname, lname, address, city, state, zip, phone)
VALUES (4, 'Kenneth', 'Jones', 'P.O. BOX 137', 'CityD', 'NY', '33445', '555-1357');

INSERT INTO CUSTOMERS (customer#, fname, lname, address, city, state, zip, phone)
VALUES (5, 'Jake', 'Lucas', '114 EAST SAVANNAH', 'CityE', 'VA', '55678', '555-2468');

-- Insert rows into ORDERS
INSERT INTO ORDERS (order#, customer#, orderdate, total)
VALUES (101, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 250.00);

INSERT INTO ORDERS (order#, customer#, orderdate, total)
VALUES (102, 2, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 150.50);

INSERT INTO ORDERS (order#, customer#, orderdate, total)
VALUES (103, 3, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 300.75);

INSERT INTO ORDERS (order#, customer#, orderdate, total)
VALUES (104, 4, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 400.20);

INSERT INTO ORDERS (order#, customer#, orderdate, total)
VALUES (105, 5, TO_DATE('2024-05-22', 'YYYY-MM-DD'), 100.00);

SELECT 
    CUSTOMERS.fname AS "First Name",
    CUSTOMERS.lname AS "Last Name",
    ORDERS.orderdate AS "Order Date",
    ORDERS.total AS "Total Amount"
FROM 
    CUSTOMERS
JOIN 
    ORDERS ON CUSTOMERS.customer# = ORDERS.customer#
WHERE 
    ORDERS.total > 150 AND 
    CUSTOMERS.city = 'CityA' AND 
    CUSTOMERS.state = 'CA' AND 
    ORDERS.orderdate > TO_DATE('2024-01-01', 'YYYY-MM-DD')
ORDER BY 
    CUSTOMERS.lname, CUSTOMERS.fname;
    
    


