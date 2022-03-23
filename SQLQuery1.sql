CREATE DATABASE Tutorial_01
USE Tutorial_01

create table Employee
(
eid integer,
ename varchar(20),
age integer,
salary real,
CONSTRAINT emp_pk primary key (eid)
)

create table Department
(
did varchar(20)primary key,
budget real, 
managerid integer,
)

create table Works
(
eid integer,
did varchar(20),
pctTime integer,
primary key (eid,did),
foreign key (eid) references Employee (eid),
foreign key (did) references Department (did)
)

insert into Employee (eid,ename,age,salary)
values (1,'Saman',20,20000.00)
insert into Employee (eid,ename,age,salary)
values (2,'Amara',23,10000.00)
insert into Employee (eid,ename,age,salary)
values (3,'Gayan',35,30000.00)
insert into Employee (eid,ename,age,salary)
values (4,'Ruwan',18,70000.00)
insert into Employee (eid,ename,age,salary)
values (5,'Nalin',25,8000.00)
insert into Employee (eid,ename,age,salary)
values (6,'Kalum',27,7000.00)



insert into Department (did,budget,managerid)
values ('Hardware',50000.00,3)
insert into Department (did,budget,managerid)
values ('Software',5000.00,3)
insert into Department (did,budget,managerid)
values ('Electronics',11000.00,4)
insert into Department (did,budget,managerid)
values ('IT',1500000.00,5)
insert into Department (did,budget,managerid)
values ('CSE',600000.00,5)
insert into Department (did,budget,managerid)
values ('CM',2000000.00,6)


insert into Works (eid,did,pctTime)
values (1,'Hardware',8)
insert into Works (eid,did,pctTime)
values (2,'Hardware',5)
insert into Works (eid,did,pctTime)
values (3,'Software',8)
insert into Works (eid,did,pctTime)
values (3,'Hardware',8)
insert into Works (eid,did,pctTime)
values (4,'Electronics',8)
insert into Works (eid,did,pctTime)
values (4,'Hardware',8)
insert into Works (eid,did,pctTime)
values (5,'IT',3)
insert into Works (eid,did,pctTime)
values (5,'CSE',3)
insert into Works (eid,did,pctTime)
values (6,'CM',10)

-- Q1 Print the names and ages of each employee who works in both the Hardware department and the Software department. 
(SELECT e.ename,e.age
FROM Works w,Employee e
where e.eid=w.eid and w.did='Hardware')

intersect

(
SELECT e.ename,e.age
FROM Employee e,Works w
where e.eid=w.eid and w.did='Software'
)


-- Q2 Print the name of each employee whose salary exceeds the budget of all of the departments that he or she works in.
SELECT e.ename
FROM Employee e
where e.salary>
(
SELECT max(d.budget)
from Department d,Works w
where e.eid=w.eid and w.did=d.did
)

-- Q3 Find the managerids of managers who manage only departments with budgets greater than $1,000,000.
(
SELECT d.managerid
FROM Department d
where d.budget>1000000
)

except

(
SELECT d.managerid
FROM Department d
where d.budget<1000000
)

-- Q4 Find the enames of managers who manage the departments with the largest budget.

select e.ename,d.budget
from Employee e,Department d
where e.eid=d.managerid and d.budget in
(
select max(budget)
from Department
)


-- Q5 If a manager manages more than one department, he or she controls the sum of all the budgets for those departments. Find the managerid of managers who control more than $1,000,000. 
select d.managerid
from Department d
group by d.managerid
having sum(d.budget)>1000000


-- Q6 Find the managerid of managers who control the largest amount.
select t1.managerid,t1.total
from
(
select d.managerid,sum(d.budget) as total
from Department d
group by d.managerid
) as t1

where t1.total=(select max(t2.total)
from
(
select d.managerid,sum(d.budget) as total
from Department d
group by d.managerid
) as t2)

