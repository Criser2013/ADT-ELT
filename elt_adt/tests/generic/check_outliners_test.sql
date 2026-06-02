{%- test check_outliners(model, column_name, id_field) -%}
select
    {{ id_field }},
    {{ column_name }}
from {{ model }} t
where {{ column_name }} < b.lower_bound
   or {{ column_name }} > b.upper_bound
cross join {{ get_numeric_stats(column_name, model) }} b
{%- endtest -%}