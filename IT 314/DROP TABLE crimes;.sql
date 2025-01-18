DROP TABLE crimes;

-- Create the crimes table
CREATE TABLE crimes (
    crime_id NUMBER PRIMARY KEY,
    classification VARCHAR2(50),
    date_charged DATE,
    hearing_date DATE
);

-- Insert sample data into the crimes table with unique crime_id values
INSERT INTO crimes (crime_id, classification, date_charged, hearing_date)
VALUES (1, 'Theft', TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-16', 'YYYY-MM-DD'));

INSERT INTO crimes (crime_id, classification, date_charged, hearing_date)
VALUES (2, 'Assault', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-09-10', 'YYYY-MM-DD'));

INSERT INTO crimes (crime_id, classification, date_charged, hearing_date)
VALUES (3, 'Burglary', TO_DATE('2024-08-20', 'YYYY-MM-DD'), TO_DATE('2024-09-05', 'YYYY-MM-DD'));

INSERT INTO crimes (crime_id, classification, date_charged, hearing_date)
VALUES (4, 'Fraud', TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-09-20', 'YYYY-MM-DD'));

SELECT 
    crime_id,
    classification,
    date_charged,
    hearing_date,
    (hearing_date - date_charged) AS days_between
FROM 
    crimes
WHERE 
    (hearing_date - date_charged) > 14;


Prompt Jalu chaudhary
