
with orders as (
    select * from {{ ref('orders') }}
),

order_details as (
    select * from {{ ref('orderdetails') }}
)

select
    row_number() over(order by o.order_id ) as order_fact_sk,

    -- Dimension Keys
    c.customer_sk,
    e.employee_sk,
    p.product_sk,
    s.shipper_sk,
    sup.supplier_sk supplier_sk ,
    ca.category_sk,
     d_order.date_key    as order_date_key,
    d_required.date_key as required_date_key,
    d_shipped.date_key  as shipped_date_key,


    -- Degenerate dimensions
    o.order_id,
    o.order_date,
    o.required_date,
    o.shipped_date,
    -- Measures
    od.quantity,
    od.unitprice as unit_price,
    od.discount,
    (od.quantity * od.unitprice * (1 - od.discount)) as line_total,
    o.freight

from orders o
join order_details od 
    on o.order_id = od.order_id

left join {{ ref('dim_customers') }} c
    on o.customer_id = c.customer_id

left join {{ ref('dim_employees') }} e
    on o.emp_id = e.employee_id
    and e.is_current_record = true

left join {{ ref('dim_products') }} p
    on od.product_id = p.product_id
    and p.is_current_record = true

left join {{ ref('dim_shippers') }} s
    on o.shipvia = s.shipper_id

left join {{ ref('dim_category') }} ca
    on p.category_id = ca.category_id

left join {{ ref('dim_suppliers') }} sup 
on p.supplier_id=sup.supplier_id 

left join {{ ref('dim_date') }} d_order
    on o.order_date = d_order.date_day

left join {{ ref('dim_date') }} d_required
    on o.required_date = d_required.date_day

left join {{ ref('dim_date') }} d_shipped
    on o.shipped_date = d_shipped.date_day