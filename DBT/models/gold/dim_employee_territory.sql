{{ 
    config(
        materialized='table'
    ) 
}}

select
    e.employee_sk,
    t.territory_sk
from {{ ref('dim_employees') }} e
join {{ ref('employeeterritory') }} et
    on e.employee_id = et.emp_id
join {{ ref('dim_territory') }} t
    on et.territory_id = t.territory_id
