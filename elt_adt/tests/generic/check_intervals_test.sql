{%- test check_intervals(relation, column_name, id_field, lower_bound, upper_bound) -%}
select
    {{ id_field }},
    {{ column_name }}
from {{ relation }} t
where {{ column_name }} < lower_bound
   or {{ column_name }} > upper_bound
{%- endtest -%}