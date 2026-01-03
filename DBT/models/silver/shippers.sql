select 


    shipperid as shipper_id ,
    companyname as company_name,
    phone,
    current_timestamp as ingestion_timestamp




FROM  {{source('bronze','shippers')}}       