CREATE PROCEDURE dbo.usp_MakeFamilyPurchase (@FamilySurName varchar(255)) AS
 BEGIN
 
 if exists (select * from dbo.Family as f where f.SurName=@FamilySurName)
  BEGIN
  update dbo.Family
  set BudgetValue = (BudgetValue - (select sum(b.Value) 
										from dbo.Family f 
										inner join dbo.Basket as b on f.id=b.ID_Family
										where f.SurName=@FamilySurName));
  END;
  else 
  begin
  RAISERROR('Данная семья не найдена.',16,1);
  return;
  end

 END;

 select * from dbo.Family