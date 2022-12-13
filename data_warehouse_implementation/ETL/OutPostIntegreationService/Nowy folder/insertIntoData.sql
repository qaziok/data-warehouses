DECLARE  @Start datetime
		 ,@End  datetime
DECLARE @AllDates table
		(Date datetime)

SELECT @Start = '2000-01-01', @End = '2030-12-31';

WITH Nbrs_3( n ) AS ( SELECT 1 UNION SELECT 0 ),
     Nbrs_2( n ) AS ( SELECT 1 FROM Nbrs_3 n1 CROSS JOIN Nbrs_3 n2 ),
     Nbrs_1( n ) AS ( SELECT 1 FROM Nbrs_2 n1 CROSS JOIN Nbrs_2 n2 ),
     Nbrs_0( n ) AS ( SELECT 1 FROM Nbrs_1 n1 CROSS JOIN Nbrs_1 n2 ),
     Nbrs  ( n ) AS ( SELECT 1 FROM Nbrs_0 n1 CROSS JOIN Nbrs_0 n2 )

	INSERT INTO [data] SELECT CAST(YEAR(@Start+n-1) AS VARCHAR(4)) as Year, case month(@Start+n-1)
WHEN 1 THEN 'styczeñ'
WHEN 2 THEN 'luty'
WHEN 3 THEN 'marzec'
WHEN 4 THEN 'kwiecieñ'
WHEN 5 THEN 'maj'
WHEN 6 THEN 'czerwiec'
WHEN 7 THEN 'lipiec'
WHEN 8 THEN 'sierpieñ'
WHEN 9 THEN 'wrzesieñ'
WHEN 10 THEN 'paŸdziernik'
WHEN 11 THEN 'listopad'
WHEN 12 THEN 'grudzieñ'
END as "Month", DATEPART(DAY, @Start+n-1) as [day]

	FROM ( SELECT ROW_NUMBER() OVER (ORDER BY n)
		FROM Nbrs ) D ( n )
		WHERE n <= DATEDIFF(day,@Start,@End)+1 ;