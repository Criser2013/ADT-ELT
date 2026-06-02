{% macro get_numeric_stats(column_name, relation) %}
with stats as (
    select
        avg({{ column_name }}) as mean,
        min({{ column_name }}) as min,
        max({{ column_name }}) as max,
        stdev_samp({{ column_name }}) as std,
        var_samp({{ column_name }}) as var,
        count({{ column_name }}) as count,
        count(select id from {{ relation }} where {{ column_name }} is null) as null_count,
        percentile_cont(0.25) within group (order by {{ column_name }}) as q1,
        percentile_cont(0.5) within group (order by {{ column_name }}) as q2,
        percentile_cont(0.75) within group (order by {{ column_name }}) as q3
    from {{ relation }}
),

select
    *,
    q3 - q1 as iqr,
    q1 - 1.5 * (q3 - q1) as lower_bound,
    q3 + 1.5 * (q3 - q1) as upper_bound
from stats
{% endmacro %}