
use AdventureWorks2022
go

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color NOT IN 
(SELECT Color
FROM Production.Product
WHERE ProductID = 317)


SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color NOT IN ('Black')

SELECT Name, ListPrice,
(SELECT AVG(ListPrice) FROM Production.Product) AS Average, 
ListPrice - (SELECT AVG(ListPrice) FROM Production.Product) AS Difference
FROM Production.Product
WHERE ProductSubcategoryID = 1



SELECT Name 
FROM Production.Product
WHERE ListPrice = 
(SELECT ListPrice FROM Production.Product
WHERE Name = 'Chainring Bolts')


SELECT P1.Name 
FROM Production.Product p1
JOIN Production.Product P2
	ON P1.ProductID = P2.ProductID
WHERE P1.ListPrice <> P2.ListPrice 
AND P2.Name = 'Chainring Bolts'




SELECT c.LastName, c.FirstName
FROM Person.Person c
JOIN HumanResources.Employee e ON e.BusinessEntityID = c.BusinessEntityID
WHERE 5000 IN 
(SELECT Bonus FROM Sales.SalesPerson sp WHERE e.BusinessEntityID = sp.BusinessEntityID)



CREATE TABLE #StoreInfoLocal 
(
EmployeeID int, 
ManagerID int, 
Num int
)

CREATE TABLE ##StoreInfoGlobal 
(
EmployeeID int, 
ManagerID int, 
Num int
)



WITH TopSales (SalesPerson, NumSales) AS
(SELECT SalesPersonID, Count(*) FROM Sales.SalesOrderHeader GROUP BY SalesPersonID)

SELECT LoginID, NumSales
FROM HumanResources.Employee e 
INNER JOIN TopSales ON TopSales.SalesPerson = e.BusinessEntityID
ORDER BY NumSales DESC
