{%- test check_outliners(relation, column_name, id_field) -%}
select
    {{ id_field }},
    {{ column_name }}
from {{ relation }} t
where {{ column_name }} < b.lower_bound
   or {{ column_name }} > b.upper_bound
cross join {{ get_numeric_stats(column_name, relation) }} b
{%- endtest -%}