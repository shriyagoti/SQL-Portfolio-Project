# Introduction

This project aims at analyzing the Plato Pizza store sales Data obtained from Maven Analytics official website and provide recommended insights as to what can be improved at the pizza store. 


# DataSet

The data is obtained from Maven Analytics and consists of 4 tables namely, order_details, orders, pizzas, pizza_types which includes the date and time of each order and the pizzas served, with additional details on the type, size, quantity, price, and ingredients.


# Skills and Tools Used

SQL, Descriptive Statistics, Microsoft SQL Server to perform analysis.


# Loading Data into Database

Loaded the data in the flat files into the Database using Microsoft SQL Server as shown below.

## Step 1: 

![Alt text]("https://github.com/shriyagoti/SQL-Portfolio-Project/blob/main/PlatoPizzaAnalysisSQL/assets/LoadingData.png")

## Step 2:

![Alt text]("https://github.com/shriyagoti/SQL-Portfolio-Project/blob/main/PlatoPizzaAnalysisSQL/assets/AvgOrder.png")

# Analysis Questions 

## How much did an average pizza order cost?

### Query: 

WITH AvgOrderValue AS (SELECT  order_details.order_id, SUM(pizzas.price) AS order_value
	  FROM order_details JOIN pizzas ON order_details.pizza_id=pizzas.pizza_id
	  GROUP BY order_id)

SELECT Concat('$',ROUND(SUM(order_value)/COUNT(order_id),0)) AS avg_order_value
FROM AvgOrderValue;

### Output:

![Alt text](url "AvgOrder.png")



## How much revenue did each pizza size generate?

### Query:

WITH RevenueBySize AS (SELECT size, Concat('$',ROUND(SUM(price*quantity),0)) as Revenue
FROM order_details JOIN pizzas ON order_details.pizza_id=pizzas.pizza_id
GROUP BY size)

SELECT *
from RevenueBySize
Order By Revenue DESC

### Output:

![Alt text](url "RevenueBySize.png")



## Peak Hours in a day?

### Query:

SELECT TOP 2 CASE
   WHEN DATEPART(HOUR, [time])< 12 THEN CONCAT(CONVERT(varchar,DATEPART(HOUR, [time])), ' AM')
   WHEN DATEPART(HOUR, [time]) = 12 AND DATEPART(HOUR, [time]) % 12 = 0  THEN CONCAT(CONVERT(varchar,DATEPART(HOUR, [time])), ' PM')
   ELSE CONCAT(CONVERT(varchar,DATEPART(HOUR, [time])-12), ' PM')
   END,
   ROUND((COUNT(order_id)/15),1) as TotalOrders
FROM orders
GROUP BY DATEPART(HOUR, [time])
ORDER by TotalOrders DESC

### Output:

![Alt text](url "PeakHour.png")



