
select 

        regionid as region_id,
        regiondescription  as region_description,
        current_timestamp as ingestion_timestamp

FROM  {{source('bronze','region')}}