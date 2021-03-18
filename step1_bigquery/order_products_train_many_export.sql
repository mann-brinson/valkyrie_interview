#Export the order_products_train_many to Google Cloud Storage
EXPORT DATA OPTIONS(
  uri='gs://valkyrie-instacart-data/query_results/order_products_train_many*.json',
  format='JSON',
  overwrite=True
  ) AS
SELECT *
FROM `valkyrie-interview.valkyrie.order_products_train_many` o_products_train
