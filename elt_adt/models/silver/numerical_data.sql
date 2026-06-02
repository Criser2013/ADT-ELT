select
    src.index as id,
    Edad,
    "Frecuencia respiratoria",
    WBC,
    "Saturación de la sangre",
    "Frecuencia cardíaca",
    "Presión sistólica",
    "Presión diastólica",
    {{ transform_comma_dot("HB") }} as HB,
    cast(
        replace(
            replace(PLT, "OO", "00"), ",", "."
        ) as numeric
    )
from {{ source("etl_adt", "bronze_data") }} src