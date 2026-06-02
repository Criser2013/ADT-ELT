{% macro transform_null_binary(relation, column_name) %}
coalesce(
    {{ column_name }},
    (
        select {{ column_name }}
        from {{ relation }}
        where {{ column_name }} is not null
        group by {{ column_name }}
        order by count(*) desc
        limit 1
    )
)
{% endmacro %}