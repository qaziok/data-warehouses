use HDlab
GO

DELETE FROM Adres
DBCC CHECKIDENT ('Adres', RESEED, 0);
DELETE FROM Etap
DBCC CHECKIDENT ('Etap', RESEED, 0);
DELETE FROM Osoba
DBCC CHECKIDENT ('Osoba', RESEED, 0);
DELETE FROM Paczka
DBCC CHECKIDENT ('Paczka', RESEED, 0);
DELETE FROM Paczkomat
DBCC CHECKIDENT ('Paczkomat', RESEED, 0);
DELETE FROM Pracownik
DBCC CHECKIDENT ('Pracownik', RESEED, 0);
DELETE FROM Sortownia
DBCC CHECKIDENT ('Sortownia', RESEED, 0);
DELETE FROM Uzytkownik
DBCC CHECKIDENT ('Uzytkownik', RESEED, 0);
DELETE FROM Zlecenie
DBCC CHECKIDENT ('Zlecenie', RESEED, 0);

BULK INSERT Adres FROM 'D:\semestr_5\hd\generator\addresses.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Osoba FROM 'D:\semestr_5\hd\generator\people.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Paczka FROM 'D:\semestr_5\hd\generator\packages.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Pracownik FROM 'D:\semestr_5\hd\generator\workers.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Sortownia FROM 'D:\semestr_5\hd\generator\sorting_centers.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Paczkomat FROM 'D:\semestr_5\hd\generator\parcel_lockers.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Uzytkownik FROM 'D:\semestr_5\hd\generator\users.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|')
BULK INSERT Zlecenie FROM 'D:\semestr_5\hd\generator\orders.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|', KEEPNULLS )
BULK INSERT Etap FROM 'D:\semestr_5\hd\generator\stages.bulk' WITH (CODEPAGE = 'ACP',FIELDTERMINATOR='|', KEEPNULLS)




 


SELECT * FROM Adres
SELECT * FROM Etap
SELECT * FROM Osoba
SELECT * FROM Paczka
SELECT * FROM Paczkomat
SELECT * FROM Pracownik
SELECT * FROM Sortownia
SELECT * FROM Uzytkownik
SELECT * FROM Zlecenie






