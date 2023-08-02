use AdventureWorks2022
go


SELECT SalesOrderID, SUM(LineTotal) AS SubTotal
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SalesOrderID


SELECT SalesOrderID, SUM(LineTotal) AS SubTotal
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(LineTotal) > 100000.00
ORDER BY SalesOrderID



SELECT ProductID, Shelf, SUM(Quantity) AS QtySum
FROM Production.ProductInventory
WHERE ProductID < 6
GROUP BY ROLLUP (ProductID, Shelf)


SELECT ProductID, Shelf, SUM(Quantity) AS QtySum
FROM Production.ProductInventory
WHERE ProductID < 6
GROUP BY CUBE (ProductID, Shelf)


SELECT T.[Group], T.CountryRegionCode, S.Name, H.SalesPersonID
FROM Sales.Customer C
INNER JOIN Sales.Store S ON C.StoreID = S.BusinessEntityID
INNER JOIN Sales.SalesTerritory T ON C.TerritoryID = T.TerritoryID
INNER JOIN Sales.SalesOrderHeader H ON C.CustomerID = H.CustomerID
WHERE T.[Group] = 'Europe'
AND T.CountryRegionCode IN ('DE', 'FR')
AND SUBSTRING(S.Name, 1, 4) IN ('Vers', 'Spa')
GROUP BY GROUPING SETS(T.[Group], T.CountryRegionCode, S.Name, H.SalesPersonID)





SELECT P.Name, P.ListPrice, PSC.Name Category, 
RANK() OVER(PARTITION BY PSC.Name ORDER BY P.ListPrice DESC) AS PriceRank
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID


SELECT P.Name, P.ListPrice, PSC.Name Category, 
DENSE_RANK() OVER(PARTITION BY PSC.Name ORDER BY P.ListPrice DESC) AS PriceRank
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID

SELECT ROW_NUMBER() OVER(PARTITION BY PSC.Name ORDER BY P.ListPrice) AS Row,
PSC.Name Category, P.Name Product, P.ListPrice
FROM Production.Product P
JOIN Production.ProductSubcategory PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID


SELECT NTILE(8) OVER (PARTITION BY PC.Name ORDER BY ListPrice)
AS PriceBand, PC.Name Category, P.Name Product, P.ListPrice
FROM Production.Product P
JOIN Production.ProductSubcategory PSC ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
JOIN Production.ProductCategory PC ON PSC.ProductCategoryID = PC.ProductCategoryID








SELECT Name, [Black], [Blue], [Red]
FROM (
	SELECT Name, Color
	FROM Production.Product
	WHERE Name LIKE '%helmet%'
) as Consulta
PIVOT  
(  
  COUNT(Color) 
  FOR Color IN ([Black], [Blue], [Red])  
) AS ConsultaPivot;  

