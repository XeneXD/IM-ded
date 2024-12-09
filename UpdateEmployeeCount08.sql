use  dept_employee;
delimiter $$

CREATE PROCEDURE UpdateEmployeeCount(in departmentID varchar(10))
BEGIN
declare empCount int;
declare depExists int;

select count(*) into depExists
from department
where department.depID = departmentID;

if depExists > 0 then
select count(*) into empCount
from employee
where employee.depID = departmentID;

update department
set employeeCount = empCount
where depID = departmentID;

select concat('Employee count updated to ', empCount, ' for department ',departmentID) as Message;
else
select concat('Error: Employee of ', departmentID, ' have no data listed') as Message;
end if;

END$$

delimiter ;

drop procedure UpdateEmployeeCount;
call UpdateEmployeeCount('Acctg');
call  UpdateEmployeeCount('Fin');

