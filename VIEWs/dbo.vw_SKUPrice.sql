CREATE VIEW dbo.vw_SKUPriceв AS
SELECT sku.*, dbo.udf_GetSKUPrice(sku.id)
from dbo.SKU as sku;