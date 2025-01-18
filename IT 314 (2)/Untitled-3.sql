SELECT *
FROM bb_basketstatus
WHERE idbasket = 3 AND idstage = 5;

UPDATE bb_basketstatus
SET notes = 'Customer called to confirm shipment'
WHERE idbasket = 3 AND idstage = 5;
  -- Ensure server output is enabled

DECLARE 
  rec_ship bb_basketstatus%ROWTYPE;  -- Record variable to hold row data
  lv_bask_num bb_basketstatus.idbasket%TYPE := 3;  -- Set the basket number to retrieve
BEGIN
 
  SELECT *
  INTO rec_ship
  FROM bb_basketstatus
  WHERE idbasket = lv_bask_num
    AND idstage = 5;  
 
  DBMS_OUTPUT.PUT_LINE('Date Shipped: ' || TO_CHAR(rec_ship.dtstage, 'DD-MON-YY'));  
  DBMS_OUTPUT.PUT_LINE('Shipper: ' || rec_ship.shipper);  
  DBMS_OUTPUT.PUT_LINE('Shipping #: ' || rec_ship.shippingnum); 
  DBMS_OUTPUT.PUT_LINE('Notes: ' || rec_ship.notes);  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No shipping information found for basket ID ' || lv_bask_num);  
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);  
END;
/



Prompt Jalu Chsudhary