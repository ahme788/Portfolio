-- Once a student is passed out from a Institute or College, he/she is known as Alumni of the Institute. Alumni’s career growth 
-- plays important role in Institute’s ranking and other networking activities. In this project, career choices of alumni of two Universities will be analyzed with respect to their passing year as well as the course they completed. 

-- Dataset: Six .csv file (Alumni record of College A and College B) Higher Studies, Self Employed and Service/Job record 

-- College_A_HS ~ Higher Studies Record of College A
-- College_A_SE ~ Self Employed Record of College A
-- College_A_SJ ~ Service/Job Record of College A
-- College_B_HS ~ Higher Studies Record of College B
-- College_B_SE ~ Higher Studies Record of College B
-- College_B_SJ ~ Higher Studies Record of College B

-- Tasks to be performed
-- 1. Create new schema as alumni
CREATE DATABASE Alumni;

-- 2. Import all .csv files into MySQL
-- imported all files into MYSQL

-- 3. Run SQL command to see the structure of six tables
USE alumni;
SELECT * FROM college_a_se;
SELECT * FROM college_a_hs;
SELECT * FROM college_a_sj;
SELECT * FROM college_b_hs;
SELECT * FROM college_b_se;
SELECT * FROM college_b_sj;

-- 4. Display first 1000 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) 
-- with Python.
-- refer python file 

-- 5. Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) 
-- into MS Excel.

-- 6. Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 
CREATE VIEW college_a_hs_v AS
SELECT * FROM college_a_hs
WHERE RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND 
NAME IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND 
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND
Location IS NOT NULL;

-- 7. Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.
CREATE VIEW college_a_se_v AS
SELECT * FROM college_a_se
WHERE RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND 
NAME IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND 
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND
Location IS NOT NULL;

-- 8. Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.
CREATE VIEW college_a_sj_v AS
SELECT * FROM college_a_sj
WHERE RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND 
NAME IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND 
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND
Location IS NOT NULL;

-- 9. Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.
CREATE VIEW college_b_hs_v AS
SELECT * FROM college_b_hs
WHERE RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND 
NAME IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND 
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND
Location IS NOT NULL;

-- 10 Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.
CREATE VIEW college_b_se_v AS
SELECT * FROM college_b_se
WHERE RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND 
NAME IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND 
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND
Location IS NOT NULL;

-- 11 Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.
CREATE VIEW college_b_sj_v AS
SELECT * FROM college_b_sj
WHERE RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND 
NAME IS NOT NULL AND
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND 
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND
Location IS NOT NULL;

-- 12. Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views 
-- (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 
delimiter $
create procedure v1()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_a_hs_v;
end $
delimiter ;

call v1();

delimiter $
create procedure v2()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_a_se_v;
end $
delimiter ;

call v2();

delimiter $
create procedure v3()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_a_sj_v;
end $
delimiter ;

call v3();

delimiter $
create procedure v4()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_b_hs_v;
end $
delimiter ;

call v4();

delimiter $
create procedure v5()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_b_se_v;
end $
delimiter ;

call v5();

delimiter $
create procedure v6()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_b_sj_v;
end $
delimiter ;

call v6();

-- 14. Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.
delimiter $$
create  procedure get_name1(inout n text(20000))
begin
	declare finished int default 0;
    declare namelist varchar(400) default '';
    
    declare namedetails cursor for
		select Name from college_a_hs
		union
		select Name from college_a_se
		union
		select Name from college_a_sj;
        
        
	declare continue handler for not found set finished =1;
    
    open namedetails;
    getname:
    loop
		fetch namedetails into namelist;
        if finished = 1 then 
			leave getname;
		end if;
        
        set n = concat(namelist,';',n);
	end loop getname;
    close namedetails;
end$$
delimiter ;

set @l=' ';
call get_name1(@l);
select @l student_names_college_a;

-- 15. Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.
delimiter $$
create  procedure get_name2(inout n text(20000))
begin
	declare finished int default 0;
    declare namelist varchar(400) default '';
    
    declare namedetails cursor for
		select Name from college_b_hs
		union
		select Name from college_b_se
		union
		select Name from college_b_sj;
        
        
	declare continue handler for not found set finished =1;
    
    open namedetails;
    getname:
    loop
		fetch namedetails into namelist;
        if finished = 1 then 
			leave getname;
		end if;
        
        set n = concat(namelist,';',n);
	end loop getname;
    close namedetails;
end$$
delimiter ;

set @l=' ';
call get_name2(@l);
select @l student_names_college_b;

-- 16. Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
-- Note: Approximate percentages are considered for career choices.
select (1157+1016+5633) Total_No_of_alumni_college_a;

select 'Higher_studies' career_choice,count(*) No_of_students ,count(*)/7806*100 Percentage from college_a_hs
union
select 'Self Employed'  career_choice,count(*) No_of_students,count(*)/7806*100 Percentage from college_a_se
union
select 'Service/Job'  career_choice,count(*) No_of_students,count(*)/7806*100 Percentage from college_a_sj;

select (199+201+1859) Total_no_of_alumni_college_b;

select 'Higher_studies' career_choice,count(*) No_of_students,count(*)/2259*100 Percentage  from college_b_hs
union
select 'Self Employed'  career_choice,count(*) No_of_students,count(*)/2259*100 Percentage from college_b_se
union
select 'Service/Job'  career_choice,count(*) No_of_students,count(*)/2259*100 Percentage from college_b_sj;
