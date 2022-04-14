insert into regions values(1,'chishinau');

insert into countries values('md','moldova',1);

insert into locations (location_id, street_address, postal_code, city, state_province, country_id)
    values(1, 'arborilor', '2060', 'chishinau', 'mold', 'md');

insert into departments (department_id,department_name,manager_id,location_id) values(1,'java',null,1);

insert into jobs values(1,'developer',1000,9000);

insert into employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
    values(1,'artiom','banar','ab@endava.com','+37312345679','15-july-2022',1,2500,null,null,1);

insert into job_history values(1,'06-july-2020','07-september-2020',1,1);