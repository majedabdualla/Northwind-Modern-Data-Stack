    select    
        supplierid as supplier_id,
        companyname as company_name,
        contactname as contact_name,
        contacttitle as contact_title,
        address ,
        city,
        postalcode,
        country,
        fax ,
        current_timestamp as ingestion_timestamp
        
     FROM  {{source('bronze','suppliers')}}                