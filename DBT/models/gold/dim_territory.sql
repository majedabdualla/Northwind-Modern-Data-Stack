{{ 
    config(
        materialized='incremental',
        unique_key='territory_sk',
        incremental_strategy='merge'
    ) 
}}

with territory as (
    select * from {{ ref('territories') }}
), 

region as (
    select * from {{ ref('region') }}
), 

final as (

    select 
     abs(('x'||md5(territory_id::text ))::bit(64)::bigint) as territory_sk,
    t.territory_id , 
    t.territory_description,
    t.region_id,
    t.ingestion_timestamp,
    r.region_description
    from territory t 
    left join region r 
    on t.region_id=r.region_id

)

select * from final