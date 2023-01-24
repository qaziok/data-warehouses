use HDlab
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

<<<<<<< Updated upstream
<<<<<<< Updated upstream
<<<<<<< Updated upstream
BULK INSERT Adres FROM 'D:\semestr_5\data-warehouses\data_generator\data\T0_T1\addresses_T0_T1.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Osoba FROM 'D:\semestr_5\data-warehouses\data_generator\data\T0_T1\people_T0_T1.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Paczka FROM 'D:\semestr_5\data-warehouses\data_generator\data\T0_T1\packages_T0_T1.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Pracownik FROM 'D:\semestr_5\data-warehouses\data_generator\data\T0_T1\workers_T0_T1.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Sortownia FROM 'D:\semestr_5\data-warehouses\data_generator\data\T0_T1\sorting_centers_T0_T1.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Paczkomat FROM 'D:\semestr_5\data-warehouses\data_generator\data\T0_T1\parcel_lockers_T0_T1.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Uzytkownik FROM 'D:\semestr_5\data-warehouses\data_generator\data\T0_T1\users_T0_T1.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Zlecenie FROM 'D:\semestr_5\data-warehouses\data_generator\data\T0_T1\orders_T0_T1.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|', KEEPNULLS )
BULK INSERT Etap FROM 'D:\semestr_5\data-warehouses\data_generator\data\T0_T1\stages_T0_T1.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|', KEEPNULLS)
=======
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
BULK INSERT Adres FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\addresses_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Osoba FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\people_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Paczka FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\packages_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Pracownik FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\workers_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Sortownia FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\sorting_centers_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Paczkomat FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\parcel_lockers_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Uzytkownik FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\users_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Zlecenie FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\orders_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|', KEEPNULLS )
BULK INSERT Etap FROM 'C:\Users\User\Documents\sem5\HD\data-warehouses\database_schema\dataSources\T1_T2\stages_T1_T2.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|', KEEPNULLS)
<<<<<<< Updated upstream
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes




 


SELECT * FROM Adres
SELECT * FROM Etap
SELECT * FROM Osoba
SELECT * FROM Paczka
SELECT * FROM Paczkomat
SELECT * FROM Pracownik
SELECT * FROM Sortownia
SELECT * FROM Uzytkownik
SELECT * FROM Zlecenie






