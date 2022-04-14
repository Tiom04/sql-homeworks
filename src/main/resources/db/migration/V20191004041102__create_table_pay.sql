create table PAY (
    cardNr int primary key,
    salary number(8,2),
    commission_pct number(2,2)
);

alter table employees add cardNr int;

alter table employees add constraint card_number_fk
    FOREIGN KEY (cardNr) references pay(cardNr);

insert into PAY (salary, commission_pct) select salary, commission_pct from employees;