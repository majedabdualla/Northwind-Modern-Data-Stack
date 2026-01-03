 SELECT
    customerid as customer_id,
    companyname as company_name,
    contactname as contact_name,
    contacttitle as contact_title,
    address,
    city,
    country ,
    postalcode,
    phone,
    fax,
    current_timestamp as ingestion_timestamp
    FROM  {{source('bronze','customers')}}