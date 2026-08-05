
USE blinkit_db

-- ===> GROSS MERCHANDISE VALUE (GMV) GROWTH RATE:

SELECT SUM(order_total) AS Total_revenue, 
       MONTH(order_date) as Month,
       LAG(SUM(order_total))OVER (ORDER BY MONTH(order_date)) AS prev_mnth_revenue,
       ROUND(SUM(order_total)-LAG(SUM(order_total))OVER (ORDER BY MONTH(order_date)),2) as Revenue_growth,
       ROUND((SUM(order_total)-LAG(SUM(order_total))OVER (ORDER BY MONTH(order_date)))*100.0/(LAG(SUM(order_total)) OVER (ORDER BY MONTH(order_date))),2) AS  MoM_growth_percentage

FROM orders
GROUP BY  MONTH(order_date)
ORDER BY MONTH(order_date) ASC;


-----which categories contributed the loss in revenue       1st why??---due to all categories

select p.category,
       sum(o.order_total)as sm,
       Month(o.order_date) as mnth,
       LAG(sum(o.order_total)) over(Partition BY category Order by Month(o.order_date)) as prev_rev,
       ROUND(CAST((sum(o.order_total)-LAG(sum(o.order_total)) over(Partition BY category Order by Month(o.order_date)))*100.0/LAG(sum(o.order_total)) over(Partition BY category Order by Month(o.order_date)) AS FLOAT),2) as growth
FROM products as p
JOIN order_items as oi
     ON p.product_id=oi.product_id
JOIN orders as o
     ON oi.order_id=o.order_id
WHERE Month(o.order_date) IN (9,10,11)
GROUP BY p.category,
         Month(o.order_date)
ORDER BY p.category ;




----__CATEGORIES WHICH CONTRIBUTED TO THE LOSS OF REVENUES AND THEIR LOSS PERCENT AS COMPARED TO THE LAST MONTH

select sub.category,
sub.growth from(
               select p.category,
               sum(o.order_total)as sm,
               Month(o.order_date) as mnth,
               LAG(sum(o.order_total)) over(Partition BY category Order by Month(o.order_date)) as prev_rev,
               (sum(o.order_total)-LAG(sum(o.order_total)) over(Partition BY category Order by Month(o.order_date)))*100.0/LAG(sum(o.order_total)) over(Partition BY category Order by Month(o.order_date)) as growth
FROM products as p
JOIN order_items as oi
     ON p.product_id=oi.product_id
JOIN orders as o
     ON oi.order_id=o.order_id
GROUP BY p.category,
         Month(o.order_date)
) as sub
WHERE sub.growth<0 and sub.mnth=11           -------- filter month and negative growth


---Checking the drop of order in 11th month.                 2nd Why??---due to lower in orders 

select count(order_id) as order_cnt,
       month(order_date) as mnth
from orders
GROUP BY month(order_date)
ORDER BY mnth ASC
       

----CITIES which have drop in orders in 11th month as compared to the previous month
select c.area,
COUNT(CASE WHEN MONTH(o.order_date)= 10 THEN o.order_id END ) as [10th_mnth],
COUNT(CASE WHEN MONTH(o.order_date)=11 THEN o.order_id END ) as [11th_mnth],
COUNT(CASE WHEN MONTH(o.order_date)= 10 THEN o.order_id END ) - COUNT(CASE WHEN MONTH(o.order_date)=11 THEN o.order_id END ) as diff_count
from orders as o
JOIN customers as c
ON o.customer_id=c.customer_id
GROUP BY c.area
HAVING COUNT(CASE WHEN MONTH(o.order_date)= 10 THEN o.order_id END ) - COUNT(CASE WHEN MONTH(o.order_date)=11 THEN o.order_id END )>0
ORDER BY diff_count DESC;






