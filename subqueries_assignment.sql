Create database Assignment_Subqueries;
use assignment_Subqueries;


Create table Employee 
(
    emp_id int primary key,
	name varchar(50),
	department_id varchar(10),
     salary int 
     );

Insert into Employee 
values
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);


create table Department (
    department_id varchar(10),
    department_name varchar(50),
    location varchar(40));
    
    
    Insert into Department
    values
    ('D01', 'Sales', 'Mumbai'),
    ('D02', 'Marketing', 'Delhi'),
    ('D03', 'Finance', 'Pune'),
    ('D04', 'HR', 'Bengaluru'),
    ('D05', 'IT', 'Hyderabad');
    
    
Create table Sales (
    sale_id int primary key,
    emp_id int ,
    sale_amount int,
    sale_date date
);

Insert into Sales
values
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');



-- Q.1  Retrieve the names of employees who earn more than the average salary of all employees

select name from employee
  where salary > (select avg(salary)
     from employee);


-- Q.2  Find the employees who belong to the department with the highest average salary 

select name 
from employee 
where department_id = (
	select department_id
	from employee
	group by department_id
    order by avg(salary) desc 
    limit 1);
    
    
-- Q.3  List all employees who have made at least one sale 

select distinct name 
	from employee
	where emp_id in (select emp_id from sales)
    
    
-- Q.4  Find the employee with the highest sale amount 

SELECT name
FROM employee
WHERE emp_id IN (
    SELECT emp_id
    FROM sales
    WHERE sale_amount = (SELECT MAX(sale_amount) FROM sales)
);




-- Q.5  Retrieve the names of employees whose salaries are higher than shubham's salary. 

select name 
from employee
where salary > (
    select salary 
	from employee 
	where name = 'shubham'
);



--  Intermediate Level 


-- Q.1  Find employees who work in the same department as Abhishek. 

select name 
from employee
where department_id = (
	select department_id 
	from employee 
	where name = 'Abhishek'
);


-- Q.2  List departments that have at least one employee earning more than 60,000. 

select distinct department_id
from employee
where salary > 60000;


-- Q.3  Find the department name of the employee who made the highest sale. 

select department_name
from department
where department_id = (
	select department_id
	from employee
	where emp_id = (
		select emp_id 
		from sales
		order by sale_amount desc 
		limit 1 )
);


-- Q.4  Retrieve employees who have made sales greater than the average sale amount. 

select name
from employee 
where emp_id in (
	select emp_id  
	from sales  
	where sale_amount > (
		select avg(sale_amount)
		from sales)
); 


-- Q.5  Find the total sales made by employees who earn more than the average salary. 

select sum(sale_amount)
from sales
where emp_id in (
	select emp_id from employee
	where salary > (
		select avg(salary)
		from employee)
);


-- Advance Level


-- Q.1  Find employees who have not made any sales. 

select name from employee
	where emp_id not in (
		select emp_id from sales);


-- Q.2  List departments where the average salary is above 55,000. 

select department_id, avg(salary) as avg_salary
from employee
group by department_id
having avg(salary) > 55000;


-- Q.3  Retrieve department names where the total sales exceed 10,000. 

select d.department_name, sum(s.sale_amount) as total_sales
from employee e 
	join department d on e.department_id = d.department_id
	join sales s on e.emp_id = s.emp_id
		group by d.department_name
having sum(s.sale_amount) > 10000;


-- Q.4  Find the employee who has made the second-highest sale. 

select e.emp_id, e.name, s.sale_amount
from employee e 
join sales s on e.emp_id = s.emp_id
order by s.sale_amount desc
limit 1 offset 1;


-- Q.5  Retrieve the names of employees whose salary is greater than the highest sale amount recorded. 

select name, salary
from employee
where salary > (
select max(sale_amount) from sales);
    