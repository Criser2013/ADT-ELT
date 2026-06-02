select
    index,
    Edad
from {{ source('elt_adt', 'bronze_data')}}
where Edad < 0 or Edad > 120