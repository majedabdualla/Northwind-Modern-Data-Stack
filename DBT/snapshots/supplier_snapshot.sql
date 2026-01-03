{% snapshot supplier_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='supplier_id',
      strategy='timestamp',
      updated_at='ingestion_timestamp',
      invalidate_hard_deletes=True
    )
}}

select * from {{ ref('suppliers') }}

{% endsnapshot %}