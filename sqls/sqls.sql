
--1
SELECT * FROM earthquake WHERE lon < 30 AND lon >= 26 AND lat >= 40 AND lat <= 42 ORDER BY datetime
--2
SELECT * FROM earthquake WHERE lon < 34 AND lon >= 30 AND lat >= 40 AND lat <= 42 ORDER BY datetime
--3
SELECT * FROM earthquake WHERE lon < 38 AND lon >= 34 AND lat >= 40 AND lat <= 42 ORDER BY datetime
--4
SELECT * FROM earthquake WHERE lon < 42 AND lon >= 38 AND lat >= 40 AND lat <= 42 ORDER BY datetime
--5
SELECT * FROM earthquake WHERE lon <= 45 AND lon >= 42 AND lat >= 40 AND lat <= 42 ORDER BY datetime
--6
SELECT * FROM earthquake WHERE lon < 30 AND lon >= 26 AND lat >= 38 AND lat < 40 ORDER BY datetime
--7
SELECT * FROM earthquake WHERE lon < 34 AND lon >= 30 AND lat >= 38 AND lat < 40 ORDER BY datetime
--8
SELECT * FROM earthquake WHERE lon < 38 AND lon >= 34 AND lat >= 38 AND lat < 40 ORDER BY datetime
--9
SELECT * FROM earthquake WHERE lon < 42 AND lon >= 38 AND lat >= 38 AND lat < 40 ORDER BY datetime
--10
SELECT * FROM earthquake WHERE lon <= 45 AND lon >= 42 AND lat >= 38 AND lat < 40 ORDER BY datetime
--11
SELECT * FROM earthquake WHERE lon < 30 AND lon >= 26 AND lat >= 36 AND lat < 38 ORDER BY datetime
--12
SELECT * FROM earthquake WHERE lon < 34 AND lon >= 30 AND lat >= 36 AND lat < 38 ORDER BY datetime
--13
SELECT * FROM earthquake WHERE lon < 38 AND lon >= 34 AND lat >= 36 AND lat < 38 ORDER BY datetime
--14
SELECT * FROM earthquake WHERE lon < 42 AND lon >= 38 AND lat >= 36 AND lat < 38 ORDER BY datetime
--15
SELECT * FROM earthquake WHERE lon <= 45 AND lon >= 42 AND lat >= 36 AND lat < 38 ORDER BY datetime
