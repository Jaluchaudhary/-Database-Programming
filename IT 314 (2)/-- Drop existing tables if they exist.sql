-- Drop existing tables if they exist
DROP TABLE bb_shopper;
DROP TABLE bb_basket;
DROP TABLE bb_basketitem;

-- Create bb_shopper table
CREATE TABLE bb_shopper (
    idShopper NUMBER PRIMARY KEY,
    promo CHAR(1) -- promo column for storing promotion codes
);

-- Create bb_basket table
CREATE TABLE bb_basket (
    idBasket NUMBER PRIMARY KEY,
    idShopper NUMBER, -- foreign key to bb_shopper
    CONSTRAINT fk_shopper FOREIGN KEY (idShopper) REFERENCES bb_shopper(idShopper)
);

-- Create bb_basketitem table
CREATE TABLE bb_basketitem (
    idBasket NUMBER,   -- foreign key to bb_basket
    idProduct NUMBER,  -- product ID
    quantity NUMBER,   -- quantity of items purchased
    price NUMBER,      -- price per item
    CONSTRAINT fk_basket FOREIGN KEY (idBasket) REFERENCES bb_basket(idBasket)
);

-- Insert sample data into bb_shopper
INSERT INTO bb_shopper (idShopper) VALUES (21);
INSERT INTO bb_shopper (idShopper) VALUES (22);
INSERT INTO bb_shopper (idShopper) VALUES (23);
INSERT INTO bb_shopper (idShopper) VALUES (24);
INSERT INTO bb_shopper (idShopper) VALUES (25);
INSERT INTO bb_shopper (idShopper) VALUES (26);
INSERT INTO bb_shopper (idShopper) VALUES (27);

-- Insert sample data into bb_basket
INSERT INTO bb_basket (idBasket, idShopper) VALUES (1, 21);
INSERT INTO bb_basket (idBasket, idShopper) VALUES (2, 22);
INSERT INTO bb_basket (idBasket, idShopper) VALUES (3, 23);
INSERT INTO bb_basket (idBasket, idShopper) VALUES (4, 24);
INSERT INTO bb_basket (idBasket, idShopper) VALUES (5, 25);
INSERT INTO bb_basket (idBasket, idShopper) VALUES (6, 26);
INSERT INTO bb_basket (idBasket, idShopper) VALUES (7, 27);

-- Insert sample data into bb_basketitem
INSERT INTO bb_basketitem (idBasket, idProduct, quantity, price) VALUES (1, 101, 3, 20); -- Total: 60
INSERT INTO bb_basketitem (idBasket, idProduct, quantity, price) VALUES (2, 102, 1, 150); -- Total: 150
INSERT INTO bb_basketitem (idBasket, idProduct, quantity, price) VALUES (3, 103, 2, 30);  -- Total: 60
INSERT INTO bb_basketitem (idBasket, idProduct, quantity, price) VALUES (4, 104, 4, 12);  -- Total: 48
INSERT INTO bb_basketitem (idBasket, idProduct, quantity, price) VALUES (5, 105, 6, 10);  -- Total: 60
INSERT INTO bb_basketitem (idBasket, idProduct, quantity, price) VALUES (6, 106, 3, 15);  -- Total: 45
INSERT INTO bb_basketitem (idBasket, idProduct, quantity, price) VALUES (7, 107, 5, 40);  -- Total: 200

COMMIT;

-- PL/SQL block to update promo codes based on total amount spent
DECLARE
   -- Cursor to fetch total amount spent by each shopper and apply FOR UPDATE
   CURSOR cur_shopper IS
     SELECT a.idShopper, a.promo, basket_totals.total
       FROM bb_shopper a
       JOIN (
           SELECT b.idShopper, SUM(bi.quantity * bi.price) AS total
           FROM bb_basketitem bi
           JOIN bb_basket b ON bi.idBasket = b.idBasket
           GROUP BY b.idShopper
       ) basket_totals ON a.idShopper = basket_totals.idShopper
       FOR UPDATE OF a.promo NOWAIT;

   lv_promo_txt CHAR(1);

BEGIN
   -- Cursor FOR loop iterates over each record in cur_shopper
   FOR rec_shopper IN cur_shopper LOOP
      -- Default promo code
      lv_promo_txt := 'X';

      -- Apply promotion code based on total amount spent
      IF rec_shopper.total > 100 THEN 
         lv_promo_txt := 'A'; -- Free shipping for total > 100
      ELSIF rec_shopper.total BETWEEN 50 AND 99 THEN 
         lv_promo_txt := 'B'; 
      END IF;    -- If the amount doesn't match any condition, promo remains 'X'

      -- Update the promo column if it's changed from the default
      IF lv_promo_txt <> 'X' THEN
         UPDATE bb_shopper
         SET promo = lv_promo_txt
         WHERE CURRENT OF cur_shopper;
      END IF;
   END LOOP;
   COMMIT;

   -- Output the number of rows updated
   --DBMS_OUTPUT.PUT_LINE('Prompt: Jalu Chaudhary');
END;
/

-- Query to display the total spent and the promo code for each shopper
SELECT s.idShopper AS "IDSHOPPER", 
       s.promo AS "P",
       SUM(bi.quantity * bi.price) AS "SUM (BI. QUANTITY*BI. PRICE)"
  FROM bb_shopper s
  JOIN bb_basket b ON s.idShopper = b.idShopper
  JOIN bb_basketitem bi ON b.idBasket = bi.idBasket
 GROUP BY s.idShopper, s.promo
 ORDER BY s.idShopper;




UPDATE bb_shopper
  SET promo = NULL;
UPDATE bb_shopper
  SET promo = 'B'
  WHERE idShopper IN (21, 23, 25);
UPDATE bb_shopper
  SET promo = 'A'
  WHERE idShopper = 22;
COMMIT;


BEGIN
  UPDATE bb_shopper
  SET promo = NULL
  WHERE promo IS NOT NULL;


  DBMS_OUTPUT.PUT_LINE('Rows updated: ' || SQL%ROWCOUNT);

END;
/







DECLARE
  lv_tax_num NUMBER(2,2);
BEGIN
  
  CASE 'NJ' 
    WHEN 'VA' THEN 
      lv_tax_num := .04;
    WHEN 'NC' THEN 
      lv_tax_num := .02;  
    WHEN 'NY' THEN 
      lv_tax_num := .06;  
    ELSE
      
      lv_tax_num := NULL; 
  END CASE;

 
  IF lv_tax_num IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'No tax');
  END IF;

  DBMS_OUTPUT.PUT_LINE('tax rate = ' || lv_tax_num);
EXCEPTION
  WHEN OTHERS THEN
   
    DBMS_OUTPUT.PUT_LINE('No tax');


    DBMS_OUTPUT.PUT_LINE('Prompt: Jalu Chaudhary');
END;
/
