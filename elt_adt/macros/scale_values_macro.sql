{%- macro scale_values (column_name, factor, upper_bound = None) -%}
    {%- if upper_bound is None -%}
        {%- set upper_bound = factor -%}
    {%- endif -%}
    case
        when ({{ column_name }} > 0) and ({{ column_name }} < {{ upper_bound }}) then
            {{ column_name }} * {{ factor }}
        else {{ column_name }}
    end
{%- endmacro -%}