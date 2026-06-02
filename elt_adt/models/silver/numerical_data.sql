with plt_cleaned as (
    select id, CAST(replace("OO", PLT, "00") as numeric) as PLT
    from (
        select index as id, replace(",", PLT, ".") as PLT
        from {{ source("etl_adt", "bronze_data") }}
    )
),
hb_cleaned as (
    select
        index as id,
        CAST(replace(",", HB, ".") as numeric) as HB,
        PLT
    from {{ source("etl_adt", "bronze_data") }} as src
    inner join plt_cleaned as pc
    on src.index = pc.id
),
other_numerical_fields as (
    select
        index as id,
        Edad,
        Frecuencia respiratoria,
        WBC,
        Saturación de la sangre,
        Frecuencia cardíaca,
        Presión sistólica,
        Presión diastólica
    from {{ source("etl_adt", "bronze_data") }}
)

select
    hc.index as id,
    Edad,
    Frecuencia respiratoria,
    WBC,
    Saturación de la sangre,
    Frecuencia cardíaca,
    Presión sistólica,
    Presión diastólica,
    HB,
    PLT
from hb_cleaned as hc
inner join other_numerical_fields as onf
on hc.id = onf.id