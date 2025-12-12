SELECT
    nazev_vysoke_skoly university_name,
    kod_studijniho_oboru area_code,
    CAST(pocet_absolventu_v_ramci_kralovehradeckeho_kraje_za_rok_2022 AS INTEGER) AS graduate_count,
    nazev_studijniho_oboru study_program_name,
    nazev_okresu area_name
FROM iceberg.edustack.graduates