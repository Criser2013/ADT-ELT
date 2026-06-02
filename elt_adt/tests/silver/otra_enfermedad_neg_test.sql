select
    id,
    otra_enfermedad
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
    enfermedad_hipertension_arterial
from {{ ref('silver') }}
where (otra_enfermedad = 0 and (
       enfermedad_hematologica = 1 or
       enfermedad_cardiaca = 1 or
       enfermedad_endocrina = 1 or
       enfermedad_gastrointestinal = 1 or
       enfermedad_hepatopatia_cronica = 1 or
       enfermedad_neurologica = 1 or
       enfermedad_pulmonar = 1 or
       enfermedad_renal = 1 or
       enfermedad_trombofilia = 1 or
       enfermedad_urologica = 1 or
       enfermedad_vascular = 1 or
       enfermedad_vih = 1 or
       enfermedad_diabetes_mellitus = 1 or
       enfermedad_coronaria = 1 or
       enfermedad_hipertension_arterial = 1))