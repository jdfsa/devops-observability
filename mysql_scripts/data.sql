use db;

drop table if exists user;
create table user (
    id int,
    name varchar(100)
);

create table another (
    id int,
    name varchar(100)
);

insert into user values (1, 'admin');
