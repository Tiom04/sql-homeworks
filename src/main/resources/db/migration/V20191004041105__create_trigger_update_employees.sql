create table employment_logs
(
    employment_log_id int,
    first_name varchar2(20),
    last_name varchar2(20),
    employment_action varchar2(5) check (employment_action in ('FIRED','HIRED')),
    employment_status_updtd_tmstmp timestamp
);

create or replace trigger on_employees_update
after insert or delete on employees
begin
    case
        when inserting then
            log_insert('HIRED');
        when deleting then
            log_insert('FIRED');
    end case;
end on_employees_update;

CREATE OR REPLACE PROCEDURE log_insert (employment_action in varchar) as
    employment_log_id number;
    first_name varchar2(20);
    last_name varchar2(20);
   BEGIN
      select count(*) into employment_log_id from employment_logs;
      select first_name into first_name from employees;
      select last_name into last_name from employees;
      insert into employment_logs (employment_log_id, first_name, last_name, employment_action, employment_status_updtd_tmstmp)
                values(employment_log_id + 1, first_name, last_name, employment_action, systimestamp);
   END log_insert;