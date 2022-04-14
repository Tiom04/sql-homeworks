-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);
-- 2. the first and last name, department, city, and state province for each employee.
SELECT first_name, last_name, department_name, city, state_province
FROM employees
         LEFT JOIN departments USING (department_id)
         LEFT JOIN locations USING (location_id);
-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT first_name, last_name, department_id as department_number, department_name
FROM employees
        LEFT JOIN departments USING (department_id)
        WHERE department_id IN(80,40);
-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT first_name, last_name, department_name, city, state_province
FROM employees
        LEFT JOIN departments USING (department_id)
        LEFT JOIN locations USING (location_id)
        WHERE first_name LIKE('%z%');
-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT first_name, last_name, salary
FROM employees
        WHERE salary < (SELECT salary from employees WHERE employee_id = 182);
-- 6. the first name of all employees including the first name of their manager.
SELECT E1.first_name, E2.first_name as manager_name
FROM employees E1, employees E2
        WHERE E1.manager_id = E2.employee_id;
-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT e.first_name, m.first_name as manager_name
FROM employees e
        LEFT JOIN employees m ON m.employee_id = e.manager_id;
-- 8. the details of employees who manage a department.
SELECT first_name, last_name, job_title
FROM employees e
        LEFT JOIN jobs USING(job_id)
        INNER JOIN departments d on e.employee_id = d.manager_id;
-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT e.first_name, e.last_name, e.department_id
FROM employees e
        JOIN employees d ON e.department_id = d.department_id
            WHERE d.last_name = 'Taylor';
--10. the department name and number of employees in each of the department.
SELECT d.department_name, count(*)
FROM employees e, departments d
        WHERE e.department_id = d.department_id
        GROUP BY d.department_name;
--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT d.department_name, cast(avg(e.salary) as decimal(6,2)), count(*)
FROM employees e, departments d
        WHERE e.department_id = d.department_id
        AND e.commission_pct > 0
        GROUP BY d.department_name;
--12. job title and average salary of employees.
SELECT j.job_title, avg(salary)
FROM employees e, jobs j
        WHERE e.job_id = j.job_id
        GROUP BY j.job_title;
--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT country_name, city, COUNT(department_id)
	FROM countries
		JOIN locations USING (country_id)
		JOIN departments USING (location_id)
            WHERE department_id IN(SELECT department_id
                FROM employees
        GROUP BY department_id
	 HAVING COUNT(department_id)>=2)
GROUP BY country_name,city;
--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT employee_id, job_title, (end_date-start_date) as number_of_days
FROM job_history
    NATURAL JOIN jobs
        WHERE department_id = 80;
--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT first_name, last_name
FROM employees
        WHERE salary > (SELECT salary FROM employees WHERE employee_id = 163);
--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT employee_id, first_name, last_name
FROM employees
        WHERE salary > (SELECT avg(salary) FROM employees);
--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT first_name, last_name, employee_id, salary
FROM employees
        WHERE manager_id = (SELECT employee_id from employees where first_name = 'Payam');
--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
select e.department_id, e.first_name, e.last_name, j.job_title, d.department_name
from employees e, departments d, jobs j
    where e.department_id = d.department_id
    and d.department_name = 'Finance';
--19. all the information of an employee whose id is any of the number 134, 159 and 183.
select * from employees where employee_id in (134, 159, 183);
--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
select * from employees left join jobs using(job_id) where salary between min_salary and 2500;
--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
select * from employees where department_id not in (select department_id from departments where employee_id between 100 and 200);
--22. all the information for those employees whose id is any id who earn the second highest salary.
select * from employees
where employee_id in (select employee_id from employees
    where salary = (select max(salary) from employees
        where salary < (select max(salary) from employees)));
--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
select first_name, last_name, hire_date
from employees
    where department_id = (select department_id from employees where first_name = 'Clara')
        and first_name <> 'Clara';
--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
select employee_id, first_name, last_name
from employees
    where department_id in (select department_id from employees where first_name like '%T%');
--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
select e.first_name, e.last_name, j.job_title, jh.start_date, jh.end_date
from employees e, jobs j, job_history jh
        where e.job_id = j.job_id
        and jh.job_id = j.job_id
        and e.commission_pct = 0;
--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
select employee_id, first_name, last_name, salary
from employees
    where salary > (select avg(salary) from employees)
    and department_id in (select department_id from employees where first_name like '%J%');
--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
select e.employee_id, e.first_name, e.last_name, j.job_title--as required(no such job title)
from employees e, jobs j
    where e.job_id = j.job_id
    and e.salary < any(select salary from employees where job_title = 'MK_MAN');
--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
select e.employee_id, e.first_name, e.last_name, j.job_title--as required(no such job title)
from employees e, jobs j
    where e.job_id = j.job_id
    and e.salary < any(select salary from employees where job_title = 'MK_MAN')
    and j.job_title <> 'MK_MAN';
--29. all the information of those employees who did not have any job in the past
select *
from employees
    where employee_id not in(select employee_id from job_history);
--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
select e.employee_id, e.first_name, e.last_name, j.job_title
from employees e, jobs j
where e.salary > all (select avg(salary) from employees group by department_id);
--end mandatory

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
    -- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
    -- the average salary of all employees.
--34. all the employees who earn more than the average and who work in any of the IT departments.
--35. who earns more than Mr. Ozer.
--36. which employees have a manager who works for a department based in the US.
--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
--47. the full name (first and last name) of manager who is supervising 4 or more employees.
--48. the details of the current job for those employees who worked as a Sales Representative in the past.
--49. all the infromation about those employees who earn second lowest salary of all the employees.
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
