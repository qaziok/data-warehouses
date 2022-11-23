GO

use OutPostdw

delete from etap;
delete from podsumowanie_mies;
delete from zlecenie;
delete from typ;
delete from pracownik;
delete from paczka;
delete from miejsce;
delete from [data];

GO

use OutPostdw

DBCC CHECKIDENT ('data', RESEED, 0);
DBCC CHECKIDENT ('miejsce', RESEED, 0);
DBCC CHECKIDENT ('paczka', RESEED, 0);
DBCC CHECKIDENT ('pracownik', RESEED, 0);
DBCC CHECKIDENT ('typ', RESEED, 0);
DBCC CHECKIDENT ('zlecenie', RESEED, 0);

GO

use OutPostdw

delete from typ;
insert into typ values ('Paczka odebrana przez kuriera');
insert into typ values ('Paczka w trasie');
insert into typ values ('Paczka dostarczona do celu');

delete from zlecenie;
insert into zlecenie values (1);
insert into zlecenie values (2);
insert into zlecenie values (3);

delete from pracownik;
insert into pracownik values (1, 'ma³e', '(20,25>', '2020-12-15', null);
insert into pracownik values (2, 'œrednie', '(25,30>', '2020-12-15', '2021-12-15');
insert into pracownik values (3, 'du¿e', '(40,50>', '2020-07-15', null);

delete from paczka;
insert into paczka values (1, 'lekka', 'ma³a');
insert into paczka values (2, 'œrednia', 'œredniego rozmiaru');
insert into paczka values (3, 'ciê¿ka', 'du¿a');

delete from miejsce;
insert into miejsce values (1, 'paczkomat', 'Gdynia', 'Pomorze', '', '2019-05-15', '2021-12-15');
insert into miejsce values (2, 'sortownia', 'Gdañsk', 'Pomorze', 'œrednia', '2018-12-15', null);
insert into miejsce values (3, 'sortownia', 'Gdañsk', 'Pomorze', 'œrednia', '2018-12-15', null);

delete from [data];
insert into [data] values (2022, 'styczeñ', 3);
insert into [data] values (2022, 'styczeñ', 4);
insert into [data] values (2022, 'styczeñ', 5);
insert into [data] values (2022, 'grudzieñ', 6);
insert into [data] values (2022, 'listopad', 7);

delete from etap;
insert into etap values (1, 1, 1, 1, 1, 1, 1232, 20000);
insert into etap values (2, 2, 2, 2, 2, 2, 468, 20);
insert into etap values (3, 3, 3, 3, 3, 3, 1684, 0);

delete from podsumowanie_mies;
insert into podsumowanie_mies values (1, 1, 4, 162, 1);
insert into podsumowanie_mies values (2, 1, 5, 142, 2);
insert into podsumowanie_mies values (3, 1, 4, 176, 3);

GO