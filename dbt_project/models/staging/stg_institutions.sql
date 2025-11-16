SELECT
    nazev_zar AS institution_name,
    nazev_vs AS university_name,
    druh_vs AS institution_type,
    X, Y
    -- Derive region_code from coordinates (simplified)
    --CASE
    --    WHEN X BETWEEN 1600000 AND 1610000 AND Y BETWEEN 6460000 AND 6470000 THEN 'CZ010'  -- Prague
    --    WHEN X BETWEEN 1590000 AND 1600000 AND Y BETWEEN 6450000 AND 6460000 THEN 'CZ052'  -- Hradec
     --   ELSE 'OTHER'
    --END AS region_code
FROM sqlserver.dbo.institutions