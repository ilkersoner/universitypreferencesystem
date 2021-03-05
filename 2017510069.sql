CREATE DATABASE UniversityPreferenceSystem;

CREATE TABLE Universities (
	university_id INTEGER PRIMARY KEY NOT NULL,
	name TEXT NOT NULL ,
	address TEXT NOT NULL ,
	email TEXT NOT NULL ,
	city TEXT NOT NULL ,
	university_type TEXT NOT NULL ,
	foundation_year INTEGER NOT NULL
);

CREATE TABLE Faculties (
	faculty_id INTEGER PRIMARY KEY NOT NULL,
	university_id INTEGER REFERENCES Universities(university_id) ,
	name TEXT NOT NULL ,
	email TEXT NOT NULL
);

CREATE TABLE Departments (
	department_id INTEGER PRIMARY KEY NOT NULL,
	faculty_id INTEGER REFERENCES Faculties(faculty_id) ,
	name TEXT NOT NULL ,
	email TEXT NOT NULL ,
	language TEXT NOT NULL ,
	education_type TEXT NOT NULL ,
	quota INTEGER NOT NULL ,
	topranked_quota INTEGER NOT NULL ,
	education_period INTEGER NOT NULL ,
	min_score_2019 INTEGER NOT NULL ,
	max_score_2019 INTEGER NOT NULL
);

CREATE TABLE Students (
	student_id INTEGER PRIMARY KEY NOT NULL,
	name TEXT NOT NULL ,
	surname TEXT NOT NULL ,
	exam_score INTEGER NOT NULL ,
	ranking INTEGER NOT NULL ,
	top_rank BOOLEAN NOT NULL ,
	preference1 INTEGER REFERENCES Departments(department_id) ,
	preference2 INTEGER REFERENCES Departments(department_id) ,
	preference3 INTEGER REFERENCES Departments(department_id)
);

INSERT INTO Universities(university_id,name,address,email,city,university_type,foundation_year)
VALUES(1,'Dokuz Eylül University','İzmir','deu@edu.tr','İzmir','state',1982);

INSERT INTO Universities(university_id,name,address,email,city,university_type,foundation_year)
VALUES(2,'İzmir Technical University','İzmir','iyte@edu.tr','İzmir','state',1992);

INSERT INTO Universities(university_id,name,address,email,city,university_type,foundation_year)
VALUES(3,'İzmir University','İzmir','iu@edu.tr','İzmir','private',2007);

INSERT INTO Faculties(faculty_id,university_id,name,email)
VALUES(1,1,'Engineering','private');

INSERT INTO Faculties(faculty_id,university_id,name,email)
VALUES(2,3,'Engineering','@edu.tr');

INSERT INTO Faculties(faculty_id,university_id,name,email)
VALUES(3,1,'Medicine','@edu.tr');

INSERT INTO Faculties(faculty_id,university_id,name,email)
VALUES(4,1,'Law','@edu.tr');

INSERT INTO Faculties(faculty_id,university_id,name,email)
VALUES(5,2,'Law','@edu.tr');

INSERT INTO Faculties(faculty_id,university_id,name,email)
VALUES(6,2,'Medicine','@edu.tr');

INSERT INTO Faculties(faculty_id,university_id,name,email)
VALUES(7,3,'Medicine','@edu.tr');

INSERT INTO Departments(department_id,faculty_id,name,email,language,education_type,quota,topranked_quota,education_period,min_score_2019,max_score_2019)
VALUES(1,1,'Computer Engineering','@edu.tr','English','formal',100,5,4,400,450);

INSERT INTO Departments(department_id,faculty_id,name,email,language,education_type,quota,topranked_quota,education_period,min_score_2019,max_score_2019)
VALUES(2,1,'Mechanical Engineering','@edu.tr','Turkish','formal',100,5,4,390,430);

INSERT INTO Departments(department_id,faculty_id,name,email,language,education_type,quota,topranked_quota,education_period,min_score_2019,max_score_2019)
VALUES(3,1,'Mechanical Engineering','@edu.tr','Turkish','evening',100,5,4,360,400);

INSERT INTO Departments(department_id,faculty_id,name,email,language,education_type,quota,topranked_quota,education_period,min_score_2019,max_score_2019)
VALUES(4,3,'Medicine','@edu.tr','Turkish','formal',100,5,6,460,500);

INSERT INTO Departments(department_id,faculty_id,name,email,language,education_type,quota,topranked_quota,education_period,min_score_2019,max_score_2019)
VALUES(5,3,'Pharmacy','@edu.tr','Turkish','formal',80,5,5,450,470);

INSERT INTO Departments(department_id,faculty_id,name,email,language,education_type,quota,topranked_quota,education_period,min_score_2019,max_score_2019)
VALUES(6,2,'Computer Engineering','@edu.tr','English','formal',30,2,4,350,450);

INSERT INTO Departments(department_id,faculty_id,name,email,language,education_type,quota,topranked_quota,education_period,min_score_2019,max_score_2019)
VALUES(7,4,'Law','@edu.tr','Turkish','formal',50,3,4,400,450);

INSERT INTO Students(student_id,name,surname,exam_score,ranking,top_rank,preference1,preference2,preference3)
VALUES(1,'İlker','Soner',440,40000,false,1,2,6);

INSERT INTO Students(student_id,name,surname,exam_score,ranking,top_rank,preference1,preference2,preference3)
VALUES(2,'Kahtalı','Mıçe',400,60000,true,2,5,7);

INSERT INTO Students(student_id,name,surname,exam_score,ranking,top_rank,preference1,preference2,preference3)
VALUES(3,'Behzat','Ç',480,5000,true,4,5,7); 
--query1
SELECT * from universities
where city LIKE 'İ%' and foundation_year>1990
--query2
select u.* from universities as u
inner join faculties as f
on u.university_id=f.university_id
where f.name='Medicine'
INTERSECT
select u.* from universities as u
inner join faculties as f
on u.university_id=f.university_id
where f.name='Law'
--query3
select count(*) from faculties as f
inner join universities as u
on f.university_id=u.university_id
group by u.university_type
--query4
select * from departments
where name like '%Engineering%' and education_type='formal'
--query5
select * from departments
order by education_period desc, max_score_2019 desc limit 5
--query6

--query7
select s.* from students as s
inner join departments as d
on s.preference1=d.department_id
where d.name='Computer Engineering'
order by s.exam_score desc
--query8
update faculties
set university_id=2
where name='Engineering' and university_id=1
--query9
update departments
set education_period=education_period + 1
where faculty_id in (select faculty_id from faculties
					where name='Law')
--query10
delete from faculties
where university_id in (select university_id from universities
					   where name='İzmir University')