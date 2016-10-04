/*Task 1*/
SELECT me.NAME, m.title
FROM movie m
JOIN movieexec me ON m.PRODUCERCN = me.CertN 
WHERE m.PRODUCERCN LIKE(
	SELECT m2.PRODUCERCN
	FROM movie m2
	WHERE m2.title LIKE 'Pretty Woman');

SELECT t.name, title
FROM movie m JOIN (
	SELECT name, certn
	FROM movieexec
	WHERE certn IN (
		SELECT producercn
		FROM movie
		WHERE title = 'Pretty Woman')) t 
ON m.producercn = t.certn;

/*Task 2*/
SELECT name, address
FROM moviestar
WHERE address LIKE '%Sofia%'
AND
gender = 'F'
UNION
SELECT name, address
FROM studio
WHERE address LIKE '%Sofia%'
ORDER BY address;

SELECT *
FROM (
	SELECT name, address 
    FROM MovieStar 
    WHERE gender = 'F' 
    UNION
	SELECT name, address 
    FROM Studio) T
WHERE T.address LIKE '%Sofia%' 
ORDER BY T.address?

/*Task 3*/
SELECT m.studioname, s.address, AVG(m.length)
FROM movie m
LEFT JOIN studio s ON m.studioname = s.name 
GROUP BY studioname
HAVING COUNT(m.incolor = 'n') <= 3;

SELECT name, address, AVG(length) AS avgLength 
FROM Studio
LEFT JOIN Movie ON name = studioName 
WHERE NAME NOT IN (
	SELECT studioName
	FROM Movie
	WHERE inColor = 'n' 
    GROUP BY studioName
	HAVING COUNT(*) > 3) 
GROUP BY name, address?
 
/*Task 4*/
SELECT si.starName, m.incolor
FROM starsIn si
JOIN movie m ON si.movieTitle = m. title
AND si.movieYear = m.year
WHERE si.starName NOT LIKE '%a'
GROUP BY si.starName
HAVING COUNT(m.incolor = 'n') >= 1 AND COUNT(m.incolor = 'y') >= 1;

SELECT starName 
FROM StarsIn
JOIN Movie ON movieTitle = title 
AND movieYear = year 
WHERE starName NOT LIKE '%a' 
AND inColor = 'y' 
INTERSECT
SELECT starName 
FROM StarsIn
JOIN Movie ON movieTitle = title 
AND movieYear = year 
WHERE inColor = 'n'?
 
/*Task 5*/
SELECT name, birthDate, COUNT(DISTINCT m.studioName)
FROM movieStar ms
LEFT JOIN starsIn si ON ms.name = si.StarName
LEFT JOIN movie m ON si.movieTitle = m.title
AND si.movieYear = m.year
GROUP BY ms.name
HAVING COUNT(m.title) <= 5;

SELECT name, YEAR(birthdate), COUNT(DISTINCT studioName) 
FROM MovieStar
LEFT OUTER JOIN StarsIn ON name = starname
LEFT JOIN Movie ON movieTitle = title 
AND movieYear = year 
GROUP BY name
HAVING COUNT(title) <= 5;

/*Task 6*/
SELECT ms.name
FROM movieStar ms
LEFT JOIN starsIn si ON ms.name = si.starName
WHERE si.movieTitle NOT LIKE 'A%'
AND
ms.gender LIKE 'F';

SELECT MS.NAME
FROM MOVIESTAR MS
WHERE MS.GENDER = 'F'
AND NOT EXISTS
(SELECT 1
FROM STARSIN SI
WHERE SI.STARNAME = MS.NAME
AND SI.MOVIETITLE LIKE 'A%');

/*Task 7*/
SELECT ms.name, (MIN(si.movieYear) - YEAR(birthdate)) AS minAge
FROM movieStar ms
JOIN starsIn si ON ms.name = si.starName
WHERE YEAR(birthdate) < 1990
GROUP BY ms.name;

SELECT NAME, MIN( MOVIEYEAR - YEAR(BIRTHDATE) ) AS DEBUT_AGE 
FROM MOVIESTAR
JOIN STARSIN ON NAME = STARNAME 
WHERE YEAR(BIRTHDATE) < 1990 
GROUP BY NAME;