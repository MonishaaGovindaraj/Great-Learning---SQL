7
select CARTON_ID,(len*width*height) AS CARTON_VOLUME FROM carton HAVING CARTON_VOLUME > ((SELECT SUM((a.PRODUCT_QUANTITY*b.len*b.width*b.height)) as TOTAL_VOLUME
FROM order_items AS a JOIN product AS b ON a.product_id=b.product_id where ORDER_ID=10006)) ORDER BY CARTON_VOLUME LIMIT 1
-----------------------
8
SELECT a.CUSTOMER_ID,a.CUSTOMER_FNAME,b.ORDER_ID,SUM(c.PRODUCT_QUANTITY) as PRODUCT_QUANTITY
FROM online_customer as a JOIN order_header as b on a.CUSTOMER_ID=b.CUSTOMER_ID JOIN order_items as c ON b.order_id=c.order_id
WHERE b.order_status='Shipped' AND b.order_id IN (SELECT ORDER_ID FROM order_items GROUP BY ORDER_ID HAVING SUM(PRODUCT_QUANTITY)>10) GROUP BY ORDER_ID 
------------------------
9
SELECT a.ORDER_ID, b.CUSTOMER_ID, b.CUSTOMER_FNAME,SUM(c.PRODUCT_QUANTITY) AS TOTAL_QUANTITY_OF_PRODUCTS
from order_header as a JOIN online_customer as b
on a.customer_id=b.customer_id 
LEFT JOIN order_items as c on a.order_id=c.order_id where a.ORDER_ID>10060 and a.order_status='Shipped' GROUP BY a.ORDER_ID;
-------------------------
10
Select c.PRODUCT_CLASS_DESC,sum(PRODUCT_QUANTITY) as TOTAL_QUANTITY ,sum(b.PRODUCT_PRICE*a.PRODUCT_QUANTITY) as TOTAL_VALUE
FROM order_items as a JOIN product as b on a.product_id = b.product_id 
JOIN product_class as c ON b.PRODUCT_CLASS_CODE = c.PRODUCT_CLASS_CODE 
JOIN order_header as d ON a.ORDER_ID=d.ORDER_ID
JOIN online_customer as e ON d.CUSTOMER_ID=e.CUSTOMER_ID
JOIN address as f ON e.ADDRESS_ID=f.ADDRESS_ID
WHERE COUNTRY NOT IN ('India','USA')
GROUP BY PRODUCT_CLASS_DESC
ORDER BY Total_Quantity DESC
LIMIT 1;