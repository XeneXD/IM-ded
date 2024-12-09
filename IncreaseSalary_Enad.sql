use dept_employee;

drop procedure  IncreaseSalary;
delimiter $$


CREATE PROCEDURE IncreaseSalary()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE empID CHAR(3);
    DECLARE currentSalary DECIMAL(8,2);
    DECLARE departmentID VARCHAR(7);
    DECLARE empCount INT;
    DECLARE increaseRate DECIMAL(5,2);
    DECLARE errorMessage VARCHAR(255);

 
    DECLARE emp_cursor CURSOR FOR 
    SELECT empID, salary, depID 
    FROM employee;


    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 errorMessage = MESSAGE_TEXT;
        SELECT CONCAT('An error occurred: ', errorMessage) AS ErrorMessage;
        ROLLBACK;
    END;


    START TRANSACTION;

   
    OPEN emp_cursor;

    emp_loop: LOOP
        FETCH emp_cursor INTO empID, currentSalary, departmentID;

        IF done THEN
            LEAVE emp_loop;
        END IF;

      
        SELECT COUNT(*) INTO empCount
        FROM employee
        WHERE depID = departmentID;

       
        SELECT CONCAT('Processing Employee ID: ', empID, ' in Department: ', departmentID) AS DebugInfo;


        IF empCount < 100 THEN
            SET increaseRate = 0.05; 
        ELSE
            SET increaseRate = 0.075; 
        END IF;

      
        SELECT CONCAT('Employee Salary Increase Rate: ', increaseRate * 100, '%') AS DebugInfo;

     
        UPDATE employee
        SET salary = salary + (salary * increaseRate)
        WHERE empID = empID;

        
        SELECT CONCAT('Updated Salary for Employee ID ', empID, ': ', currentSalary + (currentSalary * increaseRate)) AS DebugInfo;
    END LOOP;

 
    CLOSE emp_cursor;

  
    COMMIT;

 
    SELECT 'All employee salaries have been updated successfully.' AS SuccessMessage;
END$$

DELIMITER ;



call IncreaseSalary();