create table dbo.SKU (
ID  INT NOT NULL identity, 
Code AS 's' + CAST(ID AS VARCHAR(10)), 
Name VARCHAR(255),
CONSTRAINT UNQ_SKU_ID UNIQUE(ID)  
);

create table dbo.Family (
ID INT NOT NULL identity, 
SurName VARCHAR(255) NOT NULL,
BudgetValue INT,
CONSTRAINT PK_Family PRIMARY KEY (ID)
);

create table dbo.Basket (
ID INT NOT NULL identity, 
ID_SKU INT NOT NULL, 
ID_Family INT NOT NULL, 
Quantity INT NOT NULL CHECK (Quantity>0), 
Value INT NOT NULL CHECK (Value>0), 
PurchaseDate DATE DEFAULT GETDATE(), 
DiscountValue INT,

CONSTRAINT FK_Basket1 FOREIGN KEY(ID_SKU) REFERENCES dbo.SKU(ID),
CONSTRAINT FK_Basket2 FOREIGN KEY(ID_Family) REFERENCES dbo.Family(ID)
);