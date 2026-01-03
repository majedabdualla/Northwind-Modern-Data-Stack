/*
===============================================================================
DDL Script: DATABASE Order_management_OLTP
===============================================================================
Script Purpose:
    This script creates tables in the Order_management_OLTP, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of Tables
===============================================================================
*/


USE master;
GO

-- Drop and recreate the 'order_management_OLTP' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'order_management_OLTP')
BEGIN
    ALTER DATABASE order_management_OLTP SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE order_management_OLTP;
END;
GO

-- Create the 'order_management_OLTP' database
CREATE DATABASE order_management_OLTP;
GO

USE order_management_OLTP;
GO



IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
    DROP TABLE dbo.Employees;
GO

CREATE TABLE "Employees" (
	"EmployeeID" int IDENTITY (1, 1)  PRIMARY KEY ,
	"LastName" nvarchar (20) NOT NULL ,
	"FirstName" nvarchar (10) NOT NULL ,
	"Title" nvarchar (30) NULL ,
	"TitleOfCourtesy" nvarchar (25) NULL ,
	"BirthDate" datetime NULL ,
	"HireDate" datetime NULL ,
	"Address" nvarchar (60) NULL ,
	"City" nvarchar (15) NULL ,
	"Region" nvarchar (15) NULL ,
	"PostalCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"HomePhone" nvarchar (24) NULL ,
	"Extension" nvarchar (4) NULL ,
	"Photo" image NULL ,
	"Notes" ntext NULL ,
	"ReportsTo" int NULL ,
	"PhotoPath" nvarchar (255) NULL ,
	 
	CONSTRAINT "FK_Employees_Employees" FOREIGN KEY 
	(
		"ReportsTo"
	) REFERENCES "dbo"."Employees" (
		"EmployeeID"
	),
	CONSTRAINT "CK_Birthdate" CHECK (BirthDate < getdate())
)




IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL
    DROP TABLE dbo.Categories;
GO 
CREATE TABLE "Categories" (
	"CategoryID" "int" IDENTITY (1, 1) PRIMARY KEY ,
	"CategoryName" nvarchar (15) NOT NULL ,
	"Description" ntext NULL ,
	"Picture" image NULL 
)
GO
 CREATE  INDEX "CategoryName" ON "dbo"."Categories"("CategoryName")
GO



IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL
    DROP TABLE dbo.Customers;
CREATE TABLE "Customers" (
	"CustomerID" nchar (5) PRIMARY KEY ,
	"CompanyName" nvarchar (40) NOT NULL ,
	"ContactName" nvarchar (30) NULL ,
	"ContactTitle" nvarchar (30) NULL ,
	"Address" nvarchar (60) NULL ,
	"City" nvarchar (15) NULL ,
	"Region" nvarchar (15) NULL ,
	"PostalCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"Phone" nvarchar (24) NULL ,
	"Fax" nvarchar (24) NULL
)
GO
 CREATE  INDEX "City" ON dbo.Customers(City)
GO
 CREATE  INDEX "CompanyName" ON dbo.Customers(CompanyName)
GO




IF OBJECT_ID('dbo.Shippers', 'U') IS NOT NULL
    DROP TABLE dbo.Shippers;
CREATE TABLE "Shippers" (
	"ShipperID" int IDENTITY (1, 1) PRIMARY KEY ,
	"CompanyName" nvarchar (40) NOT NULL ,
	"Phone" nvarchar (24) NULL
)
GO


IF OBJECT_ID('dbo.Suppliers', 'U') IS NOT NULL
    DROP TABLE dbo.Suppliers;
CREATE TABLE "Suppliers" (
	"SupplierID" int IDENTITY (1, 1)  PRIMARY KEY ,
	"CompanyName" nvarchar (40) NOT NULL ,
	"ContactName" nvarchar (30) NULL ,
	"ContactTitle" nvarchar (30) NULL ,
	"Address" nvarchar (60) NULL ,
	"City" nvarchar (15) NULL ,
	"Region" nvarchar (15) NULL ,
	"PostalCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"Phone" nvarchar (24) NULL ,
	"Fax" nvarchar (24) NULL ,
	"HomePage" ntext NULL 
)
GO

 CREATE  INDEX "CompanyName" ON dbo.Suppliers(CompanyName)
GO 


IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;
CREATE TABLE "Orders" (
	"OrderID" "int" IDENTITY (1, 1)  PRIMARY KEY ,
	"CustomerID" nchar (5) NULL ,
	"EmployeeID" int NULL ,
	"OrderDate" datetime NULL ,
	"RequiredDate" datetime NULL ,
	"ShippedDate" datetime NULL ,
	"ShipVia" int NULL ,
	"Freight" money NULL CONSTRAINT "DF_Orders_Freight" DEFAULT (0),
	"ShipName" nvarchar (40) NULL ,
	"ShipAddress" nvarchar (60) NULL ,
	"ShipCity" nvarchar (15) NULL ,
	"ShipRegion" nvarchar (15) NULL ,
	"ShipPostalCode" nvarchar (10) NULL ,
	"ShipCountry" nvarchar (15) NULL ,

	CONSTRAINT "FK_Orders_Customers" FOREIGN KEY 
	(
		"CustomerID"
	) REFERENCES "dbo"."Customers" (
		"CustomerID"
	),
	CONSTRAINT "FK_Orders_Employees" FOREIGN KEY 
	(
		"EmployeeID"
	) REFERENCES "dbo"."Employees" (
		"EmployeeID"
	),
	CONSTRAINT "FK_Orders_Shippers" FOREIGN KEY 
	(
		"ShipVia"
	) REFERENCES "dbo"."Shippers" (
		"ShipperID"
	)
)
GO


 CREATE  INDEX "CustomerID" ON "dbo"."Orders"("CustomerID")
GO


IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL
    DROP TABLE dbo.Products;
CREATE TABLE "Products" (
	"ProductID" int IDENTITY (1, 1)  PRIMARY KEY ,
	"ProductName" nvarchar (40) NOT NULL ,
	"SupplierID" int NULL ,
	"CategoryID" int NULL ,
	"QuantityPerUnit" nvarchar (20) NULL ,
	"UnitPrice" money NULL   DEFAULT (0),
	"UnitsInStock" smallint NULL   DEFAULT (0),
	"UnitsOnOrder" smallint NULL  DEFAULT (0),
	"ReorderLevel" smallint NULL   DEFAULT (0),
	"Discontinued" bit NOT NULL   DEFAULT (0),
	CONSTRAINT "FK_Products_Categories" FOREIGN KEY 
	(
		"CategoryID"
	) REFERENCES "dbo"."Categories" (
		"CategoryID"
	),
	CONSTRAINT "FK_Products_Suppliers" FOREIGN KEY 
	(
		"SupplierID"
	) REFERENCES "dbo"."Suppliers" (
		"SupplierID"
	),
	CONSTRAINT "CK_Products_UnitPrice" CHECK (UnitPrice >= 0),
	CONSTRAINT "CK_ReorderLevel" CHECK (ReorderLevel >= 0),
	CONSTRAINT "CK_UnitsInStock" CHECK (UnitsInStock >= 0),
	CONSTRAINT "CK_UnitsOnOrder" CHECK (UnitsOnOrder >= 0)
)
GO


IF OBJECT_ID('dbo.Order_Details', 'U') IS NOT NULL
    DROP TABLE dbo.Order_Details;
CREATE TABLE "Order_Details" (
	"OrderID" int NOT NULL ,
	"ProductID" int NOT NULL ,
	"UnitPrice" money NOT NULL DEFAULT (0),
	"Quantity" smallint NOT NULL  DEFAULT (1),
	"Discount" real NOT NULL  DEFAULT (0),
	CONSTRAINT "PK_Order_Details" PRIMARY KEY 
	(
		"OrderID",
		"ProductID"
	),
	CONSTRAINT "FK_Order_Details_Orders" FOREIGN KEY 
	(
		"OrderID"
	) REFERENCES "dbo"."Orders" (
		"OrderID"
	),
	CONSTRAINT "FK_Order_Details_Products" FOREIGN KEY 
	(
		"ProductID"
	) REFERENCES "dbo"."Products" (
		"ProductID"
	),
	CONSTRAINT "CK_Discount" CHECK (Discount >= 0 and (Discount <= 1)),
	CONSTRAINT "CK_Quantity" CHECK (Quantity > 0),
	CONSTRAINT "CK_UnitPrice" CHECK (UnitPrice >= 0)
)
GO


IF OBJECT_ID('dbo.CustomerDemographica', 'U') IS NOT NULL
    DROP TABLE dbo.CustomerDemographica;
CREATE TABLE CustomerDemographica (
     CustomerTypeID INT IDENTITY(1,1) PRIMARY KEY , 
	 CustomerDesc  NVARCHAR(50) 
	 )
GO

IF OBJECT_ID('dbo.CustomerDemo', 'U') IS NOT NULL
    DROP TABLE dbo.CustomerDemo;
CREATE TABLE CustomerDemo ( 
   "CustomerID" nchar (5) NOT NULL  ,
   CustomerTypeID INT NOT NULL , 
   CONSTRAINT PK_CUS_CUS_DEMO PRIMARY KEY (CustomerID , CustomerTypeID),
   CONSTRAINT FK_CustomerDemo_CUSTOMER FOREIGN KEY (CustomerID)
   REFERENCES Customers(CustomerID) ,
   CONSTRAINT FK_CustomerDemo_CustomerDemographica FOREIGN KEY (CustomerTypeID)
   REFERENCES CustomerDemographica(CustomerTypeID) )

GO
   IF OBJECT_ID('dbo.Region', 'U') IS NOT NULL
    DROP TABLE dbo.Region;
   CREATE TABLE Region ( 
   RegionID INT PRIMARY KEY , 
   RegionDescription NCHAR(50) NOT NULL
   )
   
GO
     IF OBJECT_ID('dbo.territories', 'U') IS NOT NULL
    DROP TABLE dbo.territories;
   CREATE TABLE territories( 
      territoryid nvarchar(20) PRIMARY KEY ,
	  territoryDescription nchar(50) ,
	  RegionID INT NOT NULL , 
	  CONSTRAINT FOREIGN_KEY_territories_REGION FOREIGN KEY ( RegionID)
		  REFERENCES Region(RegionID) )

GO
	 IF OBJECT_ID('dbo.EemployeeTerritory', 'U') IS NOT NULL
    DROP TABLE dbo.EemployeeTerritory;
	CREATE TABLE EemployeeTerritory ( 
	   EmployeeID INT NOT NULL  ,
	   TerritoryID NVARCHAR(20) NOT NULL , 
	   CONSTRAINT PK_EemployeeTerritory PRIMARY KEY (EmployeeID , TerritoryID),
	   CONSTRAINT FK_EemployeeTerritory_Eemployee FOREIGN KEY (EmployeeID)
	   REFERENCES Employees(EmployeeID) ,
	   CONSTRAINT FK_EemployeeTerritory_Territory FOREIGN KEY (TerritoryID)
	   REFERENCES Territories(TerritoryID) )
GO
 





