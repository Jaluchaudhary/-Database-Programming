drop table officers;
drop table communities;
CREATE TABLE officers (
    officer_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    precinct_code VARCHAR2(10),
    status VARCHAR2(10)
);

CREATE TABLE communities (
    second_letter CHAR(1) PRIMARY KEY,
    community_description VARCHAR2(100)
);

INSERT INTO communities (second_letter, community_description)
VALUES ('A', 'Downtown');

INSERT INTO communities (second_letter, community_description)
VALUES ('B', 'North Side');

INSERT INTO communities (second_letter, community_description)
VALUES ('C', 'West End');

INSERT INTO communities (second_letter, community_description)
VALUES ('D', 'East Side');




INSERT INTO officers (officer_id, name, precinct_code, status)
VALUES (1, 'Officer A', 'P1A', 'active');

INSERT INTO officers (officer_id, name, precinct_code, status)
VALUES (2, 'Officer B', 'P2B', 'active');
INSERT INTO officers (officer_id, name, precinct_code, status)
VALUES (3, 'Officer C', 'P1C', 'inactive');  -- Inactive officer

INSERT INTO officers (officer_id, name, precinct_code, status)
VALUES (4, 'Officer D', 'P2D', 'active');  -- Active officer

INSERT INTO communities (second_letter, community_description)
VALUES ('A', 'Downtown');

INSERT INTO communities (second_letter, community_description)
VALUES ('B', 'North Side');

SELECT * FROM officers;
SELECT * FROM communities;


SELECT table_name 
FROM user_tables 
WHERE table_name IN ('OFFICERS', 'COMMUNITIES');
SELECT 
    o.officer_id,
    o.name,
    o.precinct_code,
    c.community_description
FROM 
    officers o
JOIN 
    communities c ON SUBSTR(o.precinct_code, 2, 1) = c.second_letter
WHERE 
    o.status = 'active';

prompt Jalu Chaudhary