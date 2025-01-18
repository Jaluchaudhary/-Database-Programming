CREATE OR REPLACE PACKAGE PLEDGE_PKG AS
  -- Function to calculate the first payment date
  FUNCTION DD_PAYDATE1_PF(p_id IN dd_pledge.idpledge%TYPE) RETURN DATE;

  -- Function to calculate the end payment date
  FUNCTION DD_PAYEND_PF(p_id IN dd_pledge.idpledge%TYPE) RETURN DATE;
END PLEDGE_PKG;
/


CREATE OR REPLACE PACKAGE BODY PLEDGE_PKG AS

  -- Function to calculate the first payment date
  FUNCTION DD_PAYDATE1_PF(p_id IN dd_pledge.idpledge%TYPE) RETURN DATE IS
    lv_pl_dat DATE;
    lv_mth_txt VARCHAR2(2);
    lv_yr_txt VARCHAR2(4);
  BEGIN
    -- Add 1 month to the pledge date
    SELECT ADD_MONTHS(pledgedate, 1)
      INTO lv_pl_dat
      FROM dd_pledge
      WHERE idpledge = p_id;

    lv_mth_txt := TO_CHAR(lv_pl_dat, 'MM');
    lv_yr_txt := TO_CHAR(lv_pl_dat, 'YYYY');

    -- Return the first day of the next month
    RETURN TO_DATE((lv_mth_txt || '-01-' || lv_yr_txt), 'MM-DD-YYYY');
  END DD_PAYDATE1_PF;

  -- Function to calculate the end payment date
  FUNCTION DD_PAYEND_PF(p_id IN dd_pledge.idpledge%TYPE) RETURN DATE IS
    lv_pay1_dat DATE;
    lv_mths_num dd_pledge.paymonths%TYPE;
  BEGIN
    -- Get the first payment date and the number of months
    SELECT DD_PAYDATE1_PF(idpledge), paymonths - 1
      INTO lv_pay1_dat, lv_mths_num
      FROM dd_pledge
      WHERE idpledge = p_id;

    -- If there are no months, return the first payment date
    IF lv_mths_num = 0 THEN
      RETURN lv_pay1_dat;
    ELSE
      -- Calculate the end payment date by adding the number of months
      RETURN ADD_MONTHS(lv_pay1_dat, lv_mths_num);
    END IF;
  END DD_PAYEND_PF;

END PLEDGE_PKG;
/


DECLARE
  v_paydate DATE;
  v_payend  DATE;
BEGIN
  
  
  v_paydate := PLEDGE_PKG.DD_PAYDATE1_PF(100); 
  
  DBMS_OUTPUT.PUT_LINE('First Payment Date: ' || TO_CHAR(v_paydate, 'MM-DD-YYYY'));

 
 
  v_payend := PLEDGE_PKG.DD_PAYEND_PF(100); 
  DBMS_OUTPUT.PUT_LINE('End Payment Date: ' || TO_CHAR(v_payend, 'MM-DD-YYYY'));
END;
/


SELECT 
  idpledge,
  PLEDGE_PKG.DD_PAYDATE1_PF(idpledge) AS first_payment_date,
  PLEDGE_PKG.DD_PAYEND_PF(idpledge) AS end_payment_date
FROM dd_pledge;





Prompt Jalu Chaudhary