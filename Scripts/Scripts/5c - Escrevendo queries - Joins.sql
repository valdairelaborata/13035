


SELECT e.LoginID
FROM HumanResources.Employee AS e
JOIN Sales.SalesPerson AS s
ON e.BusinessEntityID = s.BusinessEntityID




SELECT 
	p.Name, 
	pr.ProductReviewID
FROM Production.Product p
LEFT JOIN Production.ProductReview pr 
	ON p.ProductID = pr.ProductID

