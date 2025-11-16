-- models/dim/dim_product_history.sql
SELECT 
    area_code,
    area_name,
    dbt_valid_from as effective_date,
    dbt_valid_to as expiry_date,
    CASE 
        WHEN dbt_valid_to IS NULL THEN 1 
        ELSE 0 
    END as is_current
FROM {{ ref('area_scd') }}
ORDER BY   area_code , effective_date