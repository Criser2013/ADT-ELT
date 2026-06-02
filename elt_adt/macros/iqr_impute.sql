{%- macro iqr_impute(column_name, relation) -%}
select
    case
        when t.{{ column_name }} is null then b.q2
        when t.{{ column_name }} < b.lower_bound then b.q2
        when t.{{ column_name }} > b.upper_bound then b.q2
        else t.{{ column_name }}
    end as {{ column_name }}
from {{ relation }} t
cross join {{ get_numeric_stats(column_name, relation) }} b
{%- endmacro -%}