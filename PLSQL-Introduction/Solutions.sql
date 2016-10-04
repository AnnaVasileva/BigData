/*Task 1*/
DECLARE
  CURSOR employee_cursor IS
    SELECT emp_id, emp_name FROM employees;
  id_num employees.emp_id%TYPE;
  name employees.emp_name%TYPE;
BEGIN
  OPEN employee_cursor;
  LOOP
    FETCH employee_cursor INTO id_num, name;
  END LOOP;
  CLOSE employee_cursor;
END;

/*Task 2*/
DECLARE
  CURSOR payment_cursor IS
    SELECT cust_id, payment, total_due FROM payment_table;
  cust_id payment_table.cust_id%TYPE;
  payment payment_table.payment%TYPE;
  total_due payment_table.total_due%TYPE;
BEGIN
  OPEN payment_cursor;
  WHILE payment_cursor < total_due LOOP
    FETCH payment_cursor INTO cust_id, payment, total_due;
    EXIT WHEN payment_cursor%NOTFOUND;
    INSERT INTO underpay_table
    VALUES (cust_id, 'Still Owes');
  END LOOP;
  CLOSE payment_cursor;
END;

/*Task 3*/
DECLARE
  CURSOR payment_cursor IS
    SELECT cust_id, payment, total_due FROM payment_table;
  cust_id payment_table.cust_id%TYPE;
  payment payment_table.payment%TYPE;
  total_due payment_table.total_due%TYPE;
BEGIN
  OPEN payment_cursor;
  FOR pay_rec IN payment_cursor LOOP
    IF pay_rec.payment < pay_rec.total_due THEN
      INSERT INTO underpay_table
      VALUES (pay_rec.cust_id, 'Still Owes');
    END IF;
  END LOOP;
  CLOSE payment_cursor;
END;

/*Task 4*/
SET serveroutput ON
BEGIN
  DECLARE
    AmtZero EXCEPTION;
    cCusID payment_table.cust_id%TYPE;
    fPayment payment_table.payment%TYPE;
    fTotalDue payment_table.total_due%TYPE;
    CURSOR payment_cursor IS
      SELECT cust_id, payment, total_due FROM payment_table;
    fOverPaid number(8, 2);
    fUnderPaid number(8, 2);
  BEGIN
    OPEN payment_cursor; 
    LOOP
      FETCH payment_cursor INTO
        cCustId, fPayment, fTotalDue;
      EXIT WHEN payment_cursor%NOTFOUND;
      IF (fTotalDue = 0) THEN
        RAISE AmtZero;
      END IF;
      IF (fPayment > fTotalDue) THEN
        fOverPaid := fPayment - fTotalDue;
        INSERT INTO pay_status_table (cust_id, status, amt_credit)
        VALUES (cCustId, 'Over Paid', fOverPaid);
      ELSIF (fPayment < fTotalDue) THEN
        fUnderPaid := fTotalDue - fPayment;
        INSERT INTO pay_status_table (cust_id, status, amt_credit)
        VALUES (cCustId, 'Still Owes', fUnderPaid);
      ELSE
        INSERT INTO pay_status_table
        VALUE (cCustId, 'Paid in full', null, null);
      END IF;
    END LOOP;
    CLOSE payment_cursor;
  EXCEPTION
    WHEN AmtZero THEN
      DBMS_OUTPUT.put_line ('Error: amount is zero. See your supervisor.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line ('Error: unknown error. See the DBA.');
  END;
END;

/*Task 5*/
SELECT name, pay_type, pay_rate, eff_date, 'Yes' due
FROM pay_table
WHERE eff_date < sysdate - 180
UNION ALL
SELECT name, pay_type, pay_rate, eff_date, 'No' due
FROM pay_table
WHERE eff_date >= sysdate - 180
ORDER BY 2, 3 DESC;

/*Task 6*/
CREATE TRIGGER pay_trigger
  AFTER UPDATE ON pay_table
  FOR EACH ROW
BEGIN
  INSERT INTO trans_table 
  VALUES ('Pay Change', :new.name, :old.pay_rate, :new.pay_rate, :new.eff_date);
END;

UPDATE pay_table
SET pay_rate = 15.50,
  eff_date = sysdate
WHERE name = 'Jeff Jennings';

/*Task 7*/
DECLARE
  HourlyPay number(4, 2);
  
/*Task 8*/
DECLARE
  CURSOR c1 IS
  SELECT * FROM customer_table
  WHERE city = 'Indianapolis';
  
/*Task 9*/
DECLARE
  UnknownCode EXCEPTION;
  
/*Task 10*/
IF (code = 'A') THEN
    UPDATE amount_table
    SET amt = 10;
  ELSIF (code = 'B') THEN
    UPDATE amount_table
    SET amt = 20;
  ELSE
    RAISE UnknownCode;
END IF;