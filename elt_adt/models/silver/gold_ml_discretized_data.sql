select
    *,
    {{ transform_null_numeric("edad")}} as edad,
    {{ transform_null_numeric("frecuencia_respiratoria")}} as frecuencia_respiratoria,
    {{ transform_null_numeric("wbc")}} as wbc,
    {{ transform_null_numeric("saturacion_sangre")}} as saturacion_sangre,
    {{ transform_null_numeric("frecuencia_cardiaca")}} as frecuencia_cardiaca,
    {{ transform_null_numeric("presion_sistolica")}} as presion_sistolica,
    {{ transform_null_numeric("presion_diastolica")}} as presion_diastolica,
    {{ transform_null_numeric("hb")}} as hb,
    {{ transform_null_numeric("plt")}} as plt,
from {{ ref("gold_ml_without_na_data") }}