-- Drop existing tables if they exist
DROP TABLE Loans CASCADE CONSTRAINTS;
DROP TABLE Members CASCADE CONSTRAINTS;
DROP TABLE Books CASCADE CONSTRAINTS;
DROP TABLE Authors CASCADE CONSTRAINTS;

-- Create Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100)
);

-- Create Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author_id INT,
    price DECIMAL(5, 2),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Create Members table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100)
);

-- Create Loans table
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Insert data into Authors table
INSERT INTO Authors (author_id, author_name) VALUES (1, 'John Smith');
INSERT INTO Authors (author_id, author_name) VALUES (2, 'Jane Doe');
INSERT INTO Authors (author_id, author_name) VALUES (3, 'Alice Johnson');

-- Insert data into Books table
INSERT INTO Books (book_id, title, author_id, price) VALUES (101, 'SQL for Beginners', 1, 29.99);
INSERT INTO Books (book_id, title, author_id, price) VALUES (102, 'Advanced SQL', 2, 49.99);
INSERT INTO Books (book_id, title, author_id, price) VALUES (103, 'Database Design', 3, 39.99);

-- Insert data into Members table
INSERT INTO Members (member_id, member_name) VALUES (1, 'Tom Hanks');
INSERT INTO Members (member_id, member_name) VALUES (2, 'Emma Watson');

-- Insert data into Loans table
INSERT INTO Loans (loan_id, book_id, member_id, loan_date, return_date) VALUES (1, 101, 1, TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO Loans (loan_id, book_id, member_id, loan_date, return_date) VALUES (2, 101, 2, TO_DATE('2024-10-06', 'YYYY-MM-DD'), TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO Loans (loan_id, book_id, member_id, loan_date, return_date) VALUES (3, 102, 1, TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'));


/*
SELECT book_id, title
FROM Books
WHERE author_id IN (
    SELECT a.author_id
    FROM Authors a
    WHERE a.author_name LIKE 'J%'
)
AND book_id IN (
    SELECT l.book_id
    FROM Loans l
    GROUP BY l.book_id
    HAVING COUNT(l.loan_id) >= 2
);


SELECT book_id, title, price
FROM Books
WHERE price > (
    SELECT price
    FROM Books
    WHERE title = 'SQL for Beginners'
);

COLUMN loan_id FORMAT A5
COLUMN member_name FORMAT A20
COLUMN title FORMAT A20
COLUMN author_name FORMAT A20
COLUMN loan_date FORMAT A10


SELECT l.loan_id, m.member_name, b.title, a.author_name, l.loan_date
FROM Loans l
JOIN Members m ON l.member_id = m.member_id
JOIN Books b ON l.book_id = b.book_id
JOIN Authors a ON b.author_id = a.author_id
WHERE b.author_id = (
    SELECT b2.author_id
    FROM Books b2
    ORDER BY b2.price DESC
    FETCH FIRST 1 ROWS ONLY
);




SELECT b.book_id, b.title, a.author_name
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
WHERE b.book_id IN (
    SELECT l.book_id
    FROM Loans l
    JOIN Members m ON l.member_id = m.member_id
    JOIN Books b2 ON l.book_id = b2.book_id
    WHERE m.member_name LIKE 'Tom%'
);
*/



SELECT book_id, title, price
FROM Books
WHERE price > (
    SELECT price
    FROM Books
    WHERE title = 'SQL for Beginners'
);


Prompt Jalu Chaudhary