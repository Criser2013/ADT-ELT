select
    *,
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
from {{ ref('bronze_cleaned_data') }}