DROP TABLE sentences;
DROP TABLE criminals;

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

insert into criminals (criminal_id,name) 
VALUES (01, 'pooja Smith');

insert into criminals (criminal_id,name) 
values (02, 'Sapana bhujel');

INSERT INTO sentences (sentence_id, criminal_id, start_date, length_months) 
VALUES (101, 1, TO_DATE('2009-12-17', 'YYYY-MM-DD'), 12);
INSERT INTO sentences (sentence_id, criminal_id, start_date, length_months) 
VALUES (102, 2, TO_DATE('2010-01-05', 'YYYY-MM-DD'), 24);

SELECT 
    s.criminal_id,
    UPPER(c.name) AS name,
    s.sentence_id,
    TO_CHAR(s.start_date, 'Month DD, YYYY') AS sentence_start_date,
    FLOOR(s.length_months) AS length_in_months
FROM 
    sentences s
JOIN 
    criminals c ON s.criminal_id = c.criminal_id;

SELECT AVG(total_sales - total_cost) AS average_profit
FROM ORDERS;

Prompt Jalu Chaudhary