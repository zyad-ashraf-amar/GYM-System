SELECT User_ssn,User_name FROM invoice i INNER join staff f ON i.staff_id = f.staff_id inner join users u ON f.Register_id = u.Register_id
//////////////////////////
select * from inbody order by heart_rate desc
////////////////////////////////
select  (SELECT sum(invoice_total_price) FROM invoice where invoice_state_id = (select invoice_state_id from invoice_state where invoice_state = 'income'))-(SELECT sum(invoice_total_price) FROM invoice where invoice_state_id = (select invoice_state_id from invoice_state where invoice_state = 'Outcome')) as profits
/////////////////////////////////
select TOP 1* from inbody order by pressure  desc
//////////////////////////////////////////
select  staff_id as staff,manage_id as mange from  staff
/////////////////////////////////////////////////
select  staff_id as staff  ,manage_id as mange from  staff where manage_id is null
////////////////////////////////////////////////////////////
select  s.Staff_id, e.staff_Salary,e.salary_Date,u.user_name from staff s, staff_Salary e,users u
where s.staff_id=e.staff_id and u.register_id=s.register_id and 
staff_Salary=(select max(staff_Salary)from staff_Salary)
///////////////////////////////////////////////////////////////////
SELECT package_id,package_name FROM packages
select * from membership
select * from Membership_Package
select package_name from membership M 
inner join Membership_Package S 
on M.Membership_id=S.Membership_id 
inner join packages p 
on S.package_id=p.package_id
///////////////////////////////////////////////////////////////////
select DISTINCT workouts_name as Workout,count(*) as number_of_subscriptions
from WorkoutsInMs w 
inner join Workouts o 
on w.workout_id = o.workout_id
group by o.workouts_name
/////////////////////////////////////////////////
SELECT U.USER_NAME, D.Diet_name 
FROM users U 
INNER JOIN   Members M
 ON U.Register_id=M.Register_id 
 INNER JOIN   inbody I
 ON M.Member_id=I.Member_id
  INNER JOIN   Diet D
 ON I.Diet_id=D.Diet_id
///////////////////////////////////////////////
SELECT d.Diet_name,count(*)
from Diet d
inner join inbody i
on d.diet_id= i.diet_id
group by(d.Diet_name)
