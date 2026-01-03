     select      
            productid as product_id,
            productname as product_name,
            supplierid as supplier_id,
            categoryid as category_id,
            quantityperunit as quantity_perunit,
            unitprice,
            unitsinstock,
            unitsonorder,
            reorderlevel  as reorder_level,
            current_timestamp as ingestion_timestamp
            
      FROM  {{source('bronze','products')}}       