create table STUDENT(snum int primary key, sname varchar2(10), major varchar2(10), lvl varchar2(2), age int);
create table FACULTY(fid int primary key, fname varchar2(10), deptid int);
create table CLASS(cname varchar2(10) primary key, meets_at varchar2(10), room varchar2(10), fid int, foreign key(fid) references FACULTY(fid));
create table ENROLLED(
    snum int, 
    cname varchar2(10),
    primary key(snum,cname),
    foreign key(snum) references STUDENT(snum), 
    foreign key(cname) references CLASS(cname)
);

insert into STUDENT values(&snum, '&sname', '&major', '&lvl', &age);
select * from STUDENT;
insert into FACULTY values(&fid, '&fname', &deptid);
select * from FACULTY;
insert into CLASS values('&cname', '&meets_at', '&room', &fid);
select * from CLASS;
insert into ENROLLED values(&snum, '&cname');
select * from ENROLLED;

select sname from STUDENT where lvl='JR';
select cname from CLASS where room='R128' or cname in (select cname from ENROLLED group by cname having count(snum)> 1);
select fname from FACULTY where fid in (select fid from CLASS group by fid having COUNT(distinct room) in (select COUNT(distinct room) from CLASS));
select sname from STUDENT where snum not in (select distinct snum from ENROLLED);
