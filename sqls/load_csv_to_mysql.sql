use earthquake; LOAD DATA LOCAL INFILE 'C:\\Users\\dogus\\Documents\\1-dersler\\tez1\\2.donem\\python\\Result_05-05-2021_08.16.11.csv' INTO TABLE earthquake FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (datetime,lat,lon,depth,magnitude);




SHOW VARIABLES LIKE "local_infile";

SET GLOBAL local_infile=1;
quit

mysql --local-infile=1 -u root -p