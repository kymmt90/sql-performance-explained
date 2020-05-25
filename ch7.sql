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

create index emp_up_name on employees (upper(last_name) varchar_pattern_ops);
create index emp_sub_upname on employees (subsidiary_id, upper(last_name) varchar_pattern_ops);

\copy employees from 'out/employees.csv' with csv

create table sales (
    sale_id bigint primary key,
    employee_id bigint references employees (employee_id) on delete restrict not null,
    subsidiary_id bigint not null,
    product_id bigint not null,
    eur_value money not null,
    quantity int not null,
    sale_date date not null
);

create index sales_emp on sales (subsidiary_id, employee_id);
create index sale_dt_pr on sales (sale_date, product_id);
create index sales_sub_eur on sales (subsidiary_id, eur_value);
create index sl_dtid on sales (sale_date, sale_id);

\copy sales from 'out/sales.csv' with csv
