CREATE TRIGGER TR_Basket_insert_update on dbo.Basket AFTER INSERT 
as
begin
 if (select case when c>1 then 2 end as t from (select count(b.id_sku) c, b.id_sku u  from inserted b group by b.id_sku)as a
												where case when c>1 then 2 end is not null
												group by case when c>1 then 2 end)
											>1 --проверяем что вставляется более 2 записей с одинаковым id_sku
	begin
	 update b
	 set b.DiscountValue= case when (select a.id_sku 
						from (select count(id_sku)as c, id_sku  from inserted group by id_sku) as a
						 where a.c>1
						 and b.id_sku=a.id_sku) is null then 0 else b.value end * 0.05 --добавляем скидку только строкам, с одинаковым id_sku, исключая возможные строки с другими id из апдейта
	 from dbo.Basket b
	 inner join inserted as i on i.id=b.id and i.id_sku=b.id_sku
	end;
	
	else
	begin
	 update b
	 set b.DiscountValue= 0
	 from dbo.Basket b
	 inner join inserted as i on i.id=b.id and i.id_sku=b.id_sku
	end;
end;
