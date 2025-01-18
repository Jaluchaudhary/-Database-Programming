-- Check if the probation table exists
/*SELECT table_name
FROM user_tables
WHERE table_name = 'PROBATION';  -- Ensure the name is in uppercase

-- Drop the probation table if it exists
DROP TABLE probation;

-- Create the probation table
CREATE TABLE probation (
    probation_id NUMBER PRIMARY KEY,
    criminal_id NUMBER,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (criminal_id) REFERENCES criminals(criminal_id)
);

-- Insert data into the probation table
INSERT INTO probation (probation_id, criminal_id, start_date, end_date)
VALUES (1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'));

INSERT INTO probation (probation_id, criminal_id, start_date, end_date)
VALUES (2, 2, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'));





SELECT c.name
FROM criminals c
WHERE EXISTS (
    SELECT 1
    FROM probation p
    WHERE p.criminal_id = c.criminal_id
);



SELECT table_name 
FROM user_tables 
WHERE table_name IN ('OFFICERS', 'BOOKINGS', 'OFFICER_STATISTICS');

CREATE TABLE officers (
    officer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100)
);

CREATE TABLE bookings (
    booking_id NUMBER PRIMARY KEY,
    officer_id NUMBER,
    crime_id NUMBER,
    FOREIGN KEY (officer_id) REFERENCES officers(officer_id)
);

CREATE TABLE officer_statistics (
    officer_id NUMBER PRIMARY KEY,
    crime_count NUMBER,
    FOREIGN KEY (officer_id) REFERENCES officers(officer_id)
);
INSERT INTO officers (officer_id, name) VALUES (1, 'Najme');
INSERT INTO officers (officer_id, name) VALUES (2, 'Sarada');
INSERT INTO bookings (booking_id, officer_id, crime_id) VALUES (1, 1, 1001);
INSERT INTO bookings (booking_id, officer_id, crime_id) VALUES (2, 1, 1002);
INSERT INTO bookings (booking_id, officer_id, crime_id) VALUES (3, 2, 1003);

INSERT INTO officer_crime_counts (officer_id, crime_count)
SELECT o.officer_id, COUNT(b.crime_id) AS crime_count
FROM officers o
JOIN bookings b ON o.officer_id = b.officer_id
GROUP BY o.officer_id;




MERGE INTO officer_statistics os
USING officer_crime_counts occ
ON (os.officer_id = occ.officer_id)
WHEN MATCHED THEN
    UPDATE SET os.crime_count = occ.crime_count
WHEN NOT MATCHED THEN
    INSERT (officer_id, crime_count) VALUES (occ.officer_id, occ.crime_count);

SELECT o.name
FROM officers o
JOIN officer_statistics os ON o.officer_id = os.officer_id
WHERE os.crime_count = (SELECT MAX(crime_count) FROM officer_statistics);

*/

-- Step 1: Drop foreign key constraints referencing the CRIMINALS table
-- Find constraints referencing the CRIMINALS table
-- Drop existing tables if they exist
DROP TABLE CRIMINALS_DW;
DROP TABLE CRIMINALS;

-- Create tables
CREATE TABLE CRIMINALS (
    criminal_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    date_of_birth DATE,
    address VARCHAR2(255),
    crime_record VARCHAR2(255)
);

CREATE TABLE CRIMINALS_DW (
    criminal_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    date_of_birth DATE,
    address VARCHAR2(255),
    crime_record VARCHAR2(255)
);

-- Insert sample data into CRIMINALS
INSERT ALL
    INTO CRIMINALS (criminal_id, name, date_of_birth, address, crime_record)
    VALUES (1, 'Najma Chy', TO_DATE('1980-01-01', 'YYYY-MM-DD'), '123 Winter fieldSt', 'Theft')
    INTO CRIMINALS (criminal_id, name, date_of_birth, address, crime_record)
    VALUES (2, 'Anita Chy', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'Fair Oak St', 'Fraud')
SELECT * FROM dual;

-- Merge data into CRIMINALS_DW

MERGE INTO CRIMINALS_DW dw
USING CRIMINALS prod
ON (dw.criminal_id = prod.criminal_id)
WHEN MATCHED THEN
    UPDATE SET 
        dw.name = prod.name,
        dw.date_of_birth = prod.date_of_birth,
        dw.address = prod.address,
        dw.crime_record = prod.crime_record
WHEN NOT MATCHED THEN
    INSERT (criminal_id, name, date_of_birth, address, crime_record)
    VALUES (prod.criminal_id, prod.name, prod.date_of_birth, prod.address, prod.crime_record);


SELECT * FROM CRIMINALS_DW;


Prompt Jalu Chaudhary