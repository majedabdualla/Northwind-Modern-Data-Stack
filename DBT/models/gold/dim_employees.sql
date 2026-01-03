

{{ 
    config(
        materialized='incremental',
        unique_key='employee_sk',
        incremental_strategy='merge'
    ) 
}}

with employees as (
    select * from {{ ref('employee_snapshot') }}
)


select
        row_number() over (order by e.emp_id)  as employee_sk,
        e.emp_id as employee_id,
        e.firstname as first_name,
        e.lastname as last_name,
        e.firstname || ' ' || e.lastname as full_name,
        e.titleofcourtesy as title_of_courtesy,
        
        -- Job Information
        e.title,
        e.hiredate as hire_date,
         coalesce(e.reportsto,0) as supervisor_id,
    
        date_part('year', current_date) - date_part('year', e.birthdate) as age,
        date_part('year', current_date) - date_part('year', e.hiredate) as years_of_service,
        
        -- Contact Information
        e.address,
        e.city,
         e.region as region,
        e.postalcode as postal_code,
        e.country,
        e.homephone as home_phone,
        e.extension,
        e.dbt_valid_from as valid_from_date,
        e.dbt_valid_to as valid_to_date,
        case 
            when e.dbt_valid_to is null then true 
            else false 
        end as is_current_record,
        
        -- Metadata
        e.ingestion_timestamp
from employees e
     





