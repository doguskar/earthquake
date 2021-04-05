SELECT * FROM earthquake.earthquake INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/earthquake.csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';


SELECT * FROM earthquake.earthquake WHERE magnitude >= 4 ORDER BY datetime INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/all_earthquake_magnitude_bigger_than_4_2021_04_05.csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

SELECT * FROM earthquake.earthquake WHERE lon < 30 AND lon >= 26 AND lat >= 38 AND lat < 40 ORDER BY datetime INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/earthquake_6_2021_04_05.csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';



SELECT * FROM earthquake.earthquake WHERE lon < 30 AND lon >= 26 AND lat >= 38 AND lat < 40 AND magnitude >= 4 ORDER BY datetime INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/6_earthquake_magnitude_bigger_than_4_2021_04_05.csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';



mysql --local-infile=1 -u root -p MyNewPass

mysql --local-infile=1 -u root -p

SHOW VARIABLES LIKE "secure_file_priv";

SELECT @@GLOBAL.secure_file_priv;