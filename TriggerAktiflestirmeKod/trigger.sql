create trigger HesapAktiflestirmekod
on Kullanicilar
after insert

as
declare @id int,
		@tamAd nvarchar(100),
		@mail varchar(50),
		@kod int,
		@mesaj nvarchar(max)

declare cls cursor for select Id,TamAd, Mail from inserted
open cls
fetch next from cls into @id, @tamAd, @mail

while @@FETCH_STATUS = 0
begin

set @kod = RAND() * 55000 + 10000
update Kullanicilar set GirisKod = @kod where Id = @id
set @mesaj = concat('<html><body> Sayýn ', @tamAd, ' <br/>',
'Sisteme kayýt için gerekli tek kullanýmlýk þifreniz: <b>', convert(nvarchar, @kod), ' </b><br/>',
'tek kullanýmlýk þifrenizi kimse ile paylaþmayýnýz.'
)

exec msdb.dbo.sp_send_dbmail
		@profile_name = 'Genel',
		@recipients = @mail,
		@body = @mesaj,
		@subject = 'Sistem Hesabý Aktifleþtirme Kodu',
		@body_format = 'HTML'


fetch next from cls into @id, @tamAd, @mail
end

close cls
deallocate cls