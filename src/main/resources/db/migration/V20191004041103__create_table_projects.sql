create table projects (
    project_id int primary key,
    project_description varchar2(100) check (length(project_description) > 10),
    project_investments number(6,-3) check (project_investments >= 0),
    project_revenue int
);

create table employee_project (
    project_id int not null,
    employee_id int not null,
    hours_working int,

    constraint fk_proj FOREIGN KEY (project_id) REFERENCES projects(project_id),
    constraint fk_emp FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    UNIQUE (project_id, employee_id)
);