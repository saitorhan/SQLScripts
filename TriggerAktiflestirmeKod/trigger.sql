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
set @mesaj = concat('<html><body> Say�n ', @tamAd, ' <br/>',
'Sisteme kay�t i�in gerekli tek kullan�ml�k �ifreniz: <b>', convert(nvarchar, @kod), ' </b><br/>',
'tek kullan�ml�k �ifrenizi kimse ile payla�may�n�z.'
)

exec msdb.dbo.sp_send_dbmail
		@profile_name = 'Genel',
		@recipients = @mail,
		@body = @mesaj,
		@subject = 'Sistem Hesab� Aktifle�tirme Kodu',
		@body_format = 'HTML'


fetch next from cls into @id, @tamAd, @mail
end

close cls
deallocate cls