CREATE FUNCTION dbo.udf_GetSKUPrice (@ID_SKU as int)
returns MONEY
begin
	DECLARE @Cost as DECIMAL(18, 2);
	
	select @Cost = b.value/b.Quantity
	 from dbo.SKU as sku
	 inner join dbo.Basket as b on b.ID_SKU=sku.id
	 where sku.ID=@ID_SKU;
	 
	RETURN @Cost; 
	
end;
GO