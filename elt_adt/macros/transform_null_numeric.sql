{%- macro transform_null_numeric(relation, column_name) -%}
    coalesce(
        {{ column_name }},
        (
            select percentile_cont(0.5) within group (order by {{ column_name }})
            from {{ relation }}
            limit 1
        )
    )
{%- endmacro -%}