
# How much did an average pizza order cost?

## Query: 

WITH AvgOrderValue AS (SELECT  order_details.order_id, SUM(pizzas.price) AS order_value
	  FROM order_details JOIN pizzas ON order_details.pizza_id=pizzas.pizza_id
	  GROUP BY order_id)

SELECT Concat('$',ROUND(SUM(order_value)/COUNT(order_id),0)) AS avg_order_value
FROM AvgOrderValue;

## Output:

![Alt text](url "AvgOrder")



# How much revenue did each pizza size generate?

## Query:

WITH RevenueBySize AS (SELECT size, Concat('$',ROUND(SUM(price*quantity),0)) as Revenue
FROM order_details JOIN pizzas ON order_details.pizza_id=pizzas.pizza_id
GROUP BY size)

SELECT *
from RevenueBySize
Order By Revenue DESC

## Output:

![Alt text](url "RevenueBySize")



# Peak Hours in a day?

## Query:

SELECT TOP 2 CASE
   WHEN DATEPART(HOUR, [time])< 12 THEN CONCAT(CONVERT(varchar,DATEPART(HOUR, [time])), ' AM')
   WHEN DATEPART(HOUR, [time]) = 12 AND DATEPART(HOUR, [time]) % 12 = 0  THEN CONCAT(CONVERT(varchar,DATEPART(HOUR, [time])), ' PM')
   ELSE CONCAT(CONVERT(varchar,DATEPART(HOUR, [time])-12), ' PM')
   END,
   ROUND((COUNT(order_id)/15),1) as TotalOrders
FROM orders
GROUP BY DATEPART(HOUR, [time])
ORDER by TotalOrders DESC

## Output:

![Alt text](url "PeakHour")



