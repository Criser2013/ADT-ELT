select
    id,
    fumador,
    bebedor,
    proc_quirurgico_traumatismo,
    inmovilidad_m_inferiores,
    viaje_prolongado,
    tep_tvp_previo,
    malignidad,
    disnea,
    dolor_toracico,
    tos,
    hemoptisis,
    sintomas_disautonomicos,
    edema_m_inferiores,
    crepitaciones,
    sibilancias,
    soplos,
    derrame,
    fiebre,
    edad,
    frecuencia_respiratoria,
    frecuencia_cardiaca,
    presion_sistolica,
    presion_diastolica,
    hb,
    enfermedad_hematologica,
    enfermedad_cardiaca,
    enfermedad_endocrina,
    enfermedad_gastrointestinal,
    enfermedad_hepatopatia_cronica,
    enfermedad_neurologica,
    enfermedad_pulmonar,
    enfermedad_renal,
    enfermedad_trombofilia,
    enfermedad_urologica,
    enfermedad_vascular,
    enfermedad_vih,
    enfermedad_diabetes_mellitus,
    enfermedad_coronaria,
    enfermedad_hipertension_arterial,
    tep,

    case
        when genero = 'M' then 1
        else 0
    end as genero,

    {{ scale_values("wbc", 1000) }},
    {{ scale_values("plt", 1000) }},
    {{ scale_values("saturacion_sangre", 100, 1) }},

    case
        when greatest(
            coalesce(enfermedad_hematologica,0),
            coalesce(enfermedad_cardiaca,0),
            coalesce(enfermedad_endocrina,0),
            coalesce(enfermedad_gastrointestinal,0),
            coalesce(enfermedad_hepatopatia_cronica,0),
            coalesce(enfermedad_neurologica,0),
            coalesce(enfermedad_pulmonar,0),
            coalesce(enfermedad_renal,0),
            coalesce(enfermedad_trombofilia,0),
            coalesce(enfermedad_urologica,0),
            coalesce(enfermedad_vascular,0),
            coalesce(enfermedad_vih,0),
            coalesce(enfermedad_diabetes_mellitus,0),
            coalesce(enfermedad_coronaria,0),
            coalesce(enfermedad_hipertension_arterial,0)
        ) = 1 then 1
        else 0
    end as otra_enfermedad
from {{ ref('bronze_clean') }}