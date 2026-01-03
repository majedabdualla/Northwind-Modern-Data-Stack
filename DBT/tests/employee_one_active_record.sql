select emp_id
from {{ ref('employee_snapshot') }}
where dbt_valid_to is null
group by emp_id
having count(*) > 1
