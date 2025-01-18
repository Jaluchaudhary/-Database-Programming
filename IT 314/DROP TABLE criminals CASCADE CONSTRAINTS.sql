DROP TABLE criminals CASCADE CONSTRAINTS;
DROP TABLE sentences CASCADE CONSTRAINTS;
DROP TABLE charges CASCADE CONSTRAINTS;

SELECT * FROM criminals;
SELECT * FROM sentences;
SELECT * FROM charges;

SELECT table_name 
FROM user_tables;

-- Create criminals table
CREATE TABLE criminals (
    criminal_id NUMBER PRIMARY KEY,
    name VARCHAR2(50)
);

-- Create sentences table
CREATE TABLE sentences (
    sentence_id NUMBER PRIMARY KEY,
    criminal_id NUMBER,
    start_date DATE,
    length_months NUMBER,
    FOREIGN KEY (criminal_id) REFERENCES criminals(criminal_id)
);

-- Create charges table
CREATE TABLE charges (
    charge_id NUMBER PRIMARY KEY,
    criminal_id NUMBER,
    fine_amount NUMBER,
    court_fee NUMBER,
    amount_paid NUMBER,
    payment_due_date DATE,
    FOREIGN KEY (criminal_id) REFERENCES criminals(criminal_id)
);

-- Insert data into criminals table
INSERT INTO criminals (criminal_id, name) 
VALUES (1, 'Pooja Smith');

INSERT INTO criminals (criminal_id, name) 
VALUES (2, 'Sapana Bhujel');

-- Insert data into sentences table
INSERT INTO sentences (sentence_id, criminal_id, start_date, length_months) 
VALUES (101, 1, TO_DATE('2009-12-17', 'YYYY-MM-DD'), 12);

INSERT INTO sentences (sentence_id, criminal_id, start_date, length_months) 
VALUES (102, 2, TO_DATE('2010-01-05', 'YYYY-MM-DD'), 24);

-- Insert data into charges table
INSERT INTO charges (charge_id, criminal_id, fine_amount, court_fee, amount_paid, payment_due_date)
VALUES (201, 1, 500.00, 50.00, NULL, TO_DATE('2024-10-15', 'YYYY-MM-DD'));

INSERT INTO charges (charge_id, criminal_id, fine_amount, court_fee, amount_paid, payment_due_date)
VALUES (202, 2, 750.00, 75.00, 200.00, TO_DATE('2024-09-30', 'YYYY-MM-DD'));


SELECT 
    c.name AS criminal_name,
    ch.charge_id,
    TO_CHAR(ch.fine_amount + ch.court_fee, '$999,999.00') AS total_amount_owed,
    CASE 
        WHEN ch.amount_paid IS NULL THEN NULL
        ELSE TO_CHAR(ch.amount_paid, '$999,999.00')
    END AS amount_paid,
    TO_CHAR((ch.fine_amount + ch.court_fee) - NVL(ch.amount_paid, 0), '$999,999.00') AS amount_owed,
    TO_CHAR(ch.payment_due_date, 'Month DD, YYYY') AS payment_due_date
FROM 
    criminals c
JOIN 
    charges ch ON c.criminal_id = ch.criminal_id
WHERE 
    (ch.fine_amount + ch.court_fee) - NVL(ch.amount_paid, 0) > 0;

SELECT 

    c.name AS criminal_name,
    TO_CHAR(s.start_date, 'Month DD, YYYY') AS probation_start_date,
    TO_CHAR(ADD_MONTHS(s.start_date, 2), 'Month DD, YYYY') AS review_date
FROM 
    criminals c
JOIN 
    sentences s ON c.criminal_id = s.criminal_id
WHERE 
    s.length_months > 2;

Prompt Jalu Chaudhary