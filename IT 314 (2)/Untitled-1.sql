/*SET SERVEROUTPUT ON;

DECLARE
    v_total_purchases NUMBER := 160; 
    v_rating VARCHAR2(10);
BEGIN
    
    IF v_total_purchases > 200 THEN
        v_rating := 'High';
    ELSIF v_total_purchases > 100 THEN
        v_rating := 'Mid';
    ELSE
        v_rating := 'Low';
    END IF;


    DBMS_OUTPUT.PUT_LINE('Total Purchases: $' || v_total_purchases);
    DBMS_OUTPUT.PUT_LINE('Rating: ' || v_rating);
END;
/


SET SERVEROUTPUT ON;

DECLARE
    v_total_purchases NUMBER := 160; 
    v_rating VARCHAR2(10);
BEGIN
    
    v_rating := CASE
                    WHEN v_total_purchases > 200 THEN 'High'
                    WHEN v_total_purchases > 100 THEN 'Mid'
                    ELSE 'Low'
                END;

    
    DBMS_OUTPUT.PUT_LINE('Total Purchases: $' || v_total_purchases);
    DBMS_OUTPUT.PUT_LINE('Rating: ' || v_rating);
END;
/


SET SERVEROUTPUT ON;

DECLARE
    v_account_balance NUMBER := 160; 
    v_payment_received NUMBER := 100;  
    v_is_due BOOLEAN;  

BEGIN
  
    IF v_account_balance > v_payment_received THEN
        v_is_due := TRUE;  
    ELSE
        v_is_due := FALSE; 
    END IF;

   
    DBMS_OUTPUT.PUT_LINE('Account Balance: $' || v_account_balance);
    DBMS_OUTPUT.PUT_LINE('Payment Received: $' || v_payment_received);
    DBMS_OUTPUT.PUT_LINE('is there still amount due? ' || CASE WHEN v_is_due THEN 'TRUE' ELSE 'FALSE' END);
END;
/
SET SERVEROUTPUT ON;

DECLARE
    v_item_price NUMBER := 10;
    v_total_available NUMBER := 150;
    v_items_purchased NUMBER := 0;    
    v_total_spent NUMBER := 0;

BEGIN
    
    WHILE v_total_available >= v_item_price LOOP

        v_total_available := v_total_available - v_item_price;  
        v_items_purchased := v_items_purchased + 1;            
        v_total_spent := v_total_spent + v_item_price;         
    END LOOP;


    DBMS_OUTPUT.PUT_LINE('Total items purchased: ' || v_items_purchased);
    DBMS_OUTPUT.PUT_LINE('Amount of total spend: $' || v_total_spent);
END;
/
*/


SET SERVEROUTPUT ON;

DECLARE
    lv_membership_status CHAR(1) := 'Y'; 
    lv_items_purchased NUMBER := 5;       
    lv_shipping_cost NUMBER;              

BEGIN
  
    IF lv_items_purchased <= 3 THEN
        IF lv_membership_status = 'Y' THEN
            lv_shipping_cost := 3.00; 
        ELSE
            lv_shipping_cost := 5.00;
        END IF;
    ELSIF lv_items_purchased >= 4 AND lv_items_purchased <= 6 THEN
        IF lv_membership_status = 'Y' THEN
            lv_shipping_cost := 5.00; 
        ELSE
            lv_shipping_cost := 7.50; 
        END IF;
    ELSIF lv_items_purchased >= 7 AND lv_items_purchased <= 10 THEN
        IF lv_membership_status = 'Y' THEN
            lv_shipping_cost := 7.00; 
        ELSE
            lv_shipping_cost := 10.00; 
        END IF;
    ELSE 
        IF lv_membership_status = 'Y' THEN
            lv_shipping_cost := 9.00; 
        ELSE
            lv_shipping_cost := 12.00; 
        END IF;
    END IF;

   
    DBMS_OUTPUT.PUT_LINE('Membership Status: ' || lv_membership_status);
    DBMS_OUTPUT.PUT_LINE('Items Purchased: ' || lv_items_purchased);
    DBMS_OUTPUT.PUT_LINE('Shipping Cost: $' || lv_shipping_cost);
END;
/

Prompt Jalu Chsudhary