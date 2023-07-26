USE BDTeste;
GO

CREATE TYPE ENDERECO FROM VARCHAR(200) NOT NULL;
GO

DECLARE @RUA ENDERECO;
SET @RUA = 'Avenida Brasil';
PRINT @RUA

DECLARE @NUMERO INT;
SET @NUMERO = 1500;
GO 

DROP TYPE ENDERECO;
GO


/*=====================================================*/


CREATE TABLE [dbo].[TabelaTeste](
[Codigo] [int] NOT NULL,
[Descricao] [nvarchar](60) NOT NULL,
[Observacoes] [nvarchar](max) NULL
)
GO


--alter table [dbo].[TabelaTeste]
--add Ativo char(1) not null default('S')


--alter table [dbo].[Categoria]
--drop column [Ativo]


--exec sp_rename 'Categoria.Ativo', 'Inativo'

--alter table [dbo].[Categoria]
--alter column [Inativo] char(2)


--create database Curso;
--go


--drop table Categorias;

create table Categoria(
	Id int not null identity(1,1) primary key,
	Nome varchar(50) not null
)





/*=====================================================*/

CREATE PARTITION FUNCTION pf_OrderDate (datetime)
AS RANGE RIGHT
FOR VALUES ('2003-01-01', '2004-01-01', '2005-01-01')

/*
Menor que 2003
Entre 2003 e 2004
Entre 2004 e 2005
Maior que 2005
*/

/*=====================================================*/

--https://learn.microsoft.com/pt-br/sql/t-sql/statements/create-partition-scheme-transact-sql?view=sql-server-ver16

CREATE PARTITION SCHEME ps_OrderDate
AS PARTITION pf_OrderDate
TO (fg1, fg2, fg3, fg4, fg5);
GO



CREATE PARTITION FUNCTION pf_OrderDate (datetime)
AS RANGE RIGHT
FOR VALUES ('2003-01-01', '2004-01-01', '2005-01-01')

CREATE PARTITION SCHEME ps_OrderDate
AS PARTITION pf_OrderDate
TO (fg1, fg2, fg3, fg4, fg5);

CREATE TABLE dbo.PartitionTable (Id int, Description nvarchar(100), OrderDate datetime PRIMARY KEY)  
    ON ps_OrderDate (OrderDate) ;  

INSERT INTO dbo.PartitionTable VALUES (1, 'Primeira linha', GETDATE());
INSERT INTO dbo.PartitionTable VALUES (2, 'Segunda linha', GETDATE());
INSERT INTO dbo.PartitionTable VALUES (3, 'Terceira linha', GETDATE());

SELECT * FROM dbo.PartitionTable


/*=====================================================*/