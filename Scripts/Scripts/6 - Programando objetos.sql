use AdventureWorks2022
go

CREATE VIEW Person.vPerson
AS
	SELECT FirstName, LastName, PersonType
	FROM Person.Person	
GO

SELECT * FROM Person.vPerson p
ORDER BY p.LastName 

SELECT p.PersonType, count(*)
FROM Person.vPerson p
GROUP BY  p.PersonType

GO
DROP VIEW Person.vPerson

GO

CREATE VIEW vwDiscount WITH SCHEMABINDING
AS 
SELECT SUM(UnitPrice*OrderQty) AS SumPrice,
SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS SUMDiscountPrice,
SUM(UnitPrice*OrderQty*UnitPriceDiscount) AS SumDiscountPrice2, 
COUNT_BIG(*) AS Count, ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
GO

CREATE UNIQUE CLUSTERED INDEX vwDiscountInd ON vwDiscount (ProductID);
GO

SELECT * FROM vwDiscount v
WHERE v.ProductID



GO

CREATE FUNCTION dbo.fEmployeeFullName (@ID int)
RETURNS VARCHAR(2000)
AS
BEGIN 

DECLARE @NAME VARCHAR(2000);
SELECT @NAME = FirstName + ' ' + LastName FROM Person.Person WHERE BusinessEntityID = @ID
RETURN @NAME


END;

SELECT dbo.fEmployeeFullName(1) AS FullName;

DROP FUNCTION dbo.fEmployeeFullName;
GO




CREATE OR ALTER FUNCTION dbo.fEmployeeByTitle (@TITLE VARCHAR(10))
RETURNS table
AS
RETURN (SELECT FirstName, MiddleName, LastName, Title FROM Person.Person WHERE Title = @TITLE);
GO

SELECT * FROM dbo.fEmployeeByTitle('Mr.');

DROP FUNCTION dbo.fEmployeeByTitle;



CREATE OR ALTER PROCEDURE Person.usp_GetPersonName @NamePrefix char(1)
AS
BEGIN
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE @NamePrefix + '%'
ORDER BY FirstName
END;


EXECUTE Person.usp_GetPersonName 'A';

DROP PROCEDURE Person.usp_GetPersonName;










