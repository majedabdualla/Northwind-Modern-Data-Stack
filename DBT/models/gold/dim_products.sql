
select
    row_number() over(order by product_id) as product_sk,
    c.category_sk,
    sup.supplier_id ,
    c.category_id as category_id,
    p.product_id,
    p.product_name,
    p.quantity_perunit,
    p.unitprice,
    p.unitsinstock,
    p.unitsonorder,
    p.reorder_level,
    case 
            when p.unitsinstock = 0 then true 
            else false 
        end as is_out_of_stock,
        
        case 
            when p.unitsinstock <= p.reorder_level then true 
            else false 
        end as needs_reorder,
        
        -- SCD Type 2 Columns
        p.dbt_valid_from as valid_from_date,
        p.dbt_valid_to as valid_to_date,
        case 
            when p.dbt_valid_to is null then true 
            else false 
        end as is_current_record,
        
        -- Metadata
        p.ingestion_timestamp

from {{ ref('product_snapshot') }} p 
left join {{ ref('dim_category') }} c 
on p.category_id=c.category_id 
left join {{ ref('dim_suppliers') }} sup 
on p.supplier_id=sup.supplier_id



