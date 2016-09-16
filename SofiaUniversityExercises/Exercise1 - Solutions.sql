#Task 1

SELECT title
FROM movie
WHERE studioname LIKE 'Disney%'
AND
year = 1990;

#Task 2

SELECT name, address
FROM studio
WHERE name LIKE 'MGM%';

#Task 3

SELECT name, birthdate
FROM moviestar
WHERE name LIKE 'Sandra Bullock%';

#Task 4

SELECT s.starname
FROM starsin s
JOIN movie m ON s.movietitle = m.title AND s.movieyear = m.year
WHERE year = 1980
AND
title LIKE '%Empire%'
GROUP BY s.starname;

#Task 5

SELECT name
FROM movieStar
WHERE gender LIKE 'M'
OR
address LIKE '%Malibu%';