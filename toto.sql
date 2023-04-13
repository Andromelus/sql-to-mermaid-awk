use db1;

create table toto;
create table db2.toto;
create table db1.titi;

create table db.from_target as select * from db.from_source
