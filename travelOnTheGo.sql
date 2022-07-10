CREATE DATABASE IF NOT EXISTS `travel-on-the-go` ;
USE `travel-on-the-go`;

CREATE TABLE IF NOT EXISTS `PASSENGER`(
	`Passenger_Name` VARCHAR(50),
	`Category` VARCHAR(50),
	`Gender` VARCHAR(10),
	`Boarding_City` VARCHAR(50),
	`Destination_City` VARCHAR(50),
	`Distance` INT,
	`Bus_Type` VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS `PRICE`(
	`Bus_Type` VARCHAR(50),
	`Distance` INT,
	`Price` INT
);

INSERT INTO `PASSENGER` (Passenger_Name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES("Sejal", "AC", "F", "Bengaluru", "Chennai", 350, "Sleeper");
INSERT INTO `PASSENGER` (Passenger_Name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sitting");
INSERT INTO `PASSENGER` (Passenger_Name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES("Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper");
INSERT INTO `PASSENGER` (Passenger_Name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES("Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper");
INSERT INTO `PASSENGER` (Passenger_Name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES("Udit", "Non-AC", "M", "Trivandrum", "panaji", 1000, "Sleeper");
INSERT INTO `PASSENGER` (Passenger_Name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES("Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting");
INSERT INTO `PASSENGER` (Passenger_Name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES("Hemant", "Non-AC", "M", "panaji", "Mumbai", 700, "Sleeper");
INSERT INTO `PASSENGER` (Passenger_Name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting");
INSERT INTO `PASSENGER` (Passenger_Name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES("Piyush", "AC", "M", "Pune", "Nagpur", 700, "Sitting");

INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sleeper", 350, 770);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sleeper", 500, 1100);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sleeper", 600, 1320);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sleeper", 700, 1540);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sleeper", 1000, 2200);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sleeper", 1200, 2640);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sleeper", 1500, 2700);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sitting", 500, 620);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sitting", 600, 744);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sitting", 700, 868);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sitting", 1000, 1240);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sitting", 1200, 1488);
INSERT INTO `PRICE` (Bus_Type, Distance, Price) VALUES("Sitting", 1500, 1860);

/* 3) How many females and how many male passengers travelled for a minimum distance of
600 KM s? */
SELECT Gender, count(Gender) AS 'Count' FROM Passenger
WHERE Distance >= 600 GROUP BY Gender;

/* 4) Find the minimum ticket price for Sleeper Bus. */
SELECT min(Price) AS "Minimum Sleeper Price" FROM Price
WHERE `Bus_Type` = "Sleeper";

/* 5) Select passenger names whose names start with character 'S' */
SELECT Passenger_Name FROM Passenger WHERE Passenger_Name LIKE 'S%';

/* 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output */
SELECT Passenger.Passenger_Name AS "Passenger Name",
Passenger.Boarding_City AS "Boarding City",
Passenger.Destination_City AS "Destination City",
Passenger.Bus_Type AS "Bus Type", Price.Price AS "Price" FROM Passenger, Price
WHERE Passenger.Bus_Type = Price.Bus_Type AND Passenger.Distance = Price.Distance;

/* 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s */
SELECT Passenger.Passenger_Name AS "Passenger Name", Price.Price FROM Passenger, Price
WHERE Passenger.Bus_Type = Price.Bus_Type AND Passenger.Distance = Price.Distance
AND Passenger.Bus_Type = "Sitting" AND Passenger.Distance = 1000;

/* 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji? */
SELECT Bus_Type AS "Bus Type", Price FROM PRICE WHERE Distance = 
(SELECT Passenger.Distance FROM PASSENGER WHERE Passenger_Name = "Pallavi")
GROUP BY Bus_Type;

/* 9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order */
SELECT DISTINCT Distance FROM Passenger ORDER BY Distance DESC;

/* 10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables */
SELECT Passenger_Name AS "Passenger Name", Distance * 100.0 /
(SELECT sum(Distance) FROM Passenger)
AS "% Distance Travelled" FROM Passenger;

/* Another Method for reference:
SELECT Passenger_Name AS "Passenger Name", Distance * 100.0 / sum(Distance) over ()
AS "% Distance Travelled" FROM Passenger;
*/

/* 11)  Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise */
SELECT Distance, Price,
CASE
	WHEN Price > 1000 THEN "Expensive"
    WHEN Price < 1000 AND Price > 500 THEN "Average Cost"
    ELSE "Cheap"
END
AS Category FROM Price;