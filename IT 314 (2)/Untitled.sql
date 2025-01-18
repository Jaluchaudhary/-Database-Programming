/*CREATE TABLE DONORS (
  donor_id NUMBER(6) PRIMARY KEY,
  last_name VARCHAR2(100)
);


CREATE TABLE PLEDGE_PAYMENTS (
  id NUMBER(6) PRIMARY KEY,
  donor_id NUMBER(6) REFERENCES DONORS(donor_id),
  pledge_id NUMBER(6),
  payment_amount NUMBER(8, 2),
  payment_date DATE,
  payment_method CHAR(2)
);

-- Insert Donor
INSERT INTO DONORS (donor_id, last_name)
VALUES (1, 'Doe');

-- Insert Payments
INSERT INTO PLEDGE_PAYMENTS (id, donor_id, pledge_id, payment_amount, payment_date, payment_method)
VALUES (101, 1, 1001, 100.00, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'CC');

INSERT INTO PLEDGE_PAYMENTS (id, donor_id, pledge_id, payment_amount, payment_date, payment_method)
VALUES (102, 1, 1002, 50.00, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 'CASH');

INSERT INTO PLEDGE_PAYMENTS (id, donor_id, pledge_id, payment_amount, payment_date, payment_method)
VALUES (103, 1, 1003, 75.00, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'CHECK');


-- Package Specification
CREATE OR REPLACE PACKAGE PLEDGE_PKG AS
  -- Public procedure to retrieve pledge payment information
  PROCEDURE DD_PAYS_PP(p_donor_id IN DONORS.donor_id%TYPE);
END PLEDGE_PKG;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY PLEDGE_PKG AS
  PROCEDURE DD_PAYS_PP(p_donor_id IN DONORS.donor_id%TYPE) IS
    v_donor_last_name DONORS.last_name%TYPE;

    CURSOR payment_cursor IS
      SELECT pp.id, pp.pledge_id, pp.payment_amount, pp.payment_date
        FROM PLEDGE_PAYMENTS pp
       WHERE pp.donor_id = p_donor_id;

    v_payment_amount PLEDGE_PAYMENTS.payment_amount%TYPE;
    v_payment_date PLEDGE_PAYMENTS.payment_date%TYPE;
  BEGIN
    -- Retrieve donor's last name
    BEGIN
      SELECT last_name
        INTO v_donor_last_name
        FROM DONORS
       WHERE donor_id = p_donor_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Donor not found!');
        RETURN;
    END;

    -- Output donor's last name
    DBMS_OUTPUT.PUT_LINE('Donor Last Name: ' || v_donor_last_name);

    -- Loop through the payment records for the donor
    FOR payment_record IN payment_cursor LOOP
      v_payment_amount := payment_record.payment_amount;
      v_payment_date := payment_record.payment_date;

      DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || payment_record.pledge_id);
      DBMS_OUTPUT.PUT_LINE('Payment Amount: ' || TO_CHAR(v_payment_amount, '999,999.99'));
      DBMS_OUTPUT.PUT_LINE('Payment Date: ' || TO_CHAR(v_payment_date, 'MM-DD-YYYY'));
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
    END LOOP;

  END DD_PAYS_PP;
END PLEDGE_PKG;
/
*/

SHOW ERRORS;


SET SERVEROUTPUT ON;


BEGIN
  PLEDGE_PKG.DD_PAYS_PP(1); 
END;
/


prompt Jalu Chaudhary