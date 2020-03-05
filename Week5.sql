create table ACTOR (id int primary key, name varchar2(10), gender varchar2(1));
create table DIRECTOR (id int primary key, name varchar2(10), phone varchar2(10));
create table MOVIE (id int primary key, title varchar2(20), year number(4), lang varchar2(10), dir_id int, foreign key(dir_id) references DIRECTOR(id));
create table CAST (act_id int, mov_id int, role varchar2(20), primary key(act_id, mov_id), foreign key(act_id) references ACTOR(id), foreign key(mov_id) references MOVIE(id));
create table RATING(mov_id int, stars number(1) check (stars > 0 and stars <= 5), foreign key(mov_id) references MOVIE(id));

insert into ACTOR values(&id, '&name', '&gender');
select * from ACTOR;
commit;

insert into DIRECTOR values(&id, '&name', '&phone');
select * from DIRECTOR;
commit;

insert into MOVIE values(&id, '&title', &year, '&lang', &dir_id);
select * from MOVIE;
commit;

insert into CAST values(&act_id, &mov_id, '&role');
select * from CAST;
commit;

insert into RATING values(&mov_id, &stars);
select * from RATING;
commit;

/*List the titles of all movies directed by ‘Hitchcock’.*/
select title from MOVIE m, DIRECTOR d where d.name='Hitchcock' and d.id=m.dir_id;

/*Find the movie names where one or more actors acted in two or more movies.*/
select distinct title from MOVIE m, CAST c where m.id=c.mov_id and c.act_id in (select act_id from CAST group by act_id having COUNT(mov_id) > 1);

/*List all actors who acted in a movie before 2000 and also in a movie after 2015.*/
select distinct name from ACTOR a, CAST c where c.act_id=a.id and c.mov_id in (select id from MOVIE m where year NOT BETWEEN 2000 and 2015);
/*or*/
select distinct name from ACTOR a inner join CAST c on a.id=c.act_id and c.mov_id in (select id from MOVIE m where year NOT BETWEEN 2000 and 2015);

/*Find the title of movies and number of stars for each movie that has at least one rating
and find the highest number of stars that movie received. Sort the result by movie title.*/
select title, stars from MOVIE m inner join (select mov_id, max(stars) as stars from RATING group by mov_id) r on m.id=r.mov_id order by title;

/*Update rating of all movies directed by ‘Steven Spielberg’ to 5.*/
update RATING set stars=5 where mov_id in (select m.id from MOVIE m, DIRECTOR d where m.dir_id = d.id and d.name='Spielberg');
select * from RATING;
