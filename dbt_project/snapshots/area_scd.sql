-- models/snapshots/customer_scd.sql
{% snapshot area_scd %}

    {{
        config(
            target_schema='snapshots',
            strategy='check',
            unique_key='area_code',
            check_cols=['area_name'],
            invalidate_hard_deletes=True
        )
    }}

    SELECT 
        area_code,
        area_name
    FROM {{ ref('dimarea') }}

{% endsnapshot %}