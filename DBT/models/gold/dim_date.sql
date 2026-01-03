{{ config(materialized='table') }}

with dates as (
    select
        d::date as date_day,
        to_char(d, 'YYYYMMDD')::integer as date_key,
        extract(year from d) as year,
        extract(quarter from d) as quarter,
        extract(month from d) as month,
        to_char(d, 'Month') as month_name,
        to_char(d, 'MM-YYYY') as month_year,
        extract(week from d) as week_of_year,
        extract(doy from d) as day_of_year,
        to_char(d, 'Day') as day_name,
        case when extract(isodow from d) in (6, 7) then true else false end as is_weekend,
        case when extract(year from d) = extract(year from current_date) then true else false end as is_current_year
    from generate_series(
        '1996-01-01'::date,
        '1998-12-31'::date,
        '1 day'::interval
    ) as d
)

select * from dates