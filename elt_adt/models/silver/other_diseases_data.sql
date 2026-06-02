select
    *,
    case
    when greatest(
        coalesce(Hematologica,0),
        coalesce(Cardíaca,0),
        coalesce(Endocrina,0),
        coalesce(Gastrointestinal,0),
        coalesce("Hepatopatía crónica",0),
        coalesce(Neurológica,0),
        coalesce(Pulmonar,0),
        coalesce(Renal,0),
        coalesce(Trombofilia,0),
        coalesce(Urológica,0),
        coalesce(Vascular,0),
        coalesce(VIH,0),
        coalesce("Diabetes Mellitus",0),
        coalesce("Enfermedad coronaria",0),
        coalesce("Hipertensión arterial",0)
    ) = 1
    then 1
    else 0
end as otra_enfermedad
from {{ ref("diseases_data") }}