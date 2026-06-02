select
    index,
    Edad
from {{ source('dbt_core', 'bronze_data')}}
where Edad < 0 or Edad > 120