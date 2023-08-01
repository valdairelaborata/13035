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





