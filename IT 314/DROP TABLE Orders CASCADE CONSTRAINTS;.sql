DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Books CASCADE CONSTRAINTS;
DROP TABLE Authors CASCADE CONSTRAINTS;

CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);
INSERT INTO Authors (author_id, first_name, last_name) VALUES (1, 'John', 'Doe');
INSERT INTO Authors (author_id, first_name, last_name) VALUES (2, 'Jane', 'Smith');

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) -- Adding the foreign key constraint
);
INSERT INTO Books (book_id, title, author_id) VALUES (101, 'Book Title 1', 1);
INSERT INTO Books (book_id, title, author_id) VALUES (102, 'Book Title 2', 1);
INSERT INTO Books (book_id, title, author_id) VALUES (103, 'Book Title 3', 2);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    book_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Orders (order_id, book_id, order_date, quantity) VALUES (201, 101, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 3);
INSERT INTO Orders (order_id, book_id, order_date, quantity) VALUES (202, 102, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 1);
INSERT INTO Orders (order_id, book_id, order_date, quantity) VALUES (203, 103, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 5);
INSERT INTO Orders (order_id, book_id, order_date, quantity) VALUES (204, 101, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 2);

SELECT 
    Authors.last_name AS "Last Name",
    Authors.first_name AS "First Name",
    Books.title AS "Book Title",
    Orders.order_date AS "Order Date",
    Orders.quantity AS "Quantity"
FROM 
    Orders
JOIN 
    Books USING (book_id)
JOIN 
    Authors USING (author_id)
WHERE 
    Orders.order_date >= TO_DATE('2024-01-01', 'YYYY-MM-DD') AND
    Orders.quantity > 1
ORDER BY 
    Authors.last_name, Authors.first_name, Books.title;

SELECT 
    Authors.last_name AS "Last Name",
    Authors.first_name AS "First Name",
    Books.title AS "Book Title",
    Orders.order_date AS "Order Date",
    Orders.quantity AS "Quantity"
FROM 
    Orders
JOIN 
    Books USING (book_id)
JOIN 
    Authors USING (author_id)
WHERE 
    Orders.quantity > 1 AND 
    Orders.order_date >= TO_DATE('2024-01-01', 'YYYY-MM-DD') 
ORDER BY 
    Authors.last_name, Authors.first_name, Books.title;

SELECT 
    Authors.last_name AS "Last Name",
    Authors.first_name AS "First Name",
    Books.title AS "Book Title",
    Orders.order_date AS "Order Date",
    Orders.quantity AS "Quantity"
FROM 
    Orders
JOIN 
    Books ON Orders.book_id = Books.book_id
JOIN 
    Authors ON Books.author_id = Authors.author_id
WHERE 
    Orders.order_date >= TO_DATE('2024-01-01', 'YYYY-MM-DD') AND
    Orders.quantity > 1 AND 
    Authors.last_name = 'Doe' AND 
    Orders.order_date <= TO_DATE('2024-04-30', 'YYYY-MM-DD') 
ORDER BY 
    Authors.last_name, Authors.first_name, Books.title;


SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Books
JOIN 
    Authors ON Books.author_id = Authors.author_id;

SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Orders
JOIN 
    Books ON Orders.book_id = Books.book_id
JOIN 
    Authors ON Books.author_id = Authors.author_id;

-- Using UNION
SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Books
JOIN 
    Authors ON Books.author_id = Authors.author_id

UNION

SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Orders
JOIN 
    Books ON Orders.book_id = Books.book_id
JOIN 
    Authors ON Books.author_id = Authors.author_id;

-- Using UNION ALL
SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Books
JOIN 
    Authors ON Books.author_id = Authors.author_id

UNION ALL

SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Orders
JOIN 
    Books ON Orders.book_id = Books.book_id
JOIN 
    Authors ON Books.author_id = Authors.author_id;

-- Using INTERSECT
SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Books
JOIN 
    Authors ON Books.author_id = Authors.author_id

INTERSECT

SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Orders
JOIN 
    Books ON Orders.book_id = Books.book_id
JOIN 
    Authors ON Books.author_id = Authors.author_id;

-- Using MINUS
SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Books
JOIN 
    Authors ON Books.author_id = Authors.author_id

MINUS

SELECT 
    Books.title AS "Book Title", 
    Authors.last_name AS "Author Last Name"
FROM 
    Orders
JOIN 
    Books ON Orders.book_id = Books.book_id
JOIN 
    Authors ON Books.author_id = Authors.author_id;


SELECT 
    a1.first_name AS "Author 1 First Name",
    a1.last_name AS "Author 1 Last Name",
    a2.first_name AS "Author 2 First Name",
    a2.last_name AS "Author 2 Last Name"
FROM 
    Authors a1
JOIN 
    Authors a2 ON a1.last_name = a2.last_name
WHERE 
    a1.author_id <> a2.author_id; 

Prompt Jalu Chaudhary