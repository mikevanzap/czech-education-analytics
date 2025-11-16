{{ config(
    materialized='table',
   
) }}


    SELECT 
        area_code,
        area_name
    FROM {{ ref('stg_graduates') }}

 