with hematologica_cleaned as (
    select (
            {{ transform_bool("Hematologica", "bronze_data") }}
        ) as Hematologica,
        index as id
    from {{ source("etl_adt", "bronze_data") }}
),
cardiaca_cleaned as (
    select (
            {{ transform_bool("Cardíaca", "bronze_data") }}
        ) as Cardíaca,
        index as id,
        Hematologica
    from {{ source("etl_adt", "bronze_data") }}
    inner join hematologica_cleaned as h
    on h.id = index
),
endocrina_cleaned as (
    select (
            {{ transform_bool("Endocrina", "bronze_data") }}
        ) as Endocrina,
        index as id,
        Hematologica,
        Cardíaca
    from {{ source("etl_adt", "bronze_data") }}
    inner join hematologica_cleaned as h
    on h.id = index
),
gastroinstestinal_cleaned as (
    select (
            {{ transform_bool("Gastrointestinal", "bronze_data") }}
        ) as Gastrointestinal,
        index as id,
        Hematologica,
        Cardíaca,
        Endocrina
    from {{ source("etl_adt", "bronze_data") }}
    inner join endocrina_cleaned as e
    on e.id = index
),
hepatopatia_cleaned as (
    select (
            {{ transform_bool("Hepatopatía crónica", "bronze_data") }}
        ) as Hepatopatía crónica,
        index as id
    from {{ source("etl_adt", "bronze_data") }}
),
neurologica_cleaned as (
    select (
            {{ transform_bool("Neurológica", "bronze_data") }}
        ) as Neurológica,
        index as id
    from {{ source("etl_adt", "bronze_data") }}
),
pulmonar_cleaned as (
    select (
            {{ transform_bool("Pulmonar", "bronze_data") }}
        ) as Pulmonar,
        index as id
    from {{ source("etl_adt", "bronze_data") }}
)
renal_cleaned as (
    select (
            {{ transform_bool("Renal", "bronze_data") }}
        ) as Renal,
        index as id
    from {{ source("etl_adt", "bronze_data") }}
),
trombofilia_cleaned as (
    select (
            {{ transform_bool("Trombofilia", "bronze_data") }}
        ) as Trombofilia,
        index as id
    from {{ source("etl_adt", "bronze_data") }}
),
urologica_cleaned as (
    select (
            {{ transform_bool("Urológica", "bronze_data") }}
        ) as Urológica,
        index as id
    from {{ source("etl_adt", "bronze_data") }}
),
vascular_cleaned as (
    select (
        {{ transform_bool("Vascular", "bronze_data") }}
    ) as Vascular,
        index as id
    from {{ source("etl_adt", "bronze_data") }}
)

select
    src.index as id,
    Hematologica,
    Cardíaca,
    Endocrina,
    Gastrointestinal,
    Hepatopatía crónica,
    Neurológica,
    Pulmonar,
    Renal,
    Trombofilia,
    Urológica,
    Vascular,
    VIH,
    Diabetes Mellitus,
    Enfermedad coronaria,
    Hipertensión arterial
from {{ source("etl_adt", "bronze_data") }} as src
inner join  hematologica_cleaned as h
    on src.index = h.id
inner join cardiaca_cleaned as c
    on h.id = c.id
inner join endocrina_cleaned as e
    on h.id = e.id
inner join gastroinstestinal_cleaned as g
    on h.id = g.id
inner join hepatopatia_cleaned as he
    on h.id = he.id
inner join neurologica_cleaned as n
    on h.id = n.id
inner join pulmonar_cleaned as p
    on h.id = p.id
inner join renal_cleaned as r
    on h.id = r.id
inner join trombofilia_cleaned as t
    on h.id = t.id
inner join urologica_cleaned as u
    on h.id = u.id
inner join vascular_cleaned as v
    on h.id = v.id