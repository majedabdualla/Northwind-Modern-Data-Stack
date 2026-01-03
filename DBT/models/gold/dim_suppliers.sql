{{ 
    config(
        materialized='incremental',
        unique_key='supplier_sk',
        incremental_strategy='merge'
    ) 
}}

select
    row_number() over(order by supplier_id) as supplier_sk,
    supplier_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    postalcode,
    country,
    fax,
    dbt_valid_from as valid_from_date,
    dbt_valid_to as valid_to_date,
    case 
        when dbt_valid_to is null then true 
        else false 
    end as is_current_record
from {{ ref('supplier_snapshot') }}
