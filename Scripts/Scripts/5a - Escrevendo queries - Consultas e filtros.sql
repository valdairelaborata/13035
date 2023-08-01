use AdventureWorks2022
go

/*

5 - select city
1 - from Person.Address 
2 - where city = 'Bothell'
3 - group by city 
4 - having count(*) > 0
6 - order by city asc
*/

select city
from Person.Address 
where city = 'Bothell'
group by city 
having count(*) > 0
order by city asc


SELECT Description, DiscountPct, MinQty, 
              ISNULL (MaxQty, 0) AS ‘Max Quantity’
FROM Sales.SpecialOffer


SELECT ProductID, MakeFlag, FinishedGoodsFlag, 
              NULLIF (MakeFlag, FinishedGoodsFlag) AS ‘NULL if Equal’
FROM Production.Product
WHERE ProductID < 10


SELECT CAST(
                        COALESCE(hourly_wage * 40 * 52, 
                                            salary, 
                                            comission * num_sales)
                         AS Money) AS 'Total Salary'
FROM source


SELECT LastName, FirstName, MiddleName
FROM Person.Person
ORDER BY LastName asc, FirstName asc

SELECT LastName, FirstName, MiddleName
FROM Person.Person
ORDER BY LastName asc, FirstName desc

SELECT DISTINCT LastName, FirstName, MiddleName
FROM Person.Person
ORDER BY LastName, FirstName

SELECT LastName, FirstName, MiddleName
FROM Person.Person
group by LastName, FirstName, MiddleName
ORDER BY LastName, FirstName


SELECT p.LastName, p.FirstName, p.MiddleName as NomeDoMeio
FROM Person.Person as p 
ORDER BY NomeDoMeio

SELECT e.BusinessEntityID AS 'Employee Identification Number'
FROM HumanResources.Employee AS e

SELECT e.BusinessEntityID 'Employee Identification Number'
FROM HumanResources.Employee e


SELECT (LastName + ', ' + FirstName + ' ' + ISNULL(SUBSTRING(MiddleName, 1, 1), ' ')) AS Name
FROM HumanResources.Employee AS e
where
e.Gender = 'F'


