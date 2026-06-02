{% macro transform_comma_dot(column) %}
    cast(replace({{ column }}, ",", ".") as numeric)
{% endmacro %}