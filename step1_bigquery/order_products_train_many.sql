#For each order submitted by customers_many_orders, group all items from basket
# into a list via ARRAY_AGG
WITH customer_many_orders AS (SELECT user_id, COUNT(order_id) n_orders
    FROM `valkyrie-interview.valkyrie.orders`
    GROUP BY user_id
    HAVING n_orders > 20
    ),

#Find orders submitted by customers who placed > k orders
#RESULT: when k = 20, there are 32365 orders
orders_from_customer_many_orders AS (SELECT order_id, user_id
    FROM `valkyrie-interview.valkyrie.orders` o
    WHERE eval_set = "train"
    AND user_id IN (SELECT user_id
                    FROM customer_many_orders)
    )

#Create a dataset of user, order_id, and basket_content - i.e. a list of products for said order
#RESULT: when k = 20, there are 363,553 order_products
SELECT order_id, ARRAY_AGG(product_id) basket_content
FROM `valkyrie-interview.valkyrie.order_products_train` o_products_train
WHERE EXISTS (SELECT 1
              FROM orders_from_customer_many_orders o
              WHERE o_products_train.order_id = o.order_id)
GROUP BY order_id
