
select 
     orderid as order_id,
    customerid as customer_id,
    employeeid as emp_id,
    orderdate as order_date,
    requireddate as required_date,
    shippeddate as shipped_date,
    shipvia ,
    freight,
    shipname,
    shipaddress as ship_address,
    shipcity as ship_city,
     shippostalcode as ship_postalcode,
    shipcountry as ship_country ,
    current_timestamp as ingestion_timestamp

FROM  {{source('bronze','orders')}}              

