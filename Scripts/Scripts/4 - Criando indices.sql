
use AdventureWorks2022
go


select * from [HumanResources].[Employee] e
where
e.LoginID = 'adventure-works\diane1'
order by e.NationalIDNumber desc;

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Employee_LoginID] 
ON [HumanResources].[Employee] (LoginID ASC);
GO

CREATE NONCLUSTERED INDEX IDX_Contact_LastName_FirstName 
ON [Person].[Person] (LastName ASC, FirstName ASC);
GO

select * from  [Person].[Person]

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Employee_LoginID_NationalIDNumber] 
ON [HumanResources].[Employee] (LoginID ASC) INCLUDE (NationalIDNumber);
GO

CREATE UNIQUE NONCLUSTERED INDEX IDX_Employee_LoginID_FillFactor 
ON  (LoginID ASC) WITH (FILLFACTOR = 65, PAD_INDEX = ON);
GO

select * from [HumanResources].[Employee]


sp_helpindex N'[HumanResources].[Employee]'


SELECT * FROM sys.dm_db_index_physical_stats
    (DB_ID(N'AdventureWorks2022'), OBJECT_ID(N'Person.Address'), NULL, NULL , 'DETAILED');
GO

ALTER INDEX [AK_Employee_rowguid] ON [HumanResources].[Employee] REORGANIZE;
GO

ALTER INDEX [AK_Employee_rowguid] ON [HumanResources].[Employee] REBUILD;
GO

