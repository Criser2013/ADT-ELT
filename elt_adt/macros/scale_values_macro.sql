{%- macro scale_values(column_name, factor, upper_bound=None) -%}
    {%- set ub = upper_bound if upper_bound is not none else factor -%}
    case
        when ({{ column_name }} > 0) and ({{ column_name }} < {{ ub }}) then
            {{ column_name }} * {{ factor }}
        else {{ column_name }}
    end
{%- endmacro -%}