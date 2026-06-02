select 
    id,
    plt,
from {{ ref('silver')}}
where plt < 100