CREATE DATABASE studentSystem;

CREATE TABLE faculties(
	id INTEGER NOT NULL PRIMARY KEY,
	name CHAR(100) NOT NULL
);

CREATE TABLE specialties(
	id INTEGER NOT NULL PRIMARY KEY,
	name CHAR(100) NOT NULL,
	id_faculty INTEGER NOT NULL
);

CREATE TABLE study_plan(
	id_study_plan INTEGER NOT NULL PRIMARY KEY,
	id_specialty INTEGER NOT NULL,
	year INTEGER NOT NULL
);

CREATE TABLE study_plan_summary(
	semester INTEGER NOT NULL,
	id_subject INTEGER NOT NULL,
	id_study_plan INTEGER NOT NULL,
	lectures INTEGER NOT NULL,
	exercises INTEGER NOT NULL,
	CONSTRAINT pk_study_plan_summary PRIMARY KEY (semester, id_subject, id_study_plan)
);

CREATE TABLE students(
	id INTEGER NOT NULL PRIMARY KEY,
	name CHAR(100) NOT NULL,
	address VARCHAR(200) NOT NULL,
	id_study_plan INTEGER NOT NULL
);

CREATE TABLE marks(
	exam_date DATETIME NOT NULL PRIMARY KEY,
	id_student INTEGER NOT NULL,
	id_subject INTEGER NOT NULL,
	mark DOUBLE NOT NULL
);

ALTER TABLE marks
ADD semestyr INTEGER NOT NULL;
ALTER TABLE marks DROP primary key;
ALTER TABLE marks ADD PRIMARY KEY(exam_date, id_student);

CREATE TABLE subjects(
	id_subject INTEGER NOT NULL PRIMARY KEY,
	name CHAR(100) NOT NULL,
	credits INTEGER NOT NULL
);

CREATE TABLE teachers(
	id_teacher INTEGER NOT NULL PRIMARY KEY,
	name CHAR(100) NOT NULL,
	id_chair INTEGER NOT NULL,
	rank CHAR(100) NOT NULL
);

CREATE TABLE teachers_of_subjects(
	id_subject INTEGER NOT NULL,
	id_teacher INTEGER NOT NULL,
	CONSTRAINT pk_teachers_of_subjects PRIMARY KEY (id_subject, id_teacher)
);

CREATE TABLE chair(
	id_teacher INTEGER NOT NULL PRIMARY KEY,
	id_chair INTEGER NOT NULL,
	name CHAR(100) NOT NULL
);

#------- Add constraints ------------

ALTER TABLE specialties ADD CONSTRAINT fk_specialties_faculties FOREIGN KEY(id_faculty) REFERENCES faculties(id);

ALTER TABLE study_plan ADD CONSTRAINT fk_study_plan_specialties FOREIGN KEY(id_specialty) REFERENCES specialties(id);

ALTER TABLE study_plan_summary ADD CONSTRAINT fk_study_plan_summary_study_plan FOREIGN KEY(id_study_plan) REFERENCES study_plan(id_study_plan);

ALTER TABLE students ADD CONSTRAINT fk_students_study_plan FOREIGN KEY(id_study_plan) REFERENCES study_plan(id_study_plan);

ALTER TABLE marks ADD CONSTRAINT fk_marks_students FOREIGN KEY(id_student) REFERENCES students(id);

ALTER TABLE marks ADD CONSTRAINT fk_marks_subjects FOREIGN KEY(id_subject) REFERENCES subjects(id_subject);

ALTER TABLE teachers_of_subjects ADD CONSTRAINT fk_teachers_of_subjects_subjects FOREIGN KEY(id_subject) REFERENCES subjects(id_subject);

ALTER TABLE teachers_of_subjects ADD CONSTRAINT fk_teachers_of_subjects_teachers FOREIGN KEY(id_teacher) REFERENCES teachers(id_teacher);

ALTER TABLE chair ADD CONSTRAINT fk_chairs_teachers FOREIGN KEY(id_teacher) REFERENCES teachers(id_teacher);

#------- Insert Faculties ------------
INSERT INTO faculties VALUES
(1, 'FMI'),
(2, 'FJMK'),
(3, 'FZF');

#------- Insert Specialties ------------
INSERT INTO specialties VALUES
(10, 'Informatika', 1),
(11, 'Statistic', 1),
(12, 'Information Systems', 1),
(20, 'Journalisum', 2),
(30, 'Fiziks', 3);

#------- Insert  Study Plan------------
INSERT INTO study_plan VALUES
(100, 10, 2008),
(101, 11, 2008),
(102, 12, 2006),
(200, 20, 2000),
(300, 30, 2003);

#------- Insert Subject------------
INSERT INTO subjects VALUES
(123, 'II', 4),
(231, 'BD', 7),
(321, 'KMK', 3),
(312, 'LP', 5),
(213, 'SEP', 4);

#------- Insert Study Plan Summary------------
INSERT INTO study_plan_summary VALUES
(1, 123, 100, 2, 4),
(1, 231, 100, 4, 2),
(1, 321, 100, 3, 3),

(1, 213, 101, 2, 5),
(1, 231, 101, 4, 3),
(1, 123, 101, 2, 4),

(3, 312, 102, 4, 2);

#------- Insert Students------------
INSERT INTO students VALUES
(44872, 'Ani', 'Botevgrad', 100);
INSERT INTO students VALUES
(44873, 'Vesko', 'Plovd', 100),
(44874, 'Mariq', 'Sofia',  100),

(55872, 'Radost', 'Varna', 101),
(55873, 'Hriza', 'Burgas', 101),
(55874, 'Dimo', 'Sozopol', 101),

(66872, 'Aheloi', 'Busmanci', 200),
(77872, 'Tara', 'Buhovo', 300);

INSERT INTO students VALUE
(99000, 'Dvoikata', 'Chepelare', 100);

#------- Insert Marks------------
INSERT INTO marks VALUE
('2016-06-05', 44872, 123, 5, 1),
('2016-07-05', 44872, 213, 4, 1),
('2016-02-25', 44872, 312, 3, 1),
('2016-01-15', 44872, 231, 3, 1),

('2016-06-06', 44873, 123, 5, 1),
('2016-06-15', 44873, 213, 6, 1),

('2016-06-03', 44874, 123, 4, 1),
('2016-05-20', 44874, 213, 5, 1),

('2016-07-13', 55872, 123, 5, 1),
('2016-08-11', 55872, 321, 5, 1),

('2016-06-02', 55873, 123, 5, 1),
('2016-05-02', 55873, 321, 5, 1),

('2016-04-09', 55874, 123, 6, 1),
('2016-03-07', 55874, 321, 4, 1);

UPDATE marks
SET semestyr = 1
WHERE semestyr = 0;

INSERT INTO marks VALUE
('2016-01-05', 44872, 123, 5, 2),
('2016-02-04', 44872, 213, 6, 2),

('2016-02-06', 44873, 123, 4, 2),
('2015-01-15', 44873, 213, 3, 2),

('2016-01-17', 44874, 123, 6, 2),
('2016-01-20', 44874, 213, 3, 2),

('2016-02-13', 55872, 123, 4, 2),
('2016-01-11', 55872, 321, 2, 2),

('2016-02-02', 55873, 123, 5, 2),
('2016-01-22', 55873, 321, 4, 2),

('2016-02-09', 55874, 123, 6, 2),
('2016-01-07', 55874, 321, 5, 2);

INSERT INTO marks VALUE
('2016-01-05', 66872, 123, 5, 1),
('2016-02-15', 66872, 321, 4, 1),

('2016-06-23', 66872, 213, 6, 2),
('2016-07-14', 66872, 231, 3, 2),

('2016-01-12', 77872, 123, 5, 1),
('2016-02-05', 77872, 321, 5, 1),

('2016-06-25', 77872, 213, 4, 2),
('2016-07-15', 77872, 231, 6, 2);

INSERT INTO marks VALUE
('2016-01-17', 99000, 321, 4, 1),
('2016-01-27', 99000, 231, 5, 1),
('2016-02-03', 99000, 123, 2, 1),
('2016-02-10', 99000, 213, 6, 1);

#------- Insert Chairs------------
INSERT INTO chair VALUE
(4321, 912, 'geom'),
(4213, 912, 'geom'),
(4123, 913, 'analiz'),
(4231, 933, 'informatika');

#------- Insert Teachers------------
INSERT INTO teachers VALUE
(4321, 'Prodanov', 912, 'asistent'),
(4213, 'Velev', 912, 'glaven asistent'),
(4123, 'Sladunova', 913, 'prof'),
(4231, 'Serj', 933, 'doc');

#------- Insert Teachers of subjects------------
INSERT INTO teachers_of_subjects VALUE
(123, 4321),
(231, 4213),
(321, 4123),
(312, 4231),
(213, 4321);
