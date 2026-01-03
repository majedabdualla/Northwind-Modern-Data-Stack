{{ 
    config(
        materialized='incremental',
        unique_key='shipper_sk',
        incremental_strategy='merge'
    ) 
}}

select
    row_number() over(order by shipper_id) as shipper_sk,
    shipper_id,
    company_name,
    phone,
    ingestion_timestamp
from {{ ref('shippers') }}
