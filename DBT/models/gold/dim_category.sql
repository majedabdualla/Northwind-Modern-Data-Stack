{{ 
    config(
        materialized='incremental',
        unique_key='category_sk',
        incremental_strategy='merge'
    ) 
}}

select 
     row_number() over(order by category_id) as category_sk,
     
     category_id,
     description,
     ingestion_timestamp
     
from  {{ ref('categories') }} 

