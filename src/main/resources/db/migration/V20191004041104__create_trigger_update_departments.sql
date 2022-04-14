alter table locations add department_amount int;

COMMENT ON COLUMN locations.department_amount IS 'Contains the amount of departments in the location';

create or replace trigger on_departments_update
after insert or delete on departments
for each row
begin
        if inserting then
            update locations set department_amount = department_amount + 1
                        where location_id =:new.location_id;
        elsif deleting then
            update locations set department_amount = department_amount - 1
                        where location_id =:old.location_id;
    end if;
end on_departments_update;