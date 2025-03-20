SELECT * FROM supershop.pizza_sale_3;
-- Data cleaning
#standard data format
SELECT order_date FROM pizza_sale_3 LIMIT 10;
UPDATE pizza_sale_3
SET order_date = STR_TO_DATE(order_date, '%m/%d/%Y');
ALTER TABLE pizza_sale_3
MODIFY COLUMN order_date DATE;
SELECT order_date FROM pizza_sale_3 LIMIT 10;
#Remove duplicate values
DELETE FROM pizza_sale_3
WHERE pizza_id NOT IN (
    SELECT MIN(pizza_id)
    FROM pizza_sale_3
    GROUP BY order_id, pizza_name_id, order_date, order_time
);
#Handeling missing or null value if there any
UPDATE pizza_sale_3
SET pizza_ingredients = 'Unknown'
WHERE pizza_ingredients IS NULL OR pizza_ingredients = '';
-- Data analysis
#Total revenue
SELECT pizza_category, SUM(total_price) AS total_revenue
FROM pizza_sale_3
GROUP BY pizza_category
ORDER BY total_revenue DESC;
#Most popular pizza by quantity sold
SELECT pizza_name, SUM(quantity) AS total_sold
FROM pizza_sale_3
GROUP BY pizza_name
ORDER BY total_sold DESC
LIMIT 5;
#Sales trend over time
SELECT order_date AS order_day, SUM(total_price) AS daily_sales
FROM pizza_sale_3
GROUP BY order_day
ORDER BY order_day;
#AVERAGE ORDER values
SELECT AVG(total_price) AS avg_order_value
FROM (
    SELECT order_id, SUM(total_price) AS total_price
    FROM pizza_sale_3
    GROUP BY order_id
) AS order_totals;
-- RFM SEGMENTATION 
CREATE OR REPLACE VIEW RFMS AS 
WITH RFM AS
(SELECT ORDER_ID ,
DATEDIFF((SELECT MAX(str_to_date(Order_date,'%d/%m/%y')) FROM PIZZA_SALE_3),
MAX(str_to_date(Order_date,'%d/%m/%y'))) AS RECENCY_VALUE,
COUNT(DISTINCT order_date) AS FREQUENCY,
SUM(TOTAL_PRICE) AS M_VALUE
FROM PIZZA_SALE_3
GROUP BY ORDER_ID),
RFM_SCORE AS 
(SELECT 
S.*,
NTILE(5) OVER(ORDER BY RECENCY_VALUE DESC) AS R_SCORE,
NTILE(5) OVER(ORDER BY FREQUENCY DESC) AS F_SCORE,
NTILE(5) OVER(ORDER BY M_VALUE DESC) AS M_SCORE
FROM RFM AS S),
RFM_COMBINATION AS 
(
SELECT 
R.*,
(R_SCORE +F_SCORE+M_SCORE) AS TOTAL_RFM_SCORE,
CONCAT_WS('',R_SCORE,F_SCORE,M_SCORE)AS RFM_COMBINATION
FROM RFM_SCORE AS R)
SELECT 
RC.*, 
CASE 
WHEN RFM_COMBINATION IN( 411,521) THEN 'CHAMPION'
WHEN RFM_COMBINATION IN( 131,241) THEN 'LOYAL CUSTOMER'
END AS CUSTOMER_SEGMENT
FROM RFM_COMBINATION AS RC;
SELECT * FROM RFMS

# SUMMARY
SELECT CUSTOMER_SEGMENT,
AVG(M_VALUE) AS AVERAGE_M_VALUE
FROM RFMS
GROUP BY 1
ORDER BY 2;
SELECT CUSTOMER_SEGMENT,
SUM(UNIT_PRICE) AS TOTAL_PRICE
FROM PIZZA_SALE_3 AS S
LEFT JOIN RFMS AS R ON S.ORDER_ID=R.ORDER_ID
GROUP BY 1
ORDER BY 2 DESC;
