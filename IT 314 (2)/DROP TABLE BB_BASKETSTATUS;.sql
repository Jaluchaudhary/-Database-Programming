DROP TABLE BB_BASKETSTATUS;
 CREATE TABLE BB_BASKETSTATUS (
  idbasket      NUMBER,          -- Basket ID
  idstage       NUMBER,          -- Stage ID (e.g., shipping stage)
  dtstage       DATE,            -- Date of the stage (e.g., shipping date)
  shipper       VARCHAR2(100),   -- Shipper's name
  shippingnum   VARCHAR2(50)     -- Shipping number or tracking code
);

INSERT INTO BB_BASKETSTATUS (idbasket, idstage, dtstage, shipper, shippingnum)
VALUES (3, 5, TO_DATE('25-JAN-2012', 'DD-MON-YYYY'), 'UPS', 'ZW845584GD89H569');

COMMIT;

DECLARE
  lv_ship_date DATE;
  lv_shipper_txt VARCHAR2(100);  
  lv_ship_num VARCHAR2(50);      
  lv_bask_num NUMBER := 3;
BEGIN
  BEGIN
    SELECT dtstage, shipper, shippingnum
      INTO lv_ship_date, lv_shipper_txt, lv_ship_num
      FROM BB_BASKETSTATUS
     WHERE idbasket = lv_bask_num
       AND idstage = 5;

    DBMS_OUTPUT.PUT_LINE('Date Shipped: ' || TO_CHAR(lv_ship_date, 'DD-MON-YY'));
    DBMS_OUTPUT.PUT_LINE('Shipper: ' || lv_shipper_txt);
    DBMS_OUTPUT.PUT_LINE('Shipping #: ' || lv_ship_num);
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No shipping information found for basket ID ' || lv_bask_num);
  END;
END;
/

