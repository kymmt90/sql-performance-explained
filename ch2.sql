\connect postgres

create table employees (
    employee_id bigint primary key,
    subsidiary_id bigint not null,
    first_name varchar not null,
    last_name varchar not null,
    date_of_birth date not null,
    phone_number varchar not null,
    unique (subsidiary_id, employee_id)
);

create index emp_name on employees (last_name);
create index emp_up_name on employees (upper(last_name));
create index emp_subsid_dob on employees (subsidiary_id, date_of_birth);

\copy employees from 'out/employees.csv' with csv
