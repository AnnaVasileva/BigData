/*Task 1*/
SELECT ms.name
FROM movieStar ms
JOIN starsIn si ON ms.name = si.starName
WHERE ms.gender = 'M'
AND
si.movieTitle LIKE 'Terms of Endearment';

/*Task 2*/
SELECT si.starName
FROM starsIn si
JOIN movie m ON si.movieTitle = m.title AND si.movieYear = m.year
WHERE m.year = 1995
AND
m.studioName LIKE '%MGM%';

/*Task 3*/
SELECT title
FROM movie 
WHERE length > (SELECT m.length
                FROM movie m
                WHERE m.title LIKE '%Star Wars%');
                  
/*Task 4*/        
SELECT me.name, me.networth 
FROM movieExec me
GROUP BY me.name, me.networth 
HAVING me.networth > 10000000
AND me.name IN (SELECT ms.name
                FROM movieStar ms);
                
/*Task 5*/
SELECT ms.name
FROM movieStar ms
WHERE ms.name NOT IN (SELECT me.name
                      FROM movieExec me);
                      
/*Task 6*/
SELECT m.title, m.year, m.studioName, s.address
FROM movie m
JOIN studio s ON m.studioName = s.name
WHERE length > 120;

/*Task 7*/
SELECT m.studioName, si.starName
FROM movie m
JOIN starsIn si ON m.title = si.movieTitle AND m.year = si.movieYear
ORDER BY m.studioName;

/*Task 8*/
SELECT DISTINCT me.name
FROM movieExec me
JOIN movie m ON me.cert# = m.producerC#
JOIN starsIn si ON  m.title = si.movieTitle AND m.year = si.movieYear
WHERE si.starName LIKE '%Harrison Ford%';

/*Task 9*/
SELECT ms.name
FROM movieStar ms
JOIN starsIn si ON ms.name = si.starName
JOIN movie m ON si.movieTitle = m.title AND si.movieYear = m.year
WHERE m.studioName LIKE '%MGM%'
AND ms.gender = 'F';

/*Task 10*/
SELECT me.name, m.title
FROM movieExec me
JOIN movie m ON me.cert# = m.producerc#
WHERE me.name IN (SELECT me2.name
                  FROM movieExec me2
                  JOIN movie m2 ON me2.cert# = m2.producerc#
                  WHERE m2.title LIKE '%Star Wars%');

/*Task 11*/   
SELECT ms.name
FROM movieStar ms
LEFT JOIN starsIn si ON ms.name = si.starName
WHERE ms.name NOT IN (SELECT si2.starName
                      FROM starsIn si2);

/*Task 12*/
SELECT ms.name, COUNT(m.studioName) AS number_of_studios
FROM movieStar ms
LEFT JOIN starsIn si ON ms.name = si.starName
LEFT JOIN movie m ON si.movieTitle = m.title AND si.movieYear = m.year
GROUP BY ms.name;

/*Task 13*/
SELECT si.starName
FROM starsIn si
JOIN movie m ON si.movieTitle = m.title AND si.movieYear = m.year
WHERE m.year > 1990
GROUP BY si.starName
HAVING COUNT(m.title) > 3;

/*Task 14*/
SELECT DISTINCT m.title, m.year
FROM movie m
JOIN starsIn si ON m.title = si.movieTitle AND m.year = si.movieYear
WHERE m.year < 1982
AND
si.starName NOT LIKE '%k%' AND si.starName NOT LIKE '%b%' 
ORDER BY m.year;

/*Task 14*/
SELECT m.title, MOD(m.length, 60)
FROM movie m
WHERE m.year = (SELECT m2.year
                FROM movie m2
                WHERE m2.title LIKE '%Terms of Endearment%')
AND m.length < (SELECT m3.length
                FROM movie m3
                WHERE m3.title LIKE '%Terms of Endearment%');

/*Task 16*/
SELECT s.name, s.address
FROM studio s
JOIN movie m ON s.name = m.studioName
JOIN starsIn si ON m.title = si.movieTitle AND m.year = si.movieYear
GROUP BY s.name, s.address
HAVING COUNT(si.starName) < 5;