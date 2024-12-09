use dept_employee;
delimiter $$

create procedure InsertEmployee( in empID varchar(10), in empFirstName varchar(50), in empLastName varchar(50),empGender char(1),depID varchar(10), salary decimal(8,2))
Begin
	declare depExists int;
    declare empExists int;
    
    select count(*) into empExists 
    from employee
    where employee.empID = empID;
    
    select count(*) into depExists 
    from department
    where department.depID = depID;
    
    if empExists > 0 then
    select concat('Error: Employee ID: ', empID, '  already exists.') as message;
    elseif depExists = 0 then
    select concat('Error: Department ID: ', depID, ' does not exists.') as message;
    
    else 
    insert into employee(empID, empFirstName, empLastName,empGender,depID,salary)
    values (empID, empFirstName, empLastName,empGender,depID,salary);
    
    update department
    set employeeCount = employeeCount + 1
    where depID = depID;
    select concat('Employee ', empFirstname, ' ', empLastName,' has been successfully added into the department ', depID) as message;
    end if;
    
End $$

delimiter ;

call InsertEmployee('E09', 'Young','Eun','F','HR', 90000.00);
call InsertEmployee('E02', 'Magetano', 'Alicia','F','Acctg',60000.00);
drop procedure InsertEmployee;	