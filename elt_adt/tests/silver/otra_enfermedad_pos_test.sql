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
where (otra_enfermedad = 1 and
       enfermedad_hematologica = 0 and
       enfermedad_cardiaca = 0 and
       enfermedad_endocrina = 0 and
       enfermedad_gastrointestinal = 0 and
       enfermedad_hepatopatia_cronica = 0 and
       enfermedad_neurologica = 0 and
       enfermedad_pulmonar = 0 and
       enfermedad_renal = 0 and
       enfermedad_trombofilia = 0 and
       enfermedad_urologica = 0 and
       enfermedad_vascular = 0 and
       enfermedad_vih = 0 and
       enfermedad_diabetes_mellitus = 0 and
       enfermedad_coronaria = 0 and
       enfermedad_hipertension_arterial = 0)