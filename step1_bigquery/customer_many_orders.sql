#RESULT: There are 10910 customers who placed >50 orders
WITH customer_many_orders AS (SELECT user_id, COUNT(order_id) n_orders
    FROM `valkyrie-interview.valkyrie.orders`
    GROUP BY user_id
    HAVING n_orders > 60)

#Find orders submitted by customers who placed > 50 orders
#RESULT: 518,528 orders submitted by customer who places many orders
SELECT order_id, user_id
FROM `valkyrie-interview.valkyrie.orders` o
WHERE eval_set = "prior"
AND user_id IN (SELECT user_id
                  FROM customer_many_orders)