
  
    

    create table "iceberg"."testnamespace"."dimarea__dbt_tmp"
      
      
    as (
      


    SELECT 
        area_code,
        area_name
    FROM "iceberg"."testnamespace"."stg_graduates"
    );

  