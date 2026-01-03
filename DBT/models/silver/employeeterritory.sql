   SELECT
            employeeid AS emp_id ,
            territoryid as territory_id,
            current_timestamp as ingestion_timestamp

    FROM  {{source('bronze','employeeterritories')}}