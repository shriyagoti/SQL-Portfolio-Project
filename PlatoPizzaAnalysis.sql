
# Find the Average price per order of value of pizzas

WITH OrderValue AS (SELECT  order_details.order_id, SUM(pizzas.price) AS order_value
	  FROM order_details JOIN pizzas ON order_details.pizza_id=pizzas.pizza_id
	  GROUP BY order_id)

SELECT ROUND(SUM(order_value)/COUNT(order_id),0) AS avg_order_value
FROM OrderValue

