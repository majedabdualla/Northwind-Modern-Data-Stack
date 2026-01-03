select *
from {{ ref('fact_orders') }}
where customer_sk is null
   or product_sk is null
   or employee_sk is null
