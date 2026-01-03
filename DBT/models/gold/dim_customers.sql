{{ 
    config(
        materialized='incremental',
        unique_key='customer_sk',
        incremental_strategy='merge'
    ) 
}}

select
    row_number() over(order by customer_id) as customer_sk,
    customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    postalcode,
    country,
    phone,
    fax,
    ingestion_timestamp
from {{ ref('customers') }} 

