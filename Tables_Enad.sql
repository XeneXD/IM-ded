create database dept_employee;
show tables;
create table department (
depID varchar(7) primary key,
depName varchar(20) not null,
employeeCount integer
);

create table employee (
empID char(3) primary key,
empLastName varchar(15) not null,
empFirstName varchar(15) not null,
empGender char(1) not null check (empGender in ('M' , 'F')),
depID varchar(7),
foreign key(depID) references department (depID),
salary decimal(8,2) not null
);

insert into  department (depID, depName, employeeCount) values
('Acctg', 'Accounting', 0),
('HR', 'Human Resource', 0),
('Mktg', 'Marketing', 0);

insert into employee( empID, empLastName, empFirstName, empGender, depID, salary) values
('E01', 'Baskerville', 'Viktor','M','HR', 50000.00),
('E02', 'Magetano', 'Alicia','F','Acctg',60000.00),
('E03', 'Frontera', 'Lloyd','M','Mktg',65000.00),
('E04', 'Dokja', 'Kim','M','Acctg',35000.00),  
('E05', 'Rothtaylor', 'Ed','M','Acctg',24000.00),  
('E06', 'Hajin', 'Kim','M','HR',32000.00),  
('E07', 'Cha', 'Sirin','F','Mktg',72000.00),  
('E08', 'Yoo', 'Nari','F','Acctg',67000.00);  

select * from department;
select * from employee;



