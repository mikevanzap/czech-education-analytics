WITH grads_by_region AS (
    SELECT
        area_code,
        university_name,
        SUM(graduate_count) AS total_graduates,
        COUNT(DISTINCT study_program_name) AS num_fields
    FROM {{ ref('stg_graduates') }}
    GROUP BY 1,2
),
institutions_by_region AS (
    SELECT
        --region_code,
        university_name,
        COUNT(*) AS institution_count
    FROM {{ ref('stg_institutions') }}
    GROUP BY 1 
)

SELECT
    g.area_code region_code,
    i.institution_count,
    g.total_graduates,
    g.num_fields,
    -- Add population later if available
    CURRENT_TIMESTAMP AS dbt_updated_at
FROM institutions_by_region i
LEFT JOIN grads_by_region g ON g.university_name=i.university_name