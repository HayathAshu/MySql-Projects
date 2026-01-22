create database if not exists Movies;
use Movies;

select * from actor;
select * from cast;
select * from director;
select * from genres;
select * from movie;
select * from movie_direction;
select * from ratings;
select * from reviewer;

update movie set mov_dt_rel = null where mov_dt_rel = '';
update ratings set num_o_ratings = null where num_o_ratings = '';

# 1. Write a SQL query to find when the movie 'American Beauty' released. Return movie release year. 
select mov_title, mov_year from movie where mov_title = "American Beauty";

# 2. Write a SQL query to find those movies, which were released before 1998. Return movie title. 
select mov_id, mov_title, mov_year from movie where mov_year < 1998;

# 3. Write a query where it should contain all the data of the movies which were released 
# after 1995 and their movie duration was greater than 120.
select * from movie where mov_year > 1995 and mov_time > 120;

# 4. Write a query to determine the Top 7 movies which were released in United Kingdom. 
# Sort the data in ascending order of the movie year. 
select * from movie where mov_rel_country = "UK" order by mov_year asc limit 7;

# 5. Set the language of movie language as 'Chinese' 
# for the movie which has its existing language as Japanese and the movie year was 2001. 
update movie set mov_lang = "Chinese" where mov_year = 2001 and mov_lang = "Japanese";
select * from movie;
rollback;

# 6. Write a SQL query to find name of all the reviewers who rated the movie 'Slumdog Millionaire'. 
SELECT DISTINCT
    r.rev_name
FROM
    movie m
        JOIN
    ratings rt ON m.mov_id = rt.mov_id
        JOIN
    reviewer r ON rt.rev_id = r.rev_id
WHERE
    m.mov_title = 'Slumdog Millionaire';
    
# 7. Write a query which fetch the first name, last name & role played by the actor where output should all exclude Male actors. 
select * from actor;
select * from cast;

select act_fname, act_lname, act_gender, c.role from actor as A
join 
cast as c on a.act_id = c.act_id where act_gender = "F";
# order by c.role;

# 8. Write a SQL query to find the actors who played a role in the movie 'Annie Hall'. 
# Fetch all the fields of actor table. (Hint: Use the IN operator).
select * from movie;
select * from actor;
select * from cast;

select * from actor where act_id in (select c.act_id from cast as c
join
movie as m on c.mov_id = m.mov_id where m.mov_title = "annie hall");

# 9. Write a SQL query to find those movies that have been released in countries other than the United Kingdom. 
#    Return movie title, movie year, movie time, and date of release, releasing country.
select * from movie;
select mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country from movie where mov_rel_country != "UK";

# 10. Print genre title, maximum movie duration and the count the number of movies in each genre. 
# (HINT: By using inner join)
select * from genres;
select * from movie;


SELECT 
  g.gen_title,
  MAX(m.mov_time) AS max_duration,
  COUNT(*) AS movie_count
FROM Movie_genres mg
INNER JOIN movie m ON mg.mov_id = m.mov_id
INNER JOIN genres g ON mg.gen_id = g.gen_id
GROUP BY g.gen_title;

# 11. Create a view which should contain the first name, last name, title of the movie & role played by particular actor.
select * from actor;         # act_fname, act_lname,  
select * from movie;		 # mov_title
select * from cast;			 # role

create view actor_movie_role as 
select a.act_fname, a.act_lname, m.mov_title, c.role from actor as a
inner join 
cast as c on a.act_id = c.act_id
inner join
movie as m on c.mov_id = m.mov_id;

# 12. Write a SQL query to find the movies with the lowest ratings 
select * from movie;
select * from ratings;
select  num_o_ratings, mov_title from ratings, movie order by  num_o_ratings asc  ;

select m.title, avg(r.rev_stars) as avg_rating from movie as m
join
Rating as r on m.mov_id = r.mov_id
group by m.mov_id having avg(r.rev_stars) = (
select min(avg_stars) from (
select avg(rev_stars) as avg_stars
from 
rating group by mov_id) as sub);


















