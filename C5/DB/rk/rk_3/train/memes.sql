-- Написать скалярную функцию, возвращающую количество сотрудников в возрастеот 18 до 40, выходивших более 3 храз.
create or replace function latecomers(dt date)
returns int language plpgsql as $$
begin
    return (
        select count(*) from (
            select distinct id from employee where
            extract(year from dt) - extract(year from birthdate) between 18 and 40 and id in (
                select id_emp from (
                    select id_emp, visit_date, visit_type, count(*) from visits where
                    visit_date = dt group by id_emp, visit_date, visit_type 
                    having visit_type = 2 and count(*) > 3
                ) as latecomers
            )
        ) as res
    );
end; $$;

select * from latecomers('20-12-2020'::date);


drop database if exists rk3;
create database rk3;
\c rk3;

create table employee (
    id serial primary key,
    name text,
    birthdate date,
    department text
);

create table visits (
    id_emp int,
    visit_date date,
    day_week text,
    visit_time time,
    visit_type int
);

set datestyle to SQL,dmy;
set datestyle = dmy;

insert into employee (name, birthdate, department) values
    ('Pavel Perestoronin', '05-09-2000', 'Qoollo'),
    ('Sergey Kononenko', '04-03-2000', 'Frontend'),
    ('Alexey Romanov', '06-11-2000', 'Remix Lounge'),
    ('Dmitry Yakuba', '06-06-1996', 'Oracle'),
    ('Mikhail Yurich', '13-04-1990', 'Arrival');

insert into visits (id_emp, visit_date, day_week, visit_time, visit_type) values 
    (1, '20-12-2020', 'Saturday', '9:00', 1),
    (1, '20-12-2020', 'Saturday', '9:40', 2),
    (1, '20-12-2020', 'Saturday', '11:00', 1),
    (1, '20-12-2020', 'Saturday', '18:00', 2),

    (2, '20-12-2020', 'Saturday', '9:00', 1),
    (2, '20-12-2020', 'Saturday', '9:40', 2),
    (2, '20-12-2020', 'Saturday', '11:00', 1),
    (2, '20-12-2020', 'Saturday', '18:00', 2),

    (2, '21-12-2020', 'Monday', '9:00', 1),
    (2, '21-12-2020', 'Monday', '18:00', 2),

    (3, '21-12-2020', 'Monday', '10:00', 1),
    (3, '21-12-2020', 'Monday', '17:00', 2),

    (4, '21-12-2020', 'Monday', '9:00', 1),
    (4, '21-12-2020', 'Monday', '20:00', 2),

    (5, '22-12-2020', 'Tuesday', '9:00', 1),
    (5, '22-12-2020', 'Tuesday', '10:00', 2),
    (5, '22-12-2020', 'Tuesday', '11:00', 1),
    (5, '22-12-2020', 'Tuesday', '12:00', 2);
