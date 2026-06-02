with hematologica_cleaned as (
    select (
        {{ transform_bool("Hematologica", "bronze_data") }}
    ) as Hematologica
),
cardiaca_cleaned as (
    select (
        {{ transform_bool("Cardíaca", "bronze_data") }}
    ) as Cardíaca
),
endocrina_cleaned as (
    select (
        {{ transform_bool("Endocrina", "bronze_data") }}
    ) as Endocrina
),
gastroinstestinal_cleaned as (
    select (
        {{ transform_bool("Gastrointestinal", "bronze_data") }}
    ) as Gastrointestinal
),
hepatopatia_cleaned as (
    select (
        {{ transform_bool("Hepatopatía crónica", "bronze_data") }}
    ) as Hepatopatía crónica
),
neurologica_cleaned as (
    select (
        {{ transform_bool("Neurológica", "bronze_data") }}
    ) as Neurológica
),
pulmonar_cleaned as (
    select (
        {{ transform_bool("Pulmonar", "bronze_data") }}
    ) as Pulmonar
)
renal_cleaned as (
    select (
        {{ transform_bool("Renal", "bronze_data") }}
    ) as Renal
),
trombofilia_cleaned as (
    select (
        {{ transform_bool("Trombofilia", "bronze_data") }}
    ) as Trombofilia
),
urologica_cleaned as (
    select (
        {{ transform_bool("Urológica", "bronze_data") }}
    ) as Urológica
),
vascular_cleaned as (
    select (
        {{ transform_bool("Vascular", "bronze_data") }}
    ) as Vascular
)

select
    Edad,
    Frecuencia respiratoria,
    WBC,
    Saturación de la sangre,
    Frecuencia cardíaca,
    Presión sistólica,
    Presión diastólica,
    hb_cleaned as HB,
    plt_cleaned as PLT,
    Género,
    fever_binary as Fiebre,
    Fumador,
    Bebedor,
    Procedimiento Quirurgicos / Traumatismo Grave en los últimos 15 dias,
    Inmovilidad de M inferiores,
    Viaje prolongado,
    TEP - TVP Previo,
    Malignidad,
    Disnea,
    Dolor toracico,
    Tos,
    hemoptisis_cleaned as Hemoptisis,
    sintomas_disautonomicos_cleaned as Síntomas disautonomicos,
    Edema de M inferiores,
    Crepitaciones,
    sibilancias_cleaned as Sibilancias,
    soplos_cleaned as Soplos,
    derrame_cleaned as Derrame,
    Otra Enfermedad,
    hematologica_cleaned as Hematologica,
    cardiaca_cleaned as Cardíaca,
    Enfermedad coronaria,
    Diabetes Mellitus,
    endocrina_cleaned as Endocrina,
    gastrointestinal_cleaned as Gastrointestinal,
    hepatopatia_cleaned as Hepatopatía crónica,
    hipertensión arterial,
    neurologica_cleaned as Neurológica,
    pulmonar_cleaned as Pulmonar,
    renal_cleaned as Renal,
    trombofilia_cleaned as Trombofilia,
    urologica_cleaned as Urológica,
    vascular_cleaned as Vascular,
    VIH,
    TEP
from {{ source("etl_adt", "bronze_data") }}