drop table customer;
CREATE TABLE customer (
    customer_id NUMBER PRIMARY KEY,
    last_name VARCHAR2(30) NOT NULL,
    first_name VARCHAR2(30) NOT NULL,
    state VARCHAR2(5),
    referred_by NUMBER
);
INSERT INTO customer (customer_id, last_name, first_name, state, referred_by)
VALUES (1, 'Khonama', 'Pooja', 'VA', NULL);

INSERT INTO customer (customer_id, last_name, first_name, state, referred_by)
VALUES (2, 'Bhujel', 'Sapana', 'WA', 3);

INSERT INTO customer (customer_id, last_name, first_name, state, referred_by)
VALUES (3, 'Sukmati', 'Chaudhary', 'MD', NULL);

SELECT c1.last_name AS referred_last_name, 
       c1.customer_id AS referred_customer_id, 
       c2.customer_id AS referring_customer_id
FROM customer c1
JOIN customer c2 ON c1.referred_by = c2.customer_id
WHERE c1.referred_by IS NOT NULL;

prompt Jalu Chaudhary