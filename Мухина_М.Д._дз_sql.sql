select name,telegram_contact from student where city='Казань' or city ='Москва' order by name desc

select 'университет: ' || c.name || '; количество студентов: '::varchar || c.size as "полная информация" from college c 
order by "полная информация"  asc

select c.name, count(s.id) as cnt from college c left join student s on (c.id=s.college_id)
where c.id in (10,30,50)
group by c.name
order by cnt, c.name asc


select c.name, count(s.id) as cnt from college c left join student s on (c.id=s.college_id)
where c.id not in (10,30,50)
group by c.name
order by cnt, c.name asc

select name, amount_of_students from course  where amount_of_students between 27 and 310
order by name desc, amount_of_students desc


select name from student  
union all 
select name from course  
order by name desc 

select name,'университет' as object_type from college  
union all 
select name,'курс' as object_type from course  
order by object_type desc, name asc 


select name, amount_of_students
from course 
order by case when amount_of_students = 300 then 1 else 0 end desc, amount_of_students asc
limit 3


insert into course (id,name,is_online,amount_of_students,college_id)
select 60,'Machine Learning','f',17, college_id from course where name = 'Data Mining'


(select id from course 
except select id from student_on_course 
)
union 
(select id from student_on_course 
except select id from course )
order by id 

select s.name as student_name, c.name as course_name, col.name as student_college, soc.student_rating as student_rating
from student s 
left join student_on_course soc on s.id=soc.student_id 
left join course c on soc.course_id = c.id 
left join college col on s.college_id = col.id 
where 
soc.student_rating > 50
and col.size > 5000
order by student_name asc, course_name asc


select s1.name as student_1, s2.name as student_2, s1.city
from student s1
inner join student s2 on s1.city = s2.city and s1.id > s2.id


select "оценка",count(*) as "количество студентов" from (
select 
case when soc.student_rating < 30 then 'неудовлетворительно'
when soc.student_rating >= 30 and soc.student_rating < 60 then 'удовлетворительно'
when soc.student_rating >= 60 and soc.student_rating < 85 then  'хорошо'
else 'отлично' end as "оценка", s.name 
from student s 
left join student_on_course soc on s.id=soc.student_id 
) as t 
group by "оценка"
order by "оценка" asc 

select "курс","оценка",count(*) as "количество студентов" from (
select 
case when soc.student_rating < 30 then 'неудовлетворительно'
when soc.student_rating >= 30 and soc.student_rating < 60 then 'удовлетворительно'
when soc.student_rating >= 60 and soc.student_rating < 85 then  'хорошо'
else 'отлично' end as "оценка", c.name as "курс", s.name 
from student s 
left join student_on_course soc on s.id=soc.student_id 
left join course c on soc.course_id = c.id
) as t 
group by "курс","оценка"
order by "курс" asc,"оценка" asc 


