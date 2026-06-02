{% macro transform_null_binary(column_name) %}
    coalesce(
        {{ column_name }}, 
        mode() within GROUP (order by {{ column_name }})
    )
{% endmacro %}