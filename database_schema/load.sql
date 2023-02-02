use HDlabDB
GO

DELETE FROM Etap
DBCC CHECKIDENT ('Etap', RESEED, 0);
DELETE FROM Zlecenie
DBCC CHECKIDENT ('Zlecenie', RESEED, 0);
DELETE FROM Paczka
DBCC CHECKIDENT ('Paczka', RESEED, 0);
DELETE FROM Pracownik
DBCC CHECKIDENT ('Pracownik', RESEED, 0);
DELETE FROM Sortownia
DBCC CHECKIDENT ('Sortownia', RESEED, 0);
DELETE FROM Paczkomat
DBCC CHECKIDENT ('Paczkomat', RESEED, 0);
DELETE FROM Uzytkownik
DBCC CHECKIDENT ('Uzytkownik', RESEED, 0);
DELETE FROM Adres
DBCC CHECKIDENT ('Adres', RESEED, 0);
DELETE FROM Osoba
DBCC CHECKIDENT ('Osoba', RESEED, 0);

BULK INSERT Adres FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\addresses_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Osoba FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\people_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Paczka FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\packages_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Pracownik FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\workers_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Sortownia FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\sorting_centers_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Paczkomat FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\parcel_lockers_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Uzytkownik FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\users_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Zlecenie FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\orders_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|', KEEPNULLS )
BULK INSERT Etap FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\stages_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|', KEEPNULLS)




 








