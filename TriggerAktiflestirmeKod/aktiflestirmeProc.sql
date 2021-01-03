create procedure GirisAktiflestirme
@kId int,
@onayKod int
as

if exists (select * from Kullanicilar where Id = @kId and GirisKod = @onayKod)
begin
update Kullanicilar set GirisKodOnay = 1 where Id = @kId
return 1
end

else
begin
return 0
end