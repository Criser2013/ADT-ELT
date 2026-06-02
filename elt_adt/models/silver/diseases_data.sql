select
    index as id,
    {{ transform_bool("Hematologica") }} as Hematologica,
    {{ transform_bool("Cardíaca") }} as Cardíaca,
    {{ transform_bool("Endocrina") }} as Endocrina,
    {{ transform_bool("Gastrointestinal") }} as Gastrointestinal,
    {{ transform_bool("Hepatopatía crónica") }} as Hepatopatía crónica,
    {{ transform_bool("Neurológica") }} as Neurológica,
    {{ transform_bool("Pulmonar") }} as Pulmonar,
    {{ transform_bool("Renal") }} as Renal,
    {{ transform_bool("Trombofilia") }} as Trombofilia,
    {{ transform_bool("Urológica") }} as Urológica,
    {{ transform_bool("Vascular") }} as Vascular,
    cast(VIH as int),
    cast("Diabetes Mellitus" as int),
    cast("Enfermedad coronaria" as int),
    cast("Hipertensión arterial" as int)
from {{ source("etl_adt", "bronze_data") }}