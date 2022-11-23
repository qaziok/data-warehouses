CREATE database OutPostdw
USE OutPostdw
sp_changedbowner 'LAPTOP-46GI6A46\User' 
--tutaj trzeba wpisaæ nazwê Twojego u¿ytkownika; mo¿na to sprawdziæ we w³œciwoœciach innej bazy danych, któr¹ posiadasz w zak³adce "general"

GO

use OutPostdw

create table paczka(
	id_paczka int primary key not null,
	nr_paczki int not null,
	waga varchar(10) not null CHECK (waga IN('lekka', 'œrednia','ciê¿ka')) DEFAULT 'lekka',
	rozmiar varchar(20) not null CHECK (rozmiar IN('ma³a', 'œredniego rozmiaru','du¿a')) DEFAULT 'ma³a',
)

create table typ(
	id_typ int primary key not null,
	typ_typu varchar(80) not null CHECK (typ_typu IN(“Paczka odebrana przez kuriera”, “Paczka w trasie”, “Paczka dostarczona do celu”, “Paczka odebrana w sortowni”, “Paczka zatwierdzona w sortowni”, “Paczka przygotowana do transportu”, “Paczka wydana do transportu”)) DEFAULT 'lekka'
)

create table pracownik (
	id_pracownik int primary key not null,
	nr_pracownika int not null,
	wynagrodzenie enum not null,
	wiek enum,
	data_wstawienia date,
	data_deaktywacji date
)

create table zlecenie (
	id_zlecenie int primary key not null,
	nr_zlecenie int not null,
)

create table miejsce (
	id_miejsce int primary key not null,
	nr_miejse int not null,
	typ enum not null,
	miasto Varchar(40) not null,
	region Varchar(40) not null,
	ilosc_pracownikow enum not null,
	data_wstawienia date,
	data_deaktywacji date
)

create table [data] (
	id_data int primary key not null,
	rok int not null,
	miesiac enum not null,
	dzien int not null,
)

create table etap(
	id_typ int foreign key references typ not null,
	id_paczka int foreign key references paczka not null,
	id_pracownik int foreign key references pracownik not null,
	id_zlecenie int foreign key references zlecenie not null,
	id_miejsce int foreign key references miejsce not null,
	id_data int foreign key references [data] not null,
	czas_realizacji int,
	odleglosc int,
	primary key (id_typ, id_paczka, id_pracownik, id_zlecenie, id_miejsce, id_data)
)

create table podsumowanie_mies(
	id_pracownik int foreign key references pracownik not null,
	id_miejsce int foreign key references miejsce not null,
	id_data int foreign key references [data] not null,
	liczba_przepracowanych_dni_w_mies int,
	nr_pracownika int,
	primary key (id_pracownik, id_miejsce, id_data)
)

INSERT INTO t_date values ('10-10-13')
INSERT INTO t_fact values ('10-10-13')

GO
