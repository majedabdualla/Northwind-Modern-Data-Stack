
select 
            territoryid as territory_id,
            territorydescription as territory_description,
            regionid as region_id ,
            current_timestamp as ingestion_timestamp

    FROM  {{source('bronze','territories')}}