select
    index as id,
    trim(upper("Género")) as genero,
    "Edad" as edad,
    "Frecuencia respiratoria" as frecuencia_respiratoria,
    "WBC" as wbc,
    "Saturación de la sangre" as saturacion_sangre,
    "Frecuencia cardíaca" as frecuencia_cardiaca,
    "Presión sistólica" as presion_sistolica,
    "Presión diastólica" as presion_diastolica,
    "TEP" as tep,

    case
        when "Fiebre" is null then null
        when "Fiebre" in (0,1) then "Fiebre"
        when "Fiebre" >= 38 then 1
        else 0
    end as fiebre,
    cast(
        replace(
            replace("PLT", 'OO', '00'), ',', '.'
        ) as numeric
    ) as plt,
    {{ transform_comma_dot('"HB"') }} as hb,

    {{ transform_bool('"Fumador"') }} as fumador,
    {{ transform_bool('"Bebedor"') }} as bebedor,
    {{ transform_bool('"Procedimiento Quirurgicos / Traumatismo Grave en los últimos 15 dias"') }} as proc_quirurgico_traumatismo,
    {{ transform_bool('"Inmovilidad de M inferiores"') }} as inmovilidad_m_inferiores,
    {{ transform_bool('"Viaje prolongado"') }} as viaje_prolongado,
    {{ transform_bool('"TEP - TVP Previo"') }} as tep_tvp_previo,
    {{ transform_bool('"Malignidad"') }} as malignidad,
    {{ transform_bool('"Disnea"') }} as disnea,
    {{ transform_bool('"Dolor toracico"') }} as dolor_toracico,
    {{ transform_bool('"Tos"') }} as tos,
    {{ transform_bool('"Hemoptisis"') }} as hemoptisis,
    {{ transform_bool('"Síntomas disautonomicos"') }} as sintomas_disautonomicos,
    {{ transform_bool('"Edema de M inferiores"') }} as edema_m_inferiores,
    {{ transform_bool('"Crepitaciones"') }} as crepitaciones,
    {{ transform_bool('"Sibilancias"') }} as sibilancias,
    {{ transform_bool('"Soplos"') }} as soplos,
    {{ transform_bool('"Derrame"') }} as derrame,
    {{ transform_bool('"Hematologica"') }} as enfermedad_hematologica,
    {{ transform_bool('"Cardíaca"') }} as enfermedad_cardiaca,
    {{ transform_bool('"Endocrina"') }} as enfermedad_endocrina,
    {{ transform_bool('"Gastrointestinal"') }} as enfermedad_gastrointestinal,
    {{ transform_bool('"Hepatopatía crónica"') }} as enfermedad_hepatopatia_cronica,
    {{ transform_bool('"Neurológica"') }} as enfermedad_neurologica,
    {{ transform_bool('"Pulmonar"') }} as enfermedad_pulmonar,
    {{ transform_bool('"Renal"') }} as enfermedad_renal,
    {{ transform_bool('"Trombofilia"') }} as enfermedad_trombofilia,
    {{ transform_bool('"Urológica"') }} as enfermedad_urologica,
    {{ transform_bool('"Vascular"') }} as enfermedad_vascular,
    
    cast("VIH" as int) as enfermedad_vih,
    cast("Diabetes Mellitus" as int) as enfermedad_diabetes_mellitus,
    cast("Enfermedad coronaria" as int) as enfermedad_coronaria,
    cast("Hipertensión arterial" as int) as enfermedad_hipertension_arterial
from {{ source('etl_adt', 'bronze_data')}}