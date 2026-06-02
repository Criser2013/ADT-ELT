select 
    id,
    saturacion_sangre,
from {{ ref('silver')}}
where saturacion_sangre < 0 or saturacion_sangre > 100