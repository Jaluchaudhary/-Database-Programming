-- Create bb_product table
CREATE TABLE bb_product (
    idProduct NUMBER PRIMARY KEY,
    stock NUMBER -- stock available for each product
);

-- Create bb_basketitem table
CREATE TABLE bb_basketitem (
    idBasket NUMBER,      -- basket ID
    idProduct NUMBER,     -- product ID (foreign key to bb_product)
    quantity NUMBER,      -- quantity requested for the product
    CONSTRAINT fk_product FOREIGN KEY (idProduct) REFERENCES bb_product(idProduct)
);

-- Insert sample data into bb_product
INSERT INTO bb_product (idProduct, stock) VALUES (1, 10);
INSERT INTO bb_product (idProduct, stock) VALUES (2, 5);
INSERT INTO bb_product (idProduct, stock) VALUES (3, 20);

-- Insert sample data into bb_basketitem
INSERT INTO bb_basketitem (idBasket, idProduct, quantity) VALUES (6, 1, 5);
INSERT INTO bb_basketitem (idBasket, idProduct, quantity) VALUES (6, 2, 6); -- Quantity greater than stock for testing
INSERT INTO bb_basketitem (idBasket, idProduct, quantity) VALUES (6, 3, 10);

COMMIT;

-- PL/SQL block to check if all items are in stock
DECLARE
   CURSOR cur_basket IS
     SELECT bi.idBasket, bi.quantity, p.stock
       FROM bb_basketitem bi INNER JOIN bb_product p
         ON bi.idProduct = p.idProduct
       WHERE bi.idBasket = 6;
   
   TYPE type_basket IS RECORD (
     basket bb_basketitem.idBasket%TYPE,
     qty bb_basketitem.quantity%TYPE,
     stock bb_product.stock%TYPE);
   rec_basket type_basket;

   lv_flag_txt CHAR(1) := 'Y';

BEGIN
   
   LOOP 
     FETCH cur_basket INTO rec_basket;
      EXIT WHEN cur_basket%NOTFOUND;

      IF rec_basket.stock < rec_basket.qty THEN
         lv_flag_txt := 'N';
      END IF;
   END LOOP;
   
   CLOSE cur_basket;

   IF lv_flag_txt = 'Y' THEN 
      DBMS_OUTPUT.PUT_LINE('All items in stock!'); 
   ELSE
      DBMS_OUTPUT.PUT_LINE('All items NOT in stock!'); 
   END IF;   
END;
/

Prompt By: Jaluchaudhary
