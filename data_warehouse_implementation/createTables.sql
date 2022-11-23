CREATE database OutPostdw
USE OutPostdw
sp_changedbowner 'LAPTOP-ICCJFQSQ\qazio' 
--tutaj trzeba wpisa� nazw� Twojego u�ytkownika; mo�na to sprawdzi� we w��ciwo�ciach innej bazy danych, kt�r� posiadasz w zak�adce "general"

GO

use OutPostdw

create table paczka(
	id_paczka int primary key identity(1,1) not null,
	nr_paczki int not null,
	waga varchar(10) not null CHECK (waga IN('lekka', '�rednia','ci�ka')) DEFAULT 'lekka',
	rozmiar varchar(20) not null CHECK (rozmiar IN('ma�a', '�redniego rozmiaru','du�a')) DEFAULT 'ma�a',
);

create table typ(
	id_typ int primary key identity(1,1) not null,
	typ_typu varchar(80) not null CHECK (typ_typu IN('Paczka odebrana przez kuriera', 'Paczka w trasie', 'Paczka dostarczona do celu', 'Paczka odebrana w sortowni', 'Paczka zatwierdzona w sortowni', 'Paczka przygotowana do transportu', 'Paczka wydana do transportu')) DEFAULT 'Paczka odebrana przez kuriera'
);

create table pracownik (
	id_pracownik int primary key identity(1,1) not null,
	nr_pracownika int not null,
	wynagrodzenie varchar(20) not null CHECK (wynagrodzenie IN('b.ma�e', 'ma�e', '�rednie', 'du�e', 'b.du�e')) DEFAULT '�rednie',
	wiek varchar(20) not null CHECK (wiek IN('(0,20>', '(20,25>', '(25,30>', '(30,35>', '(35,40>', '(40,50>', '(50,60>', '(60,inf)')) DEFAULT '(0,20>',
	data_wstawienia date,
	data_deaktywacji date
);

create table zlecenie (
	id_zlecenie int primary key identity(1,1) not null,
	nr_zlecenie int not null,
);

create table miejsce (
	id_miejsce int primary key identity(1,1) not null,
	nr_miejse int not null,
	typ varchar(20) not null CHECK (typ IN('paczkomat', 'sortownia')) DEFAULT 'sortownia',
	miasto Varchar(40) not null,
	region Varchar(40) not null,
	ilosc_pracownikow varchar(30) not null CHECK (ilosc_pracownikow IN('', 'ma�a', '�rednia', 'du�a')) DEFAULT '�rednia',
	data_wstawienia date,
	data_deaktywacji date
);

create table [data] (
	id_data int primary key identity(1,1) not null,
	rok int not null,
	miesiac varchar(20) not null CHECK (miesiac IN('stycze�', 'luty', 'marzec', 'kwiecie�', 'maj', 'czerwiec', 'lipiec', 'sierpie�', 'wrzesie�', 'pa�dziernik', 'listopad', 'grudzie�')) DEFAULT 'stycze�',
	dzien int not null,
);

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
);

create table podsumowanie_mies(
	id_pracownik int foreign key references pracownik not null,
	id_miejsce int foreign key references miejsce not null,
	id_data int foreign key references [data] not null,
	liczba_przepracowanych_dni_w_mies int,
	nr_pracownika int,
	primary key (id_pracownik, id_miejsce, id_data)
);

GO
