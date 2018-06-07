185. 部门工资前三高的员工
select d.Name as Department, e1.Name as Employee, e1.Salary as Salary
from Employee e1
left join Employee e2 on e1.DepartmentId = e2.DepartmentId and e1.Salary < e2.Salary
left join Department d on e1.DepartmentId = d.id
WHERE e1.Salary >= (
CASE
	WHEN (SELECT count(DISTINCT(Salary)) FROM  Employee where DepartmentId = e1.DepartmentId) >= 3 THEN (SELECT DISTINCT(Salary) FROM Employee where DepartmentId = e1.DepartmentId ORDER BY Salary DESC LIMIT 2,1)
	WHEN (SELECT count(DISTINCT(Salary)) FROM  Employee where DepartmentId = e1.DepartmentId) < 3 THEN 0
END)
and d.id is not null
group by e1.Name, e1.DepartmentId
order by e1.DepartmentId, e1.salary desc;
