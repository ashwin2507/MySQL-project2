-- Student Name: 	Babu, Ashwin
-- Assignment: 		project #2

-- 1.Retrieve the ID, the model, and the last maintenance date for each plan that was made by 'Boeing'

SELECT ID, Model, LastMaint
FROM Plane
WHERE Maker='Boeing' ;

/*
+----+-------+------------+
| ID | Model | LastMaint  |
+----+-------+------------+
|  1 | 747   | 2015-08-12 | 
|  2 | 777   | 2015-08-14 | 
|  3 | 777   | 2015-09-14 | 
|  4 | 787   | 2015-09-22 | 
+----+-------+------------+
4 rows in set (0.00 sec)
*/


-- 2.Retrieve the names of passengers who had reservations on flights with meals.

SELECT DISTINCT name          
FROM Passenger, Reservation, FlightInstance, Flight
WHERE ID=PassID AND Reservation.FLNO=FlightInstance.FLNO AND FlightInstance.FLNO=Flight.FLNO AND Meal='1' ;

/*
+---------+
| Name    |
+---------+
| James   | 
| Robert  | 
| Paul    | 
| William | 
+---------+
4 rows in set (0.00 sec)
*/

-- 3.Retrieve the names of pilots who flew FROM any airport in 'TX'.

SELECT DISTINCT Pilot.Name FROM Pilot, FlightLegInstance, FlightLeg, Airport WHERE Pilot=ID AND FlightLeg.FLNO=FlightLegInstance.FLNO AND FromA=Code AND State='TX';

/* 
+---------+
| Name    |
+---------+
| Madison | 
| Ryan    | 
| Walker  | 
| Samuel  | 
+---------+
4 rows in set (0.00 sec)
*/

-- 4. Retrieve the total number of take offs for Pilot 'Jones'.

SELECT COUNT(*) FROM Pilot,Reservation,FlightInstance WHERE ID=PassID AND Reservation.FLNO=FlightInstance.FLNO AND Pilot.Name='Jones';

/*
+----------+
| COUNT(*) |
+----------+
|        6 | 
+----------+
1 row in set (0.00 sec)
*/



-- 5. Retrieve the Maker, Model, and total number of seats of planes that has more than 300 seats in total.

SELECT Maker , Model , SUM(NoOfSeats)
FROM PlaneSeats
GROUP BY Model
HAVING (SUM(NoOfSeats)>300);

/*
+--------+-------+----------------+
| Maker  | Model | SUM(NoOfSeats) |
+--------+-------+----------------+
| Airbus | 380   |            360 | 
| Boeing | 747   |            340 | 
+--------+-------+----------------+
2 rows in set (0.00 sec)
*/

-- 6.  Retrieve the Maker and the total number of planes made by this Maker, for Makers who make any plane with total number of seats more than 350.

SELECT Plane.Maker , COUNT(*)  
FROM Plane,
(SELECT Maker 
FROM PlaneSeats
GROUP BY Model
HAVING (SUM(NoOfSeats)>350)) As ANS
WHERE ANS.Maker= Plane.Maker ;
    
/*
+--------+----------+
| Maker  | COUNT(*) |
+--------+----------+
| Airbus |        4 | 
+--------+----------+
1 row in set (0.01 sec)
*/


