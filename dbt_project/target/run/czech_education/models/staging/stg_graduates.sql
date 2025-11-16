
  
    

    create table "iceberg"."testnamespace"."stg_graduates__dbt_tmp"
      
      
    as (
      SELECT
    university_name,
    area_code,
    CAST(absolvents_count AS INTEGER) AS graduate_count,
    study_program_name,
    area_name
FROM iceberg.testnamespace.graduatesview
    );

  