SELECT 
    categoryid as category_id,
    categoryname as category_name,
    description,
    current_timestamp as ingestion_timestamp

    FROM  {{source('bronze','categories')}}