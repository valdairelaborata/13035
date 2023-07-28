
use AdventureWorks2022
go

sp_help 'Person.EmailAddress'

-- Adiciona uma constraint UNIQUE no EmailAddress da tabela Person.EmailAddress
ALTER TABLE Person.EmailAddress ADD CONSTRAINT UQ_Person_EmailAddress_PostalCode UNIQUE NONCLUSTERED
([EmailAddress] ASC);
GO

-- Adiciona uma constraint CHECK no EmailAddress da tabela Person.EmailAddress para verificar se o tamanho do E-mail é maior que 10 caracteres
ALTER TABLE Person.EmailAddress WITH CHECK ADD CONSTRAINT CK_Person_EmailAddress_PostalCode_Len CHECK
(LEN([EmailAddress]) > 10);
GO

-- Deleta as constraints criadas acima
ALTER TABLE Person.EmailAddress DROP CONSTRAINT UQ_Person_EmailAddress_PostalCode;
GO

ALTER TABLE Person.EmailAddress DROP CONSTRAINT CK_Person_EmailAddress_PostalCode_Len;
GO


ALTER TABLE [Person].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID] 
FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[BusinessEntity] ([BusinessEntityID]);


ALTER TABLE [Person].[BusinessEntity] ADD  CONSTRAINT [DF_BusinessEntity_ModifiedDate]  
DEFAULT (getdate()) FOR [ModifiedDate]


ALTER TABLE [Person].[Person]  WITH CHECK ADD  CONSTRAINT [CK_Person_PersonType] CHECK  
(([PersonType] IS NULL OR 
(upper([PersonType])='GC' OR 
upper([PersonType])='SP' OR 
upper([PersonType])='EM' OR 
upper([PersonType])='IN' OR 
upper([PersonType])='VC' OR 
upper([PersonType])='SC')))



ALTER TABLE [HumanResources].[EmployeeOrg] ADD UNIQUE NONCLUSTERED 
(
	[EmployeeID] ASC
)

use DBTeste2
go

CREATE TABLE dbo.Produto
( IdProduto INT PRIMARY KEY,
  Nome VARCHAR(50) NOT NULL,
  Descricao VARCHAR(25)
);

CREATE TABLE dbo.Estoque
( IdEstoque INT PRIMARY KEY,
  IdProduto INT NOT NULL,
  Quantidade INT,
  ValorMinimo INT,
  CONSTRAINT FK_Estoque_Produto
    FOREIGN KEY (IdProduto)
    REFERENCES dbo.Produto (IdProduto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);



sp_help 'Person.Person'

CREATE TRIGGER [Person].[iuPerson] ON [Person].[Person] 
AFTER INSERT NOT FOR REPLICATION AS 
BEGIN
    UPDATE [Person].[Person] 
    SET [Person].[Person].[Demographics] = N'<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"> 
        <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
        </IndividualSurvey>' 
    FROM inserted  
WHERE [Person].[Person].[BusinessEntityID] = inserted.[BusinessEntityID] 
        AND inserted.[Demographics] IS NULL;
END;



CREATE TRIGGER [Sales].[iduSalesOrderDetail] ON [Sales].[SalesOrderDetail] 
AFTER DELETE AS 
BEGIN
    DECLARE @Count int;
	

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

END;


CREATE TRIGGER [Purchasing].[uPurchaseOrderDetail] ON [Purchasing].[PurchaseOrderDetail] 
AFTER UPDATE AS 
BEGIN
	-- Valor enviado pelo comando UPDATE
	 --SELECT inserted

	 -- Valor que existia o registro
	 --SELECT deleted.[PurchaseOrderID]

    INSERT INTO [Production].[TransactionHistory]
                ([ProductID], [ReferenceOrderID], [ReferenceOrderLineID], [TransactionType], [TransactionDate]
                ,[Quantity] ,[ActualCost])
            SELECT inserted.[ProductID], inserted.[PurchaseOrderID], inserted.[PurchaseOrderDetailID],'P'
                ,GETDATE(),inserted.[OrderQty],inserted.[UnitPrice] FROM inserted 
                INNER JOIN [Purchasing].[PurchaseOrderDetail] 
                ON inserted.[PurchaseOrderID] = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderID]








CREATE TRIGGER [HumanResources].[dEmployee] ON [HumanResources].[Employee] 
INSTEAD OF DELETE NOT FOR REPLICATION AS 
BEGIN
    BEGIN
        RAISERROR
            (N'Employees cannot be deleted. They can only be marked as not current.', -- Message
            10, -- Severity.
            1); -- State.

        -- Rollback any active or uncommittable transactions
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;


						








