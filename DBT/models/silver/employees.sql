
SELECT 
          employeeid AS emp_id,
            lastname,
            firstname,
            title,
            titleofcourtesy,
            birthdate,
            hiredate,
            address,
            city,
            region,
            postalcode,
            country,
            homephone,
            extension,
            notes,
            reportsto,
            current_timestamp as ingestion_timestamp
            



    FROM  {{source('bronze','employees')}}