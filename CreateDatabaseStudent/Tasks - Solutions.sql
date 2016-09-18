/*Task 1*/
SELECT spec.name, AVG(mark) AS avr_mark
FROM 
marks m
JOIN students s ON s.id = m.id_student
JOIN study_plan sp ON 
s.id_study_plan = sp.id_study_plan
JOIN specialties spec ON 
sp.id_specialty = spec.id
WHERE sp.id_specialty = 10
UNION
SELECT spec.name, 
AVG(mark) AS avr_mark
FROM marks m
JOIN students s ON s.id = m.id_student
JOIN study_plan sp ON s.id_study_plan = sp.id_study_plan
JOIN specialties 
spec ON sp.id_specialty = spec.id
WHERE sp.id_specialty = 11;

/*Task 2*/
CREATE VIEW 
Sem_1 AS
SELECT AVG(mark) AS Semestyr_1, spec.id
FROM marks m
JOIN students 
s ON s.id = m.id_student
JOIN study_plan sp ON s.id_study_plan = 
sp.id_study_plan
JOIN specialties spec ON sp.id_specialty = spec.id
WHERE 
m.semestyr = 1
GROUP BY id_student;

CREATE VIEW Sem_2 AS
SELECT AVG(mark) AS 
Semestyr_2, spec.id
FROM marks m
JOIN students s ON s.id = m.id_student
JOIN 
study_plan sp ON s.id_study_plan = sp.id_study_plan
JOIN specialties spec 
ON sp.id_specialty = spec.id
WHERE m.semestyr = 2
GROUP BY id_student;

SELECT s.name, s2.Semestyr_2, AVG(mark) AS year_marks, spec.name 
specialty
FROM marks m
JOIN students s ON m.id_student = s.id
JOIN 
study_plan sp ON s.id_study_plan = sp.id_study_plan
JOIN specialties spec 
ON sp.id_specialty = spec.id
JOIN sem_2 s2 ON spec.id = s2.id
GROUP BY 
id_student;

/*Task 3*/
SELECT s.id, spec.name, s.name, m.semestyr, AVG(m.mark)
FROM 
marks m
JOIN students s ON m.id_student = s.id
JOIN study_plan sp ON 
s.id_study_plan = sp.id_study_plan
JOIN specialties spec ON 
sp.id_specialty = spec.id
WHERE spec.name = 'Informatika' 
OR
spec.name = 'Statistic'
GROUP BY s.id, spec.name, s.name, m.semestyr
HAVING AVG(m.mark) >= 5;

/*Task 4*/
SELECT DISTINCT students.name
FROM students
JOIN marks m ON students.id = 
m.id_student
JOIN subjects sub ON m.id_subject = sub.id_subject
WHERE 
students.name NOT IN (
	SELECT DISTINCT students.name
	FROM students
	
JOIN marks m ON students.id = m.id_student
	JOIN subjects sub ON 
m.id_subject = sub.id_subject
	WHERE sub.name LIKE 'KMK');

/*Task 5*/
SELECT DISTINCT students.name
FROM students
JOIN marks m ON 
students.id = m.id_student
JOIN subjects sub ON m.id_subject = 
sub.id_subject
WHERE students.name NOT IN (
	SELECT DISTINCT 
students.name
	FROM students
	JOIN marks m ON students.id = 
m.id_student
	JOIN subjects sub ON m.id_subject = sub.id_subject
	
WHERE sub.name LIKE 'KMK')
AND
students.name IN (
	SELECT DISTINCT 
students.name
	FROM students
	JOIN marks m ON students.id = 
m.id_student
	JOIN subjects sub ON m.id_subject = sub.id_subject
	
WHERE sub.name LIKE 'BD');

/*Task 6*/
SELECT DISTINCT students.name
FROM students
JOIN marks m 
ON students.id = m.id_student
JOIN subjects sub ON m.id_subject = 
sub.id_subject
WHERE students.name IN (
	SELECT DISTINCT students.name
	
FROM students
	JOIN marks m ON students.id = m.id_student
	JOIN 
subjects sub ON m.id_subject = sub.id_subject
	WHERE sub.name IN ('KMK', 
'BD'))
AND
students.name IN(
	SELECT students.name
	FROM students
	
JOIN marks m ON students.id = m.id_student
	JOIN subjects sub ON 
m.id_subject = sub.id_subject
	WHERE sub.name LIKE 'II'
    AND
    m.mark 
= 2);