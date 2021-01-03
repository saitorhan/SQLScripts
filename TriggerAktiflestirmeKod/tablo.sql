create table Kullanicilar(
Id int primary key identity,
KullaniciAd varchar(30) not null unique,
Ad nvarchar(50) not null,
Soyad nvarchar(50) not null,
TamAd as concat_ws(' ', Ad, Soyad),
Mail varchar(50) not null unique,
Parola varchar(20) not null,
GirisTarih datetime default getdate(),
GirisKod int null,
GirisKodOnay bit not null default 0,
)