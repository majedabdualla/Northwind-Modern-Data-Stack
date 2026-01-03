{% snapshot employee_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='emp_id',
      strategy='timestamp',
      updated_at='ingestion_timestamp',
      invalidate_hard_deletes=True
    )
}}

select * from {{ ref('employees') }}

{% endsnapshot %}