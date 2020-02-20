create table SUPPLIERS(sid int primary key, sname varchar2(10), address varchar2(10));

create table PARTS(pid int primary key, pname varchar2(10), color varchar2(10));

create table CATALOG(sid int, pid int, cost float, primary key(sid,pid), foreign key(sid) references SUPPLIERS(sid), foreign key(pid) references PARTS(pid));


insert into SUPPLIERS values(&sid, '&sname', '&address');

insert into SUPPLIERS values(15, 'Mercedes', 'Berlin');

insert into SUPPLIERS values(16, 'BMW', 'Munich');

insert into SUPPLIERS values(17, 'Tesla', 'Bay Area');

insert into SUPPLIERS values(18, 'Acme', 'Mumbai');

insert into SUPPLIERS values(19, 'Tata', 'Surat');


insert into PARTS values(41, 'Screw', 'Silver');

insert into PARTS values(42, 'Bolt', 'Brown');

insert into PARTS values(43, 'Wheel', 'Black');

insert into PARTS values(44, 'Paint', 'Red');

insert into PARTS values(45, 'Clutch', 'Red');

insert into PARTS values(46, 'Cup', 'Blue');

insert into PARTS values(47, 'Cup', 'Red');


insert into CATALOG values(18, 41, 1.5);

insert into CATALOG values(19, 41, 2.5);

insert into CATALOG values(18, 42, 1.5);

insert into CATALOG values(19, 42, 3.5);

insert into CATALOG values(15, 43, 40);

insert into CATALOG values(16, 43, 37);

insert into CATALOG values(17, 44, 15.5);

insert into CATALOG values(15, 45, 19);


select * from SUPPLIERS;

select * from PARTS;

select * from CATALOG;

select pname from PARTS p, CATALOG c where p.pid=c.pid;

select pname distinct from PARTS p, CATALOG c where p.pid=c.pid;

select sname from SUPPLIERS;

select pname from SUPPLIERS s, PARTS p, CATALOG c where c.pid = p.pid and s.sid = c.sid and s.sname = 'Acme';

select distinct pname from PARTS p, CATALOG c where p.pid=c.pid;
