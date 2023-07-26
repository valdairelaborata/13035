
--https://learn.microsoft.com/en-us/sql/t-sql/statements/alter-database-transact-sql-file-and-filegroup-options?view=sql-server-ver16


use master


-- Cria  database DbTeste
Create database [BDTeste]

-- Cria um Filegroup chamado SECONDARY no banco de dados DBTeste
ALTER DATABASE [BDTeste] ADD FILEGROUP [SECONDARY]
GO

-- Cria um arquivo de dados no Filegroup SECONDAY chamado DBTeste_secundario1 

ALTER DATABASE [BDTeste] ADD FILE ( NAME = N'DBTeste_secundario1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DBTeste_secundario1.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [SECONDARY]
GO

-- Lista os dados do filegroup criado via metadados
SELECT * FROM sys.filegroups WHERE name = N'SECONDARY'

-- Muda o filegroup para somente leitura
ALTER DATABASE [BDTeste] MODIFY FILEGROUP [SECONDARY] READ_ONLY;
GO

/*=====================================================*/

--https://learn.microsoft.com/pt-br/sql/relational-databases/security/authentication-access/create-a-database-schema?view=sql-server-ver16

CREATE SCHEMA Promotions;
GO
CREATE SCHEMA Sponsorship
GO
CREATE SCHEMA PastPromotions
GO
CREATE SCHEMA PastSponsorship
GO

CREATE TABLE Promotions.SpecialOffers
(OfferID int IDENTITY PRIMARY KEY,
 Description nvarchar(200),
 StartDate datetime,
 EndDate datetime, 
 DiscountPercent decimal)
 GO


 /*=====================================================*/

 CREATE DATABASE [DBTeste2] 
 ON  PRIMARY 
( NAME = N'DBTeste2_Data1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DBTeste2_Data1.mdf' , SIZE = 20480KB ), 
 FILEGROUP [SECONDARY] 
( NAME = N'DBTeste2_Data2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DBTeste2_Data2.ndf' , SIZE = 20480KB)
 LOG ON 
( NAME = N'DBTeste2_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DBTeste2_Log.ldf' , SIZE = 5120KB)
GO
 
ALTER DATABASE [DBTeste2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DBTeste2] SET AUTO_SHRINK ON 
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [DBTeste2] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

