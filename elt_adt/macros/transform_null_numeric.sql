{% macro iqr_impute(column_name, relation) %}

with stats as (
    select
        percentile_cont(0.25) within group (order by {{ column_name }}) as q1,
        percentile_cont(0.5) within group (order by {{ column_name }}) as q2,
        percentile_cont(0.75) within group (order by {{ column_name }}) as q3
    from {{ relation }}
),
bounds as (
    select
        q1,
        q2,
        q3,
        q3 - q1 as iqr,
        q1 - 1.5 * (q3 - q1) as lower_bound,
        q3 + 1.5 * (q3 - q1) as upper_bound
    from stats
)

select
    case
        when t.{{ column_name }} is null then b.q2
        when t.{{ column_name }} < b.lower_bound then b.q2
        when t.{{ column_name }} > b.upper_bound then b.q2
        else t.{{ column_name }}
    end as {{ column_name }}
from {{ relation }} t
cross join bounds b

{% endmacro %}