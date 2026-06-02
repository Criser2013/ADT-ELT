select
    index as id,
    {{ transform_bool('Fumador') }} as Fumador,
    {{ transform_bool('Bebedor') }} as Bebedor,
    {{ transform_bool('Procedimiento Quirurgicos / Traumatismo Grave en los últimos 15 dias') }} as "Procedimiento Quirurgicos / Traumatismo Grave en los últimos 15 dias",
    {{ transform_bool('Inmovilidad de M inferiores') }} as "Inmovilidad de M inferiores",
    {{ transform_bool('Viaje prolongado') }} as "Viaje prolongado",
    {{ transform_bool('TEP - TVP Previo') }} as "TEP - TVP Previo",
    {{ transform_bool('Malignidad') }} as Malignidad,
    {{ transform_bool('Disnea') }} as Disnea,
    {{ transform_bool('Dolor toracico') }} as "Dolor toracico",
    {{ transform_bool('Tos') }} as Tos,
    {{ transform_bool('Hemoptisis') }} as Hemoptisis,
    {{ transform_bool('Síntomas disautonomicos') }} as "Síntomas disautonomicos",
    {{ transform_bool('Edema de M inferiores') }} as "Edema de M inferiores",
    {{ transform_bool('Crepitaciones') }} as Crepitaciones,
    {{ transform_bool('Sibilancias') }} as Sibilancias,
    {{ transform_bool('Soplos') }} as Soplos,
    {{ transform_bool('Derrame') }} as Derrame,
    cast((
        case
            when Fiebre >= 38 then 1
            when Fiebre is null then null
            else 0
        end
     ) as int) as Fiebre

from {{ source('etl_adt', 'bronze_data')}}