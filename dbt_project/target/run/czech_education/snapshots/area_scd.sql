
      
  
    

    create table "iceberg"."snapshots"."area_scd"
      
      
    as (
      
    

    select *,
        lower(to_hex(md5(to_utf8(concat(coalesce(cast(area_code as varchar), ''), '|',coalesce(cast(
    current_timestamp
 as varchar), '')))))) as dbt_scd_id,
        
    current_timestamp
 as dbt_updated_at,
        
    current_timestamp
 as dbt_valid_from,
        
  
  coalesce(nullif(
    current_timestamp
, 
    current_timestamp
), null)
  as dbt_valid_to
from (
        

    

    SELECT 
        area_code,
        area_name
    FROM "iceberg"."testnamespace"."dimarea"

    ) sbq



    );

  
  