#Ashish Patil.
# Problem Statement

# The business problem is to Optimizing data handling will result in reduced processing time, improved accuracy in performance evaluations,and increasing in sale of vehical.
# The objective is to analyze the historical data and reduced maintenance costs, and enhanced overall performance of our vehicle fleet.

# CRISP-ML(Q) process model :

# 1. Business and Data Understanding
# 2. Data Preparation

#*Objective(s):* Minimize maintenance costs and enhanced overall performance of vehical.
# *Constraints:* Maximize data effectively Allocate sufficient resources (both human and technological) to manage and process.

#*Success Criteria*
# 
# - *Business Success Criteria*: Gather feedback from employees involved in the optimization process to ensure their satisfaction and to identify areas for improvement.
#
# - *ML Success Criteria*: Analyze the importance of different features (Torque, Tool Wear, Temperature, Air temperature) in making accurate predictions.
#
# - *Economic Success Criteria*: Assess the impact of improved maintenance on the resale value of vehicles.

#Data:
#		obtained from Project Instructor.

#Description:
#Explanation of the Columns in Data set:

#UDI :serially arranged vehical number.
#Product_ID : serial number of vehical.
#Type : type of vehical.
#Air_temperature : Air temperatur of each vehical.
#Process _temperature :Process temperatur of each vehical.
#Rotational_speed : Rotational_speed of vehical in [rpm].
#Torque : Torque of vehical.
#Tool_wear : gradual breakdown of vehical.
#Machine_failure : at what conditions machine gets failuare.


#Requirements: To execute this project, we'll use the following tools and libraries:

 # MySQL workbench:
  # We will use the SQL environment



#For importing dataset from csv file in sql we have to do some steps which are given as:
	# creating database.
    # using that database create table according to the information provided in csv file.
	# After that we can import data which is provided.


create database project;
show databases;
use project;
show tables;

create table machine_failure(UDI int,Product_ID varchar(50), Type char,Air_temperature float(50),Process_temperature float(50),
Rotational_speed int(50),Torque float(20),Tool_wear int(20),Machine_failure int, TWF int,HDF int,PWF int,OSF int,RNF int);

select * from machine_failure ;

SELECT * FROM machine_failure LIMIT 10000;



desc machine_failure ;


															## Strating some EDA phases here ##

	# First moment Business Decission#
# mean measuring
SELECT AVG(air_temperature) AS mean_air_temperature
FROM machine_failure;
#  mean = 300.00492999999875;  
		## mostly prefered air_temperature in vehical is near about (300.00492999999875).
SELECT AVG(process_temperature) AS mean_process_temperature
FROM machine_failure;
#  mean = 310.00555999999995;
		##From mean value we can say that process_temperature of most of the vehical is near to mean value of the specified column above which point out towards that the process temperature(310.00555999999995) is suitable for going on processes of vehical.
SELECT AVG(Rotational_speed) AS mean_Rotational_speed
FROM machine_failure;
# mean =1538.7761;
		##from the mean value we can say that most of the vehical rotational speed is near of mean value of rotational speed column which is in rpm.
SELECT AVG(Torque) AS mean_Torque
FROM machine_failure;
#mean = 39.98690999906063;
#above mean value shows that requirement of torque moment in vehical. 
SELECT AVG(Tool_wear) AS mean_Tool_wear
FROM machine_failure;
#mean = 107.9510;
#here mean value shows that most of the time at what range value when vehical get problem.  

# Median :
															SELECT air_temperature AS median_air_temperature
															FROM (
																SELECT air_temperature, ROW_NUMBER() OVER (ORDER BY air_temperature) AS row_num,
																	   COUNT(*) OVER () AS total_count
																FROM machine_failure
															) AS subquery
															WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

															# median_air_temperature = 300.1;
																#above value of median shows that half of the vehical has air temperature below 300.1
														
															SELECT process_temperature AS median_process_temperature
															FROM (
																SELECT process_temperature, ROW_NUMBER() OVER (ORDER BY process_temperature) AS row_num,
																	   COUNT(*) OVER () AS total_count
																		   FROM machine_failure
															) AS subquery
															WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

															# median_air_temp = 310.1
																# here median value shows that most of the vehical have process temperature higher than median value.
SELECT Rotational_speed AS median_Rotational_speed
FROM (
    SELECT Rotational_speed, ROW_NUMBER() OVER (ORDER BY Rotational_speed) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM machine_failure
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

# median_Rotational_speed = 1503;


SELECT Torque AS median_Torque
FROM (
    SELECT Torque, ROW_NUMBER() OVER (ORDER BY Torque) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM machine_failure
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

#  median_Torque = 40.1;

SELECT Tool_wear AS median_Tool_wear
FROM (
    SELECT Tool_wear, ROW_NUMBER() OVER (ORDER BY Tool_wear) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM machine_failure
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

#  median_Tool_wear = 108;

#Mode 
SELECT type AS type
FROM (
    SELECT type, COUNT(*) AS frequency
    FROM machine_failure
    GROUP BY type
    ORDER BY frequency DESC
    LIMIT 1
) AS subquery;

# Mode type = L #
#from above mode value we can say that 'L' type of vehical is prefered most.


#inferences
# In air_temperature,Process_temperature both mean and median values are nearly same so we can say that the data is normally distributed,having no outliers.
# as per mean and median values for Rotational_speed mean value is greater than median(mean > median)so we can say that Rotational_speed is positievely skewed having outliers.
#for Torque and Tool_wear,mean and median values are nearly same so as per condition data is normally distributed having no outliers in data.
												
                                                
                                                
                                                # Second Moment Business Decision/Measures of Dispersion
										
                                        
																# Variance
                                                                
SELECT VARIANCE(air_temperature) AS air_temperature_variance
FROM machine_failure;

# air_temperature_variance = 4.0006346951017715;    #  mean = 300.00492999999875;  


SELECT VARIANCE(Process_temperature) AS Process_temperature_variance
FROM machine_failure;

#Process_temperature_variance =2.2012470863997957    ##  mean = 310.00555999999995;

SELECT VARIANCE(Rotational_speed) AS Rotational_speed_variance
FROM machine_failure;

#Rotational_speed_variance = 32139.5728;	# mean =1538.7761;

SELECT VARIANCE(Torque) AS Torque_variance
FROM machine_failure;

#Torque_variance =99.36970199660486; #mean = 39.98690999906063;

SELECT VARIANCE(Tool_wear) AS Tool_variance
FROM machine_failure;

#Tool_variance = 4051.4452;   #mean = 107.9510;



SELECT STDDEV(Air_temperature) AS Air_stddev
FROM machine_failure;

#Air_stddev = 2.0001586674816005;

SELECT 
		STDDEV(Process_temperature) AS Process_stddev,
        STDDEV(Rotational_speed) AS Process_stddev,
        STDDEV(Torque) AS Torque_stddev,
        STDDEV(Tool_wear) AS Tool_stddev
FROM machine_failure;

# Process_stddev =1.4836600305999335
# Process_stddev =179.2751
# Torque_stddev =9.968435283263108
# Tool_stddev =63.6510
 
 #inference
 #in process temperature,air temperature and torque according to values points are clustered around the mean value of them.
 #for rotational_speed and tool_wear standard deviaton values are high so data is scattered and far from mean 

#Range#

SELECT 
		MAX(Air_temperature) - MIN(Air_temperature) AS Air_temperature_range,
		MAX(Process_temperature) - MIN(Process_temperature) AS Process_temperature_range,
		MAX(Rotational_speed) - MIN(Rotational_speed) AS Rotational_speed_range,
		MAX(Torque) - MIN(Torque) AS Torque_speed_range,
		MAX(Tool_wear) - MIN(Tool_wear) AS Tool_wear_range
FROM Process_temperature;

#inferences
#

# Air_temperature_range = 9.199999999999989
# Process_temperature_range = 8.100000000000023
# Rotational_speed_range = 1718
# Torque_speed_range = 72.79999852180481
# Tool_wear_range = 253


							# Third and Fourth Moment Business Decision
-- skewness and kurtosis 

SELECT
    (
        SUM(POWER(Air_temperature - (SELECT AVG(Air_temperature) FROM machine_failure), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Air_temperature) FROM  machine_failure), 3))
    ) AS skewness,
	(
        (SUM(POWER(Air_temperature - (SELECT AVG(Air_temperature) FROM machine_failure), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Air_temperature) FROM machine_failure), 4))) - 3
    ) AS kurtosis
FROM machine_failure;

# Skewness_ Air_temperature =0.1142567787209932
# Kurtosis_ Air_temperature =-0.8361436902620034

SELECT
    (
        SUM(POWER(Process_temperature - (SELECT AVG(Process_temperature) FROM machine_failure), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Process_temperature) FROM  machine_failure), 3))
    ) AS skewness,
	(
        (SUM(POWER(Air_temperature - (SELECT AVG(Process_temperature) FROM machine_failure), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Process_temperature) FROM machine_failure), 4))) - 3
    ) AS kurtosis
FROM machine_failure;

# Skewness_ Process_temperature = 0.015025013585269066
# Kurtosis_ Process_temperature = 2556.3420402392867

SELECT
    (
        SUM(POWER(Rotational_speed - (SELECT AVG(Rotational_speed) FROM machine_failure), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Rotational_speed) FROM  machine_failure), 3))
    ) AS skewness,
	(
        (SUM(POWER(Rotational_speed - (SELECT AVG(Rotational_speed) FROM machine_failure), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Rotational_speed) FROM machine_failure), 4))) - 3
    ) AS kurtosis
FROM machine_failure;

# Skewness_ Rotational_speed = 1.9928720166048368
# Kurtosis_ Rotational_speed = 7.388649004260019



SELECT
    (
        SUM(POWER(Torque - (SELECT AVG(Torque) FROM machine_failure), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Torque) FROM  machine_failure), 3))
    ) AS skewness,
	(
        (SUM(POWER(Torque - (SELECT AVG(Torque) FROM machine_failure), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Torque) FROM machine_failure), 4))) - 3
    ) AS kurtosis
FROM machine_failure;

# Skewness_ Torque = -0.009515170189557984
# Kurtosis_Torque =-0.013833933344572724

SELECT
    (
        SUM(POWER(Tool_wear - (SELECT AVG(Tool_wear) FROM machine_failure), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Tool_wear) FROM  machine_failure), 3))
    ) AS skewness,
	(
        (SUM(POWER(Tool_wear - (SELECT AVG(Tool_wear) FROM machine_failure), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Tool_wear) FROM machine_failure), 4))) - 3
    ) AS kurtosis
FROM machine_failure;

# Skewness_ Tool_wear = 0.027288145044007204
# Kurtosis_Tool_wear = -1.166753784684022

#inference
#We can say that in air_tepperature,process_temperature,tool_wear columns data are  normally distributed because values are nerly close to zero.
#For rotational_speed the data is positively skeweed and tails are present on right side.
#In Torque skew value is negative so it is negatively skeweed and tail is present on left side. 




