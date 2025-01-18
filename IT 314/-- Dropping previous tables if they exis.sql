-- Dropping previous tables if they exist
DROP TABLE New_Customers CASCADE CONSTRAINTS;
DROP TABLE New_Orders CASCADE CONSTRAINTS;
DROP TABLE Books CASCADE CONSTRAINTS;
DROP TABLE Order_Details CASCADE CONSTRAINTS;

-- Creating New_Customers table with a state column
CREATE TABLE New_Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL
);

-- Creating New_Orders table
CREATE TABLE New_Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    shipped_date DATE,
    FOREIGN KEY (customer_id) REFERENCES New_Customers(customer_id)
);

-- Creating Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    category VARCHAR(50)
);

-- Creating Order_Details table
CREATE TABLE Order_Details (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES New_Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Inserting data into New_Customers (one row per insert statement)
INSERT INTO New_Customers (customer_id, customer_name, state) 
VALUES (1, 'Ali Jama', 'Florida');

INSERT INTO New_Customers (customer_id, customer_name, state) 
VALUES (2, 'Jane Pooja', 'Texas');

INSERT INTO New_Customers (customer_id, customer_name, state) 
VALUES (3, 'Robert Maya', 'Florida');

-- Inserting data into New_Orders (one row per insert statement)
INSERT INTO New_Orders (order_id, customer_id, order_date, shipped_date) 
VALUES (101, 1, TO_DATE('2024-09-20', 'YYYY-MM-DD'), NULL);

INSERT INTO New_Orders (order_id, customer_id, order_date, shipped_date) 
VALUES (102, 2, TO_DATE('2024-09-18', 'YYYY-MM-DD'), TO_DATE('2024-09-22', 'YYYY-MM-DD'));

INSERT INTO New_Orders (order_id, customer_id, order_date, shipped_date) 
VALUES (103, 3, TO_DATE('2024-09-21', 'YYYY-MM-DD'), NULL);

-- Inserting data into Books (one row per insert statement)
INSERT INTO Books (book_id, title, category) 
VALUES (1, 'Learning Java', 'Computers');

INSERT INTO Books (book_id, title, category) 
VALUES (2, 'Cooking 101', 'Cooking');

INSERT INTO Books (book_id, title, category) 
VALUES (3, 'Data Science Essentials', 'Computers');

-- Inserting data into Order_Details (one row per insert statement)
INSERT INTO Order_Details (order_id, book_id, quantity) 
VALUES (101, 1, 1);

INSERT INTO Order_Details (order_id, book_id, quantity) 
VALUES (102, 2, 1);

INSERT INTO Order_Details (order_id, book_id, quantity) 
VALUES (103, 3, 1);

SELECT 
    c.customer_name, 
    c.state, 
    b.title AS book_title
FROM 
    New_Customers c
JOIN 
    New_Orders o ON c.customer_id = o.customer_id
JOIN 
    Order_Details od ON o.order_id = od.order_id
JOIN 
    Books b ON od.book_id = b.book_id
WHERE 
    c.state = 'Florida'
AND 
    b.category = 'Computers';

   